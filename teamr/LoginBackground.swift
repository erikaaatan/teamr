//
//  LoginBackground.swift
//  teamr
//
//  Created by Erika Tan on 12/4/21.
//

import SwiftUI

struct LoginBackground: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color("lavenderBlush"))
                .cornerRadius(radius: 40, corners: [.bottomLeft, .bottomRight])
                .frame(height: 100)
            Spacer()
            ZStack {
                CustomCircle()
                    .frame(width: 100, height: 100)
                CustomCircle()
                    .frame(width: 200, height: 200)
                CustomCircle()
                    .frame(width: 300, height: 300)
            }
            .offset(y: 150)
        }
    }
}

struct LoginBackground_Previews: PreviewProvider {
    static var previews: some View {
        LoginBackground()
    }
}
