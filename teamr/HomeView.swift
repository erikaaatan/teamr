//
//  ContentView.swift
//  teamr
//
//  Created by Erika Tan on 12/1/21.
//

import SwiftUI

struct HomeBackground: View {
    var body: some View {
        ZStack {
            Text("t")
                .font(.custom("Josefin Slab Bold", size: 64)).foregroundColor(Color(#colorLiteral(red: 0.92, green: 0.55, blue: 0.33, alpha: 1)))
                .multilineTextAlignment(.center)
            CustomCircle()
                .frame(width: 100, height: 100)
            CustomCircle()
                .frame(width: 200, height: 200)
            CustomCircle()
                .frame(width: 300, height: 300)
            //            CustomCircle()
            //                .frame(width: 400, height: 400)
        }
        .offset(y: -150)
    }
}

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

struct HomeView: View {
    @State private var selected = 0
    @State private var currScreen = 0
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            if currScreen == 0 {
                ZStack {
                    HomeBackground()
                    VStack {
                        Spacer()
                        Text("teamr")
                            .foregroundColor( Color("cedarChest"))
                            .font(.custom("JosefinSlab-Bold", size: 48))
                        Text("Group building, maintainance, and peer reviews for any class.")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14))
                            .padding()
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.01)) {
                                self.selected = 0
                                self.currScreen = 1
                            }
                        }) {
                            Text("LOG IN")
                        }
                        .buttonStyle(OutlineButton())
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.01)) {
                                self.selected = 1
                                self.currScreen = 1
                            }
                        }) {
                            Text("REGISTER")
                        }
                            .buttonStyle(FilledButton())
                            .padding(.leading)
                            .padding(.trailing)
                    }
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                }
            }
            else if currScreen == 1 {
                ZStack {
                    LoginBackground()
                    VStack {
                        CustomSegmentedPicker(selected: $selected)
                        if selected == 0 {
                            LoginOnlyView(email: $email, password: $password)
                        } else {
                            RegisterOnlyView(name: $name, email: $email, phone: $phone, password: $password)
                        }
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.01)) {
                                self.selected = 1
                                self.currScreen = 2
                            }
                        }) {
                            Text(selected == 0 ? "LOG IN" : "REGISTER")
                        }
                            .buttonStyle(FilledButton())
                            .padding()
                        Spacer()
                    }
                }
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            }
            else {
                TeamrTabView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
