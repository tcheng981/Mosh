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

    
//    ref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func AddNewEventButtonPushed(_ sender: UIButton) {
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        var path = 23
//        var username = 11
//        var thread = 22
//        var timestamp = "meh"
//        let postDict: [String:AnyObject] = ["imagePath": path as AnyObject,
//                                            "username": username as AnyObject,
//                                            "thread": thread as AnyObject,
//                                            "timestamp": timestamp as AnyObject]
        let postDict: [String:String] = ["that good shit":"Evenmore good shit", "bro": "u kno it"]
        self.ref.child("posts").childByAutoId().setValue(postDict)
    }

}
