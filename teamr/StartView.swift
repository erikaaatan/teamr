//
//  StartView.swift
//  teamr
//
//  Created by Erika Tan on 12/13/21.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var currentUser: User
    @EnvironmentObject var config: CarouselConfig
    
    var body: some View {
        if currentUser.loggedIn {
            TeamrTabView()
                .environmentObject(config)
                .environmentObject(currentUser)
        } else {
            HomeView()
                .environmentObject(currentUser)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
