//
//  MainPageViewController.swift
//  Custom-App
//
//  Created by Tony Cheng on 12/3/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import UIKit
import Firebase

class MainPageViewController: UIViewController {
    
    @IBOutlet weak var createEventButton: UIButton!
    
    let currentUser = CurrentUser()
    @IBAction func createEventButtonPushed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "YourEventsToCreateEvent", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
