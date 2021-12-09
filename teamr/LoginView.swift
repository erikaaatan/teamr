//
//  LoginView.swift
//  teamr
//
//  Created by Erika Tan on 12/2/21.
//

import SwiftUI

struct LoginView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            LoginBackground()
            VStack {
                HStack {
                    Button("LOG IN") {
                        
                    }
                    Button("REGISTER") {
                        
                    }
                }
                .frame(minHeight: 0, maxHeight: 150)
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
                NavigationLink(destination:
                                TeamrTabView()
                                .navigationBarBackButtonHidden(true)) {
                    FilledText("REGISTER")
                        .padding()
                }
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
