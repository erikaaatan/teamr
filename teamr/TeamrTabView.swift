//
//  ClassDirectory.swift
//  teamr
//
//  Created by Erika Tan on 12/4/21.
//

import SwiftUI

struct TeamrTabView: View {
    @EnvironmentObject var currentUser: User
    @EnvironmentObject var config: CarouselConfig
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color.white) // custom color.
    }
    
    var body: some View {
        TabView {
            NavigationView {
                ClassesView()
                    .environmentObject(currentUser)
            }
            .tabItem {
                Label("Classes", systemImage: "house")
            }
            ProfileView(user: currentUser)
                .environmentObject(config)
                .environmentObject(currentUser)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .accentColor(Color("rawSienna"))
    }
}

//struct TeamrTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamrTabView()
//    }
//}
