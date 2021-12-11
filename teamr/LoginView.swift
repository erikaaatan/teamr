//
//  LoginView.swift
//  teamr
//
//  Created by Erika Tan on 12/2/21.
//

import SwiftUI

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
    @State public var selected = 0
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            LoginBackground()
            VStack {
                CustomSegmentedPicker(selected: $selected)
                    .frame(height: 150)
                if selected == 0 {
                    LoginOnlyView(email: $email, password: $password)
                } else {
                    RegisterOnlyView(name: $name, email: $email, phone: $phone, password: $password)
                }
                NavigationLink(destination:
                                TeamrTabView()
                                .navigationBarBackButtonHidden(true)) {
                    FilledText(selected == 0 ? "LOGIN" : "REGISTER")
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
