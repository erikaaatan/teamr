//
//  Class.swift
//  teamr
//
//  Created by Erika Tan on 12/9/21.
//

import Foundation

class Class {
    var code = ""
    var codeLength = 6
    var owner: User
    var students: [User] = []
    
    init(owner: User) {
        self.owner = owner
        self.code = self.generateCode()
    }
    
    func generateCode() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<self.codeLength).map{ _ in letters.randomElement()! })
    }
}