//
//  MainPageViewController.swift
//  Custom-App
//
//  Created by Tony Cheng on 12/3/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import UIKit
import Firebase

class MainPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // UITableViewDataSource, UITableViewDelegate
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var eventTableView: UITableView!
    var events: [Event] = []
    let currentUser = CurrentUser()
    var chosenEvent: Event?
//    var eventPostings: [Event]
    func getPosts(user: CurrentUser, completion: @escaping ([Event]?) -> Void) {
        let dbRef = Database.database().reference()
        var EventArray: [Event] = []
    
        dbRef.child("Events").observeSingleEvent(of: .value, with: { snapshot -> Void in
//        dbRef.child("Users").child(self.currentUser.id!).child("myEvents").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let posts = snapshot.value as? [String:AnyObject] {
                    user.getMyEventsID(completion: { (ids) in
                        for eventKey in posts.keys {
                            let post = posts[eventKey]
                            print(self.currentUser.id!)
                            let name = post!["name"] as! String
                            let location = post!["location"] as! String
                            let dateStarts = post!["start date"] as! String
                            let timeStarts = post!["start time"] as! String
                            let venue = post!["venue name"] as! String
                            let info = post!["info"] as! String
                            let event = Event(name: name, location: location, dateStarts: dateStarts, timeStarts: timeStarts, venue: venue, info: info)
                            DispatchQueue.main.async {
                                let eventID = post!["id"] as! String
                                event.updateID(id: eventID)
                            }
                            
                            
                            
                            EventArray.append(event)
                            self.events.append(event)

                        }
//                        print(self.events.count)
                        completion(EventArray)
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
        getPosts(user: currentUser) { (posts) in
            if let postsCopy = posts {
                self.events = []
                for post in postsCopy {
                    self.events.append(post)
                }
                self.eventTableView.reloadData()
            }
        }
    }

    
    
    
    
    @IBAction func createEventButtonPushed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "YourEventsToCreateEvent", sender: self)
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.delegate = self
        eventTableView.dataSource = self
        updateData()
//        print(self.events.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! CreateEventTableCell
        let post = self.events[indexPath.row]
        cell.nameOfEvent.text = post.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = self.events[indexPath.row]
        self.chosenEvent = post
        performSegue(withIdentifier: "YourEventsToEventPage", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "YourEventsToEventPage" {
                if let dest = segue.destination as? EventPageViewController {
                    if let e = self.chosenEvent {
                        dest.event = e;
                        //                        print(dest.event?.name)
                    }
                }
            }
            
        }
    }

}
