//
//  Student.swift
//  teamr
//
//  Created by Erika Tan on 12/9/21.
//

import Foundation

enum Role {
    case student
    case instructor
}

class User {
    var name = ""
    var email = ""
    var phone = ""
    var role: Role
    
    init(name: String, email: String, phone: String, role: Role) {
        self.name = name
        self.email = email
        self.phone = phone
        self.role = role
    }
}
