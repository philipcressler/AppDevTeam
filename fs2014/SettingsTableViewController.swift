//
//  SettingsTableViewController.swift
//  fs2014
//
//  Created by Jerrod Carpenter on 12/9/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UIActionSheetDelegate{

    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var userJourney:Journey?
    
    @IBOutlet weak var weeklySwitch: UISwitch!
    @IBOutlet weak var landmarkSwitch: UISwitch!
    
    @IBOutlet weak var distanceSegment: UISegmentedControl!
    
    @IBAction func weeklyNotifications(sender:AnyObject){
        if(weeklySwitch.on)
        {
            defaults.setObject(true, forKey: "weeklyNotifications")
        }
        else
        {
            defaults.setObject(false, forKey: "weeklyNotifications")
        }
        defaults.synchronize()
    }
    
    @IBAction func landmarkNotifications(sender: AnyObject) {
        if(landmarkSwitch.on)
        {
            defaults.setObject(true, forKey: "landmarkNotifications")
        }
        else{
            defaults.setObject(false, forKey: "landmarkNotifications")
        }
        defaults.synchronize()
    }
    
    @IBAction func reset(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: "Yes, reset steps to zero", otherButtonTitles: "Cancel")
        actionSheet.actionSheetStyle = .Default
        actionSheet.showInView(self.view)
        
    }
    
    @IBAction func changeMetric(sender: AnyObject) {
        switch sender.selectedSegmentIndex{
        case 0:
                defaults.setObject("Imperial", forKey: "units")
        case 1:
                defaults.setObject("Metric", forKey: "units")
        default:
            break;
        }
        
        defaults.synchronize()

        
    }
    
    
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int )
    {
        println("\(buttonIndex)")
        if(buttonIndex == 0)
        {
            userJourney?.resetSteps()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userJourney = Journey().load()
        if(defaults.objectForKey("units") as String == "Imperial")
        {
            distanceSegment.selectedSegmentIndex = 0
        }else{
            distanceSegment.selectedSegmentIndex = 1
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 }
