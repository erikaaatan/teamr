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
            "color": color
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            }
        }
    }
    
    static func addClass(name: String, code: String, owner: String) {
        db.collection("classes").addDocument(data: [
            "name": name,
            "code": code,
            "owner": owner
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            }
        }
    }
    
    static func addClassToUser(className: String, userEmail: String) {
        db.collection("users").whereField("email", isEqualTo: userEmail)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    let doc = querySnapshot!.documents[0]
                    db.collection("users").document(doc.documentID).updateData(["classes.\(className)" : true]) { err in
                        if let err = err {
                            print("Error adding class to user: \(err)")
                        }
                    }
                }
            }
    }
    
    static func addUserToClass(className: String, userEmail: String) {
        db.collection("classes").whereField("name", isEqualTo: className)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    let doc = querySnapshot!.documents[0]
                    db.collection("classes").document(doc.documentID).updateData(["students.\(userEmail)" : true]) { err in
                        if let err = err {
                            print("Error adding class to user: \(err)")
                        }
                    }
                }
            }
    }
}
