//
//  ClassDirectory.swift
//  teamr
//
//  Created by Erika Tan on 12/4/21.
//

import SwiftUI

struct TeamrTabView: View {
    @EnvironmentObject var settings: UserSettings
    let user = User(
        name: "Erika Tan",
        email: "eatan18@gmail.com",
        phone: "7328582423",
        role: .student,
        classes: [
            Class(name: "Test Class Name1", owner: User(name: "teacher", email: "email", phone: "phone", role: .instructor, classes: [])),
            Class(name: "Test Class Name2", owner: User(name: "teacher", email: "email", phone: "phone", role: .instructor, classes: [])),
            Class(name: "Test Class Name3", owner: User(name: "teacher", email: "email", phone: "phone", role: .instructor, classes: []))
    ])
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color.white) // custom color.
    }
    
    var body: some View {
        TabView {
            NavigationView {
                ClassesView()
            }
            .tabItem {
                Label("Classes", systemImage: "house")
            }
            ProfileView(user: self.user)
                .environmentObject(CarouselConfig())
                .environmentObject(settings)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .accentColor(Color("rawSienna"))
    }
}

struct TeamrTabView_Previews: PreviewProvider {
    static var previews: some View {
        TeamrTabView()
    }
}
