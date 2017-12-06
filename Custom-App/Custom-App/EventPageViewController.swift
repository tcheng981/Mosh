//
//  EventPageViewController.swift
//  Custom-App
//
//  Created by Tony Cheng on 12/5/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import UIKit

class EventPageViewController: UIViewController {
    var event: Event?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var ticketSalesButton: UIButton!
    @IBOutlet weak var addTicketSaleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = event?.name
        self.location.text = event?.location
        self.startTime.text = event?.timeStarts
        self.startDate.text = event?.dateStarts
        self.venue.text = event?.venue
        self.info.text = event?.info
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundX.jpg")!)
    }
    
    @IBAction func seeTicketSalesPushed(_ sender: UIButton) {
//        performSegue(withIdentifier: "EventToTicketSales", sender: self)
    }
    
    @IBAction func addTicketSalePushed(_ sender:UIButton) {
//        performSegue(withIdentifier: "EventToCreateTicketSale", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "EventToCreateTicketSale" {
                if let dest = segue.destination as? CreateTicketViewController {
                    if let e = self.event {
                        dest.event = e;
                    }
                }
            } else if identifier == "EventToTicketSales" {
                if let dest = segue.destination as? TicketFeedViewController {
                    if let ticket = self.event {
                        dest.event = ticket
                    }
                }
            }
            
        }
    }
}
