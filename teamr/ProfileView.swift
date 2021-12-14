//
//  ProfileView.swift
//  teamr
//
//  Created by Erika Tan on 12/11/21.
//

import SwiftUI
import FirebaseAuth

struct ProfileBackground: View {
    var user: User?
    
    var body: some View {
        ZStack {
            UserNameText(self.user!)
                .scaleEffect(3)
            CustomCircle(color: self.user!.color!)
                .frame(width: 200, height: 200)
            CustomCircle(color: self.user!.color!)
                .frame(width: 300, height: 300)
        }
        .offset(y: -100)
    }
}

struct ProfileView: View {
    @EnvironmentObject var settings: UserSettings
    @State private var alertError = false
    @State private var alertMessage = ""
    @EnvironmentObject var config: CarouselConfig
    var user: User
    
    var body: some View {
        ZStack {
            VStack {
                ProfileBackground(user: user)
                Spacer()
            }
            VStack {
                Spacer()
                Text(user.name)
                    .font(.custom("JosefinSans-Regular", size: 48))
                Carousel(spacing: 10) {
                    CarouselCard {
                        VStack {
                            Image("ReadingDoodle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 170, height: 140)
                                .padding(.top)
                            Text("Classes")
                                .padding(.bottom)
                        }
                        .background(
                            RoundedRectangle(
                                cornerRadius: 8,
                                style: .continuous
                            )
                            .strokeBorder(Color("cedarChest"), lineWidth: 2)
                            .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color.white))
                        )
                    }
                    CarouselCard {
                        VStack {
                            Image("SelfieDoodle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 170, height: 140)
                                .padding(.top)
                            Text("Contact")
                                .padding(.bottom)
                        }
                        .background(
                            RoundedRectangle(
                                cornerRadius: 8,
                                style: .continuous
                            )
                            .strokeBorder(Color("cedarChest"), lineWidth: 2)
                            .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color.white))
                        )
                    }
                    CarouselCard {
                        VStack {
                            Image("LovingDoodle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 170, height: 140)
                                .padding(.top)
                            Text("Settings")
                                .padding(.bottom)
                        }
                        .background(
                            RoundedRectangle(
                                cornerRadius: 8,
                                style: .continuous
                            )
                            .strokeBorder(Color("cedarChest"), lineWidth: 2)
                            .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color.white))
                        )
                    }
                }
                .environmentObject(config)
                .frame(height: 220)
                
                ScrollView {
                    VStack {
                        if config.selected == 0 {
                            ForEach(user.classes) { userClass in
                                ProfileText(title: userClass.name, message: "Not placed into a group yet")
                            }
                        }
                        else if config.selected == 1 {
                            ProfileText(title: "Email", message: user.email)
                            ProfileText(title: "Phone Number", message: user.phone)
                        }
                        else {
                            Button(action: {
                                let firebaseAuth = Auth.auth()
                                do {
                                    try firebaseAuth.signOut()
                                    self.settings.loggedIn = false
                                } catch let error as NSError {
                                    alertMessage = error.localizedDescription
                                    alertError.toggle()
                                }
                            }) {
                                Text("LOG OUT")
                            }
                            .buttonStyle(FilledButton())
                            .padding()
                            .alert(isPresented: $alertError) {
                                Alert(
                                    title: Text("Login Error"),
                                    message: Text(alertMessage)
                                )
                            }
                        }
                    }
                }
                .frame(height: 300)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(
                        name: "Erika Tan",
                        email: "eatan18@gmail.com",
                        phone: "7328582423",
                        role: .student,
                        classes: [
                            Class(name: "Test Class Name1", owner: User(name: "teacher", email: "email", phone: "phone", role: .instructor, classes: [])),
                            Class(name: "Test Class Name2", owner: User(name: "teacher", email: "email", phone: "phone", role: .instructor, classes: [])),
                            Class(name: "Test Class Name3", owner: User(name: "teacher", email: "email", phone: "phone", role: .instructor, classes: []))
                        ]))
            .environmentObject(CarouselConfig())
    }
}
