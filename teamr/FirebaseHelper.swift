//
//  FirebaseHelper.swift
//  teamr
//
//  Created by Erika Tan on 12/14/21.
//

import Firebase
import SwiftUI

class FirebaseHelper {
    static let db = Firestore.firestore()
    
    static func getClassInstance(data: [String: Any]?) -> Class {
        print("in getClassInstance")
        return Class(
            name: data?["name"] as! String,
            owner: data?["owner"] as! String)
    }
    
    static func addUser(name: String, email: String, phone: String, role: String, color: String) {
        db.collection("users").addDocument(data: [
            "name": name,
            "email": email,
            "phone": phone,
            "role": role,
            "color": color,
            "classes": []
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            }
        }
    }
}
