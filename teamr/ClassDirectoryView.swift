//
//  ClassDirectory.swift
//  teamr
//
//  Created by Erika Tan on 12/4/21.
//

import SwiftUI

struct TeamrTabView: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color.white) // custom color.
    }
    
    var body: some View {
        TabView {
            ClassesView()
                .tabItem {
                    Label("Classes", systemImage: "house")
                }
//            .tabItem {
//                    Label("Join Class", systemImage: "list.dash")
//            }
            Text("profile")
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .accentColor(Color("rawSienna"))
    }
}

struct ClassDirectoryView_Previews: PreviewProvider {
    static var previews: some View {
        TeamrTabView()
    }
}
