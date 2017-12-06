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
//    var eventPostings: [Event]
    func getPosts(user: CurrentUser, completion: @escaping ([Event]?) -> Void) {
        let dbRef = Database.database().reference()
        var EventArray: [Event] = []
    
        dbRef.child("Events").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let posts = snapshot.value as? [String:AnyObject] {
                    user.getMyEventsID(completion: { (ids) in
                        for eventKey in posts.keys {
                            let post = posts[eventKey]
                            let name = post!["name"] as! String
                            print(name)
                            let location = post!["location"] as! String
                            let dateStarts = post!["start date"] as! String
                            let timeStarts = post!["start time"] as! String
//                            print(timeStarts)
                            let venue = post!["venue name"] as! String
                            let info = post!["info"] as! String
                            let event = Event(name: name, location: location, dateStarts: dateStarts, timeStarts: timeStarts, venue: venue, info: info)
                            EventArray.append(event)
                            self.events.append(event)
//                            postArray.append(Post(id: postKey, username: username, postImagePath: imagePath, thread: thread, timeInterval: timestamp, read: read))
                        }
                        print(self.events.count)
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

}
