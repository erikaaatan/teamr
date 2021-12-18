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
    case none
}

class User: ObservableObject, Identifiable {
    var name = ""
    var email = ""
    var phone = ""
    var role: Role
    var color: Color?
    var colorName = ""
    @Published var loggedIn = false
    @Published var classes: [Class]
    
    init(name: String = "", email: String = "", phone: String = "", role: Role = .none, color: Color? = nil, classes: [Class] = []) {
        self.name = name
        self.email = email
        self.phone = phone
        self.role = role
        self.classes = classes
        self.color = color ?? generateColor()
        self.colorName = getColorName()
    }
    
    func logIn(name: String, email: String, phone: String, role: Role, color: Color? = nil, classes: [Class] = []) {
        self.name = name
        self.email = email
        self.phone = phone
        self.role = role
        self.classes = classes
        self.color = color ?? generateColor()
        self.colorName = getColorName()
        self.loggedIn = true
    }
    
    func logOut() {
        self.name = ""
        self.email = ""
        self.phone = ""
        self.role = .none
        self.classes = []
        self.color = nil
        self.colorName = ""
        self.loggedIn = false
    }
    
    func generateColor() -> Color {
        let colors = [Color("rawSienna"), Color("cedarChest"), Color("maizeCrayola"), Color("tickleMePink")]
        return colors.randomElement()!
    }
    
    func getColorName() -> String {
        switch self.color {
        case Color("rawSienna"):
            return "rawSienna"
        case Color("cedarChest"):
            return "cedarChest"
        case Color("maizeCrayola"):
            return "maizeCrayola"
        case Color("tickleMePink"):
            return "tickleMePink"
        default:
            return ""
        }
    }
    
    func getInitials() -> String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: self.name) {
             formatter.style = .abbreviated
             return formatter.string(from: components)
        }
        return ""
    }
    
    func addClass(newClass: Class) {
        self.classes.append(newClass)
    }
    
    func removeClass(oldClass: Class) {
        if let index = self.classes.firstIndex(of: oldClass) {
            self.classes.remove(at: index)
        }
    }
}
