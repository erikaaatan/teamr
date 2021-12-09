//
//  CustomTextField.swift
//  teamr
//
//  Created by Erika Tan on 12/4/21.
//

import SwiftUI

struct CustomTextField: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("rawSienna"), lineWidth: 2)
            )
            .padding(.bottom)
            .padding(.trailing)
            .padding(.leading)
            .shadow(color: .gray, radius: 10)
    }
}


