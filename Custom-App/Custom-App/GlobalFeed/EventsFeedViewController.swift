//
//  EventsFeedViewController.swift
//  Custom-App
//
//  Created by Tony Cheng on 12/5/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseDatabase

class EventsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var events: [Event] = []
    let currentUser = CurrentUser()
    @IBOutlet weak var FeedTableView: UITableView!
    var chosenEvent: Event?
    
    @IBAction func unwindSegues(_ sender: UIStoryboardSegue) {
        updateData()
    }
    
    func getAllPosts(user: CurrentUser, completion: @escaping ([Event]?) -> Void) {
        let dbRef = Database.database().reference()
        var EventArray: [Event] = []
        
        dbRef.child("Events").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let posts = snapshot.value as? [String:AnyObject] {
                    user.getGlobalEventsIDs(completion: { (ids) in
                        for eventKey in posts.keys {
                            let post = posts[eventKey]
                            let name = post!["name"] as! String
                            let location = post!["location"] as! String
                            let dateStarts = post!["start date"] as! String
                            let timeStarts = post!["start time"] as! String
                            let venue = post!["venue name"] as! String
                            let info = post!["info"] as! String
                            let eventID = post!["id"] as! String
                            let event = Event(id: eventID, name: name, location: location, dateStarts: dateStarts, timeStarts: timeStarts, venue: venue, info: info)
//                            event.updateID(id: eventID)
                            EventArray.append(event)
                            self.events.append(event)
                        }
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
        getAllPosts(user: currentUser) { (posts) in
            if let postsCopy = posts {
                self.events = []
                for post in postsCopy {
                    self.events.append(post)
                }
                self.FeedTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        FeedTableView.dataSource = self
        FeedTableView.delegate = self
        updateData()
        // Do any additional setup after loading the view.
        
        FeedTableView.backgroundView = UIImageView(image: UIImage(named: "backgroundX.jpg"))
        
//        FeedTableView.backgroundView = UIImageView(image: UIImage(named: "backgroundX.jpg"))

        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundX.jpg")!)
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableCell
        let post = self.events[indexPath.row]
        cell.nameOfEvent.text = post.name
        
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        
        cell.backgroundColor = UIColor.clear

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = self.events[indexPath.row]
        self.chosenEvent = post
        performSegue(withIdentifier: "GlobalFeedToEventPage", sender: self)
//        if let post = getPostFromIndexPath(indexPath: indexPath), !post.read {
//            presentPostImage(forPost: post)
//            post.read = true
//            currentUser.addNewReadPost(postID: post.postId)
//            // reload the cell that the user tapped so the unread/read image updates
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "GlobalFeedToEventPage" {
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
