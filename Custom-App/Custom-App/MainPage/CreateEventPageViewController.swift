//
//  CreateEventPageViewController.swift
//  Custom-App
//
//  Created by Tony Cheng on 12/3/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class CreateEventPageViewController: UIViewController {
    var ref = Database.database().reference()
    @IBOutlet weak var nameOfEvent: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var dateStarts: UITextField!
    @IBOutlet weak var timeStarts: UITextField!
    @IBOutlet weak var venue: UITextField!
    @IBOutlet weak var info: UITextView!
    let currentUser = CurrentUser()
    
//    ref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.info.isScrollEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func createEventButtonPushed(_ sender: UIButton) {
        guard let name = nameOfEvent.text else { return }
        guard let loc = location.text else { return }
        guard let startDate = dateStarts.text else { return }
        guard let venueName = venue.text else { return }
        guard let startTime = timeStarts.text else { return }
        guard let information = info.text else { return }
        let postDict: [String:String] = ["name": name, "location": loc, "start date": startDate, "start time": startTime, "venue name": venueName, "info": information]
        let postRef = ref.child("Events").childByAutoId()
        postRef.setValue(postDict)
        let postID = postRef.key
        currentUser.addNewMyEvent(postID: postID)
        
        //        post1Ref.setValue(post1)
        //        var postID = postRef.key
//        self.ref.child("Events").childByAutoId().setValue(postDict)
        
    }

    
    //GMSServices.provideAPIKey("AIzaSyD-EgL_-KLpwNWn_5a7J9gi6EltmSyHPlQ")

}
