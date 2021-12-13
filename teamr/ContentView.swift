//
//  ContentView.swift
//  teamr
//
//  Created by Erika Tan on 12/1/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
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
                    NavigationLink(
                        destination: LoginView(selected: 0)) {
                        OutlineText("LOG IN")
                    }
                    .buttonStyle(PlainButtonStyle())
                    NavigationLink(
                        destination: LoginView(selected: 1)) {
                        FilledText("REGISTER")
                            .padding(.leading)
                            .padding(.trailing)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
