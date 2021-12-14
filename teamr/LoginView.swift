//
//  LoginView.swift
//  teamr
//
//  Created by Erika Tan on 12/13/21.
//

import SwiftUI
import FirebaseAuth

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
            .textFieldStyle(CustomTextField())
            TextField(
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
            .textFieldStyle(CustomTextField())
            TextField(
                "Phone Number",
                text: $phone
            )
            .textFieldStyle(CustomTextField())
            TextField(
                "Password",
                text: $password
            )
            .textFieldStyle(CustomTextField())
        }
        .padding(.top)
        RadioButtonGroup(items: ["I am a student", "I am an instructor"], selectedId: "") { selected in
            print("Selected is: \(selected)")
        }
        .padding()
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
    @EnvironmentObject var settings: UserSettings
    
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
                                settings.loggedIn = true
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
                    Button(action: {
                        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            if error == nil {
                                settings.loggedIn = true
                            }
                        }
                    }) {
                        Text("REGISTER")
                    }
                    .buttonStyle(FilledButton())
                    .padding()
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
