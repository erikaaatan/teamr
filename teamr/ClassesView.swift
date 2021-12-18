//
//  ClassesView.swift
//  teamr
//
//  Created by Erika Tan on 12/4/21.
//

import SwiftUI
import Firebase

class ActiveClass: ObservableObject {
    @Published var showingClass: Class?
}

struct ClassesView: View {
    @State private var showingAlert = false
    @State private var alertInput = ""
    @EnvironmentObject var currentUser: User
    let db = Firestore.firestore()
    
    var body: some View {
        ZStack {
            Color("lavenderBlush")
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(radius: 40, corners: [.bottomLeft, .bottomRight])
                        .frame(height: 400)
                    Image("SitReadingDoodle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    Text("Classes")
                        .offset(x: -80, y: 160)
                        .font(.custom("JosefinSans-Regular", size: 48))
                }
                
                Spacer()
                Button(action: {
                    self.showingAlert = true
                }) {
                    Text(currentUser.role == .student ? "JOIN CLASS": "CREATE CLASS")
                }
                .alert(isPresented: $showingAlert,
                        TextAlert(
                            title: currentUser.role == .student ? "Join Class": "Create Class",
                            placeholder: currentUser.role == .student ? "Class Code": "Class Name",
                            action: {
                                guard $0 != nil else {
                                    return
                                }
                                var classObj: Class?
                                if currentUser.role == .instructor {
                                    classObj = Class(name: $0!, owner: currentUser.name)
                                    FirebaseHelper.addClass(name: classObj!.name, code: classObj!.code, owner: currentUser.name)
                                    currentUser.classes.append(classObj!)
                                    FirebaseHelper.addClassToUser(className: classObj!.name, userEmail: currentUser.email)
                                }
                                else {
                                    db.collection("classes").whereField("code", isEqualTo: $0)
                                        .getDocuments() { (querySnapshot, err) in
                                            if let err = err {
                                                print("Error getting documents: \(err)")
                                            }
                                            else {
                                                print("found class that matches")
                                                let data = querySnapshot!.documents[0].data()
                                                classObj = FirebaseHelper.getClassInstance(data: data)
                                                currentUser.classes.append(classObj!)
                                                FirebaseHelper.addClassToUser(className: classObj!.name, userEmail: currentUser.email)
                                                FirebaseHelper.addUserToClass(className: classObj!.name, userEmail: currentUser.email)
                                            }
                                        }
                                }
                                print("Callback \($0 ?? "<cancel>")")
                }))
                .frame(maxHeight: 50)
                .buttonStyle(FilledButton())
                .padding()
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(currentUser.classes) {cl in
                            NavigationLink(destination: ClassDetailsView(showingClass: cl)
                                            .navigationBarTitle("", displayMode: .inline)) {
                                ClassText(cl.name)
                                    .padding(.top)
                                    .padding(.leading)
                                    .padding(.trailing)
                            }
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ClassesView_Previews: PreviewProvider {
    static var previews: some View {
        ClassesView()
    }
}
