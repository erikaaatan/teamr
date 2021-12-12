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

struct UserText: View {
    private let user: User

    init(_ user: User) {
        self.user = user
    }
    
    var body: some View {
        HStack {
            UserNameText(user)
                .padding()
            Text(user.name)
                .font(.system(size: 18))
                .padding()
            Spacer()
        }
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
                .stroke(user.color!, lineWidth: 2)
            )
            .padding()
    }
}

struct UserNameText: View {
    private let user: User

    init(_ user: User) {
        self.user = user
    }
    
    var body: some View {
        Text(user.getInitials())
            .font(.system(size: 18))
            .padding(4)
            .foregroundColor(.white)
            .background(user.color)
            .clipShape(Circle())
    }
}

struct ProfileText: View {
    private let title: String
    private let message: String

    init(title: String, message: String) {
        self.title = title
        self.message = message
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18))
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
            Text(message)
                .font(.system(size: 14))
                .padding()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .foregroundColor(.black)
        .background(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
            .stroke(Color("cedarChest"), lineWidth: 2)
        )
        .padding()
    }
}
