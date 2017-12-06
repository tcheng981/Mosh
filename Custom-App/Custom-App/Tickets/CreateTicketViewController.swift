//
//  CreateTicketViewController.swift
//  Custom-App
//
//  Created by Tony Cheng on 12/5/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CreateTicketViewController: UIViewController {
    var ref = Database.database().reference()
    var event: Event?
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var preferredMethodContact: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundX.jpg")!)
    }
    
    @IBAction func addButtonPushed(_ sender: UIButton) {
        let ticketRef = ref.child("Ticket").childByAutoId()
        let ticketID = ticketRef.key
        guard let ticketPrice = self.price.text else { return }
        guard let information = self.info.text else { return }
        guard let contactInfo = self.preferredMethodContact.text else { return }
        let seller = CurrentUser().username
        let ticketDict: [String: String] = ["seller name": seller!, "contact": contactInfo, "price": ticketPrice, "info": information]
        ticketRef.setValue(ticketDict)
        ref.child("Ticket IDs").child((self.event?.ID!)!).childByAutoId().setValue(ticketID)
    }

}
