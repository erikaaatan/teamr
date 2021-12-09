//
//  TextStyles.swift
//  teamr
//
//  Created by Erika Tan on 12/7/21.
//

import SwiftUI

struct FilledText: View {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
        .font(.system(size: 14))
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color("cedarChest"))
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

struct OutlineText: View {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.system(size: 14))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                ).stroke(Color("cedarChest"), lineWidth: 2)
            )
            .foregroundColor(Color("cedarChest"))
            .padding()
    }
}

struct ClassText: View {
    private let text: String

    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 14))
            .padding()
            .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.95)
            .foregroundColor(.black)
            .background(
                RoundedRectangle(
                    cornerRadius: 8
                )
                .fill(Color.white)
                .shadow(color: .gray, radius: 2, x: 4, y: 4)
            )
    }
}
