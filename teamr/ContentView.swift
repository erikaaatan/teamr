//
//  ContentView.swift
//  teamr
//
//  Created by Erika Tan on 12/1/21.
//

import SwiftUI

struct ContentView: View {
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
                        destination: LoginView()) {
                        OutlineText("LOG IN")
                    }
                    .buttonStyle(PlainButtonStyle())
                    NavigationLink(
                        destination: LoginView()) {
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
        ContentView()
    }
}
