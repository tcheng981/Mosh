//
//  TicketTableViewCell.swift
//  Custom-App
//
//  Created by Tony Cheng on 12/6/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import Foundation
import UIKit

class TicketTableViewCell: UITableViewCell {
    var ticket: Ticket?
    @IBOutlet weak var ticketSeller: UILabel!
    @IBOutlet weak var price: UILabel!
}
