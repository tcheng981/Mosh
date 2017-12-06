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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = event?.name
        self.location.text = event?.location
        self.startTime.text = event?.timeStarts
        self.startDate.text = event?.dateStarts
        self.venue.text = event?.venue
        self.info.text = event?.info
    }

}
