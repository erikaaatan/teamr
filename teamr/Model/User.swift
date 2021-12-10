//
//  Student.swift
//  teamr
//
//  Created by Erika Tan on 12/9/21.
//

import SwiftUI

enum Role {
    case student
    case instructor
}

class User: Identifiable {
    var name = ""
    var email = ""
    var phone = ""
    var role: Role
    var color: Color?
    
    init(name: String, email: String, phone: String, role: Role) {
        self.name = name
        self.email = email
        self.phone = phone
        self.role = role
        self.color = generateColor()
    }
    
    func generateColor() -> Color {
        let colors = [Color("rawSienna"), Color("cedarChest"), Color("maizeCrayola"), Color("tickleMePink")]
        return colors.randomElement()!
    }
    
    func getInitials() -> String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: self.name) {
             formatter.style = .abbreviated
             return formatter.string(from: components)
        }
        return ""
    }
}
