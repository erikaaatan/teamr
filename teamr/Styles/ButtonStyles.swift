//
//  ButtonStyles.swift
//  teamr
//
//  Created by Erika Tan on 12/4/21.
//

import SwiftUI

struct FilledButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 14))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(configuration.isPressed ? .gray : .white)
            .background(isEnabled ? Color("cedarChest") : .gray)
            .cornerRadius(8)
    }
}

struct OutlineButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 14))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(configuration.isPressed ? .gray : Color("cedarChest"))
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                ).stroke(Color("cedarChest"), lineWidth: 2)
            )
            .padding()
    }
}

struct ClassButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 14))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                ).fill(Color.white)
                .shadow(color: .gray, radius: 2, x: 4, y: 4)
            )
    }
}
