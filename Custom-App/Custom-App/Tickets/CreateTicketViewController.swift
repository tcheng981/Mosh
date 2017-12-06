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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundX.jpg")!)
    }
    
    @IBAction func addButtonPushed(_ sender: UIButton) {
        guard let ticketPrice = self.price.text else { return }
        guard let information = self.info.text else { return }
        let ticketDict: [String: String] = ["price": ticketPrice, "info": information]
        ref.child("Ticket Feeds").child((self.event?.ID!)!).childByAutoId().setValue(ticketDict)
    }

}
