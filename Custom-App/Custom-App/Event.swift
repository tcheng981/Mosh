//
//  Event.swift
//  Custom-App
//
//  Created by Tony Cheng on 12/5/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import Foundation
import UIKit

class Event: NSObject {
    var name: String
    var location: String
    var dateStarts: String
    var timeStarts: String
    var venue: String
    var info: String
    
    
    init(name: String, location: String, dateStarts: String, timeStarts: String, venue: String, info: String) {
        self.name = name
        self.location = location
        self.dateStarts = dateStarts
        self.timeStarts = timeStarts
        self.venue = venue
        self.info = info
    }
    
    func updateInfo(name: String, location: String, dateStarts: String, timeStarts: String, venue: String, info: String) -> Void {
            self.name = name
            self.location = location
            self.dateStarts = dateStarts
            self.timeStarts = timeStarts
            self.venue = venue
            self.info = info
    }
}
