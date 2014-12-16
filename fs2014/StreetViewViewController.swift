//
//  StreetViewViewController.swift
//  fs2014
//
//  Created by Jerrod Carpenter on 11/14/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit

class StreetViewViewController: UIViewController, GMSPanoramaViewDelegate {
    var streetView: GMSPanoramaView?
    
    var theJourney:Journey?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theJourney = (UIApplication.sharedApplication().delegate! as AppDelegate).userJourney
        self.streetView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.panoView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.viewDidLoad()
//        self.panoView()
    }
    
    func panoView(){
        
        var panoramaNear = CLLocationCoordinate2DMake(theJourney!.streetViewLatitude!, theJourney!.streetViewLongitude!)
        self.streetView = GMSPanoramaView.panoramaWithFrame(CGRectZero, nearCoordinate:panoramaNear)
        //        var panoView = GMSPanoramaView.moveNearCoordinate(panoramaNear)
        
        //        self.streetView.moveNearCoordinate(panoramaNear)
      
         self.view.addSubview(self.streetView!)
        
        var bottomConstraints = NSLayoutConstraint(item: streetView!, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -44)
         var topConstraints = NSLayoutConstraint(item: streetView!, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 60)
        var widthConstraints = NSLayoutConstraint(item: streetView!, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 1.0)
        self.view.addConstraint(bottomConstraints)
        self.view.addConstraint(topConstraints)
        self.view.addConstraint(widthConstraints)
        
       
        
        theJourney!.save()

    }
    

    @IBAction func unwindToSegue(segue:UIStoryboardSegue) {}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
