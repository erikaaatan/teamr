//
//  LoginView.swift
//  teamr
//
//  Created by Erika Tan on 12/13/21.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct LoginBackground: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                CustomCircle()
                    .frame(width: 100, height: 100)
                CustomCircle()
                    .frame(width: 200, height: 200)
                CustomCircle()
                    .frame(width: 300, height: 300)
            }
            .offset(y: 150)
        }
    }
}

struct LoginOnlyView: View {
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack {
            TextField(
                "Email",
                text: $email
            )
            .autocapitalization(.none)
            .textFieldStyle(CustomTextField())
            SecureField(
                "Password",
                text: $password
            )
            .textFieldStyle(CustomTextField())
        }
        .padding(.top)
    }
}

struct RegisterOnlyView: View {
    @Binding var name: String
    @Binding var email: String
    @Binding var phone: String
    @Binding var password: String
    
    var body: some View {
        VStack {
            TextField(
                "Full Name",
                text: $name
            )
            .textFieldStyle(CustomTextField())
            TextField(
                "Email",
                text: $email
            )
            .autocapitalization(.none)
            .textFieldStyle(CustomTextField())
            TextField(
                "Phone Number",
                text: $phone
            )
            .textFieldStyle(CustomTextField())
            SecureField(
                "Password",
                text: $password
            )
            .textFieldStyle(CustomTextField())
        }
        .padding(.top)
    }
}


struct LoginView: View {
    @State private var selected = 0
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    @State private var alertError = false
    @State private var alertMessage = ""
    @State private var userRole: Role = .none
    @EnvironmentObject var settings: UserSettings
    let db = Firestore.firestore()
    
    init(selectedConfig: Int) {
        self._selected = State(initialValue: selectedConfig)
    }
    
    var body: some View {
        ZStack {
            LoginBackground()
            VStack {
                CustomSegmentedPicker(selected: $selected)
                if selected == 0 {
                    LoginOnlyView(email: $email, password: $password)
                    Button(action: {
                        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                            if error == nil {
                                db.collection("users").whereField("email", isEqualTo: email)
                                    .getDocuments() { (querySnapshot, err) in
                                        if let err = err {
                                            print("Error getting documents: \(err)")
                                        }
                                        else {
                                            let doc = querySnapshot!.documents[0]
                                            let classIndex = doc.data()["classes"] as! [String: Bool]
                                            
                                            var classes: [Class] = []
                                            let group = DispatchGroup()
                                            for cl in classIndex.keys {
                                                group.enter()
                                                db.collection("classes").whereField("name", isEqualTo: cl)
                                                    .getDocuments() { (querySnapshot, err) in
                                                        if let err = err {
                                                            print("Error getting documents: \(err)")
                                                        }
                                                        else {
                                                            print("found class that matches")
                                                            let data = querySnapshot!.documents[0].data()
                                                            classes.append(Class(name: data["name"] as! String, owner: data["owner"] as! String))
                                                        }
                                                        group.leave()
                                                    }
                                            }
                                            group.notify(queue: .main) {
                                                let user = User(
                                                    name: doc.data()["name"] as! String,
                                                    email: doc.data()["email"] as! String,
                                                    phone: doc.data()["phone"] as! String,
                                                    role: (doc.data()["role"] as! String) == "student" ? .student : .instructor,
                                                    color: Color(doc.data()["color"] as! String),
                                                    classes: classes)
                                                settings.currentUser = user
                                                settings.loggedIn = true
                                            }
                                        }
                                    }
                            }
                            else {
                                alertMessage = error!.localizedDescription
                                alertError.toggle()
                            }
                        }
                    }) {
                        Text("LOG IN")
                    }
                    .buttonStyle(FilledButton())
                    .padding()
                    .alert(isPresented: $alertError) {
                        Alert(
                            title: Text("Login Error"),
                            message: Text(alertMessage)
                        )
                    }
                } else {
                    RegisterOnlyView(name: $name, email: $email, phone: $phone, password: $password)
                    RadioButtonGroup(items: ["I am a student", "I am an instructor"], selectedId: "") { selected in
                        userRole = selected == "I am a student" ? .student : .instructor
                        print("Selected is: \(selected)")
                    }
                    .padding()
                    Button(action: {
                        guard name != "", email != "", phone != "", password != "", userRole != .none else {
                            alertMessage = "One or more fields are empty"
                            alertError.toggle()
                            return
                        }
                        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            if error == nil {
                                let newUser = User(name: name, email: email, phone: phone, role: userRole)
                                FirebaseHelper.addUser(name: name, email: email, phone: phone, role: userRole == .student ? "student" : "instructor", color: newUser.colorName)
                                settings.currentUser = newUser
                                settings.loggedIn = true
                            }
                            else {
                                alertMessage = error!.localizedDescription
                                alertError.toggle()
                            }
                        }
                    }) {
                        Text("REGISTER")
                    }
                    .buttonStyle(FilledButton())
                    .padding()
                    .alert(isPresented: $alertError) {
                        Alert(
                            title: Text("Register Error"),
                            message: Text(alertMessage)
                        )
                    }
                }
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(selectedConfig: 0)
    }
}
