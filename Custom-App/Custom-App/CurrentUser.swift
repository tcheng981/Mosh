//
//  CurrentUser.swift
//  Custom-App
//
//  Created by Tony Cheng on 12/5/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class CurrentUser {
    var username: String!
    var id: String!
    
    let dbRef = Database.database().reference()
    
    init() {
        let currentUser = Auth.auth().currentUser
        username = currentUser?.displayName
        id = currentUser?.uid
    }
    func addNewMyEvent(postID: String) {
        dbRef.child("Users/\(self.id!)/myEvents").childByAutoId().setValue(postID)
    }
}
