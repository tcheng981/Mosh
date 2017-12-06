//
//  TicketFeedViewController.swift
//  Custom-App
//
//  Created by Tony Cheng on 12/5/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class TicketFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var event: Event?
    @IBOutlet weak var ticketTableView: UITableView!
    let currentUser = CurrentUser()
    var chosenTicket: Ticket?
    var tickets: [Ticket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ticketTableView.delegate = self
        self.ticketTableView.dataSource = self
        updateData()
    }
    func getTickets(user: CurrentUser, completion: @escaping ([Ticket]?) -> Void) {
        let dbRef = Database.database().reference()
        var TicketArray: [Ticket] = []
        
        dbRef.child("Ticket").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let allTickets = snapshot.value as? [String:AnyObject] {
                    user.getTicketFeed(eventID: self.event!.ID, completion: { (ids) in
                        for ticketID in ids {
                            let ticketSale = allTickets[ticketID]
                            let sellerName = ticketSale!["seller name"]
                            let information = ticketSale!["info"]
                            let priceOfTicket = ticketSale!["price"]
                            let contactInfo = ticketSale!["contact"]
                            let eventName = ticketSale!["event name"]
//                            let post = posts[eventKey]
                            let ticket = Ticket(event: eventName as! String, seller: sellerName as! String, info: information as! String, price: priceOfTicket as! String, contactInfo: contactInfo as! String)
////                            let event = Event(name: name, location: location, dateStarts: dateStarts, timeStarts: timeStarts, venue: venue, info: info)
//                            DispatchQueue.main.async {
//                                let eventID = post!["id"] as! String
//                                event.updateID(id: eventID)
//                            }
                            
//                            EventArray.append(event)
//                            self.events.append(event)
                            self.tickets.append(ticket)
                            TicketArray.append(ticket)
                        }
                        print(self.tickets.count)
                        completion(TicketArray)
                    })
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        })
    }
    func updateData() {
        getTickets(user: currentUser) { (posts) in
            if let postsCopy = posts {
                self.tickets = []
                for post in postsCopy {
                    self.tickets.append(post)
                }
                self.ticketTableView.reloadData()
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell", for: indexPath) as! TicketTableViewCell
//        let post = self.events[indexPath.row]
//        cell.nameOfEvent.text = post.name
        let ticket = self.tickets[indexPath.row]
        cell.ticket = ticket
        
        cell.ticketSeller.text = ticket.seller
        cell.price.text = ticket.price
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tickets.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ticket = self.tickets[indexPath.row]
        self.chosenTicket = ticket
        performSegue(withIdentifier: "TicketFeedToTicketPage", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "TicketFeedToTicketPage" {
                if let dest = segue.destination as? TicketPageViewController {
                    if let e = self.chosenTicket {
                        dest.ticket = e;
                        //                        print(dest.event?.name)
                    }
                }
            }
            
        }
    }
}
