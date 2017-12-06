//
//  Ticket.swift
//  Custom-App
//
//  Created by Tony Cheng on 12/6/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import Foundation

class Ticket: NSObject {
//    var ticket: Ticket?
    var seller: String
    var info: String
    var price: String
    var contactInfo: String
//    var eventID: String
    
    init(seller: String, info: String, price: String, contactInfo: String) {
        self.seller = seller
        self.info = info
        self.price = price
        self.contactInfo = contactInfo
    }
    
}
