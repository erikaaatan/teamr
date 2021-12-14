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

struct HomeView: View {
    @EnvironmentObject var settings: UserSettings
    
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
                    NavigationLink(destination: LoginView(selectedConfig: 0).environmentObject(settings)) {
                        OutlineText("LOG IN")
                    }
                    NavigationLink(destination: LoginView(selectedConfig: 1).environmentObject(settings)) {
                        FilledText("REGISTER")
                        .padding(.leading)
                        .padding(.trailing)
                    }
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
