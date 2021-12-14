//
//  StartView.swift
//  teamr
//
//  Created by Erika Tan on 12/13/21.
//

import SwiftUI

class UserSettings: ObservableObject {
    @Published var loggedIn : Bool = false
}

struct StartView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        if settings.loggedIn {
            TeamrTabView()
                .environmentObject(settings)
        } else {
            HomeView()
                .environmentObject(settings)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
