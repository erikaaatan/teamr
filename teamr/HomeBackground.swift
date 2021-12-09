//
//  HomeBackground.swift
//  teamr
//
//  Created by Erika Tan on 12/2/21.
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

struct HomeBackground_Previews: PreviewProvider {
    static var previews: some View {
        HomeBackground()
    }
}
