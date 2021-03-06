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
    func getMyEventsID(completion: @escaping ([String]) -> Void) {
        var eventArray: [String] = []
        dbRef.child("Users/\(id!)/myEvents").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let posts = snapshot.value as? [String:AnyObject] {
                    for key in posts.keys {
                        eventArray.append(posts[key] as! String)
                    }
                    completion(eventArray)
                } else {
                    completion([])
                }
            } else {
                completion([])
            }
        })
    }
    func getGlobalEventsIDs(completion: @escaping ([String]) -> Void) {
        var eventArray: [String] = []
        dbRef.child("All Events").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let posts = snapshot.value as? [String:AnyObject] {
                    for key in posts.keys {
                        eventArray.append(posts[key] as! String)
                    }
                    completion(eventArray)
                } else {
                    completion([])
                }
            } else {
                completion([])
            }
        })
    }
    func getTicketFeed(eventID: String, completion: @escaping ([String]) -> Void) {
        var ticketArray: [String] = []
        dbRef.child("Ticket IDs").child(eventID).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let tickets = snapshot.value as? [String:AnyObject] {
                    for key in tickets.keys {
                        ticketArray.append(tickets[key] as! String)
                    }
                    completion(ticketArray)
                } else {
                    completion([])
                }
            } else {
                completion([])
            }
        })
    }
}
