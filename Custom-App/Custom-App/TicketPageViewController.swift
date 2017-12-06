//
//  TicketPageViewController.swift
//  Custom-App
//
//  Created by Tony Cheng on 12/5/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import UIKit

class TicketPageViewController: UIViewController {
    
    var ticket: Ticket?
    @IBOutlet weak var nameOfEvent: UILabel!
    @IBOutlet weak var seller: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var contactInfo: UILabel!
    @IBOutlet weak var info: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameOfEvent.text = ticket?.eventName
        self.seller.text = ticket?.seller
        self.price.text = ticket?.price
        self.contactInfo.text = ticket?.contactInfo
        self.info.text = ticket?.info
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundX.jpg")!)
    }
}

