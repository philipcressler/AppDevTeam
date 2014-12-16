//
//  DashboardViewController.swift
//  fs2014
//
//  Created by Jerrod Carpenter on 11/13/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, GMSMapViewDelegate {

    var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var journeyNameLabel: UILabel!

    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var distanceDescriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var stepValueLabel: UILabel!
    var middleLongitude: Double?
    var middleLatitude: Double?
    var alert:UIAlertController?
    var theJourney: Journey?
    var unar:[History]?
    var personMarker: GMSMarker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didGetStepUpdates:", name: "updateLabels", object: nil)
        
        theJourney = (UIApplication.sharedApplication().delegate! as AppDelegate).userJourney
        theJourney!.healthKit!.retrieveStepData()
        
        
        //Labels
       
        
        
        updateMapView(theJourney!)
    }
    
    override func viewDidAppear(animated: Bool) {
        theJourney!.healthKit!.retrieveStepData()
        
        //NEVER DO THIS AGAIN
        NSOperationQueue.mainQueue().addOperationWithBlock{
            self.theJourney!.checkForNotifications()
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "completedJourneyModule", name: "completeJourney", object: nil)
        updateMapView(theJourney!)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func didGetStepUpdates(note: NSNotification) {
        dispatch_async(dispatch_get_main_queue(), {
            self.updateDashboardLabels()
        })
    }
    
    func completedJourneyModule(){
        println("Journey is complete")
        let journiesHistoryInfo = JourneyDatabase().journiesPostcards
        var journeyInfo = journiesHistoryInfo[self.theJourney!.name!]
        let journeyStamp = journeyInfo!.stamp
        let journeyPostcard = journeyInfo!.postcard
        
        var hist = History()
        hist.stamp = journeyStamp
        hist.postcard = journeyPostcard
        
        var documentDirectories: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var documentDirectory:String = documentDirectories.objectAtIndex(0) as String
        var path:String = documentDirectory.stringByAppendingPathComponent("history.archive")
        
        unar = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [History]
        
        if (unar == nil) {
            NSKeyedArchiver.archiveRootObject([hist], toFile: path)
        } else {
            unar!.append(hist)
            NSKeyedArchiver.archiveRootObject(unar!, toFile: path)
        }
        
        alert = UIAlertController(title: "Congratulations!", message: "You have walked the length of \(self.theJourney!.name!). You did it in \(Int(self.theJourney!.healthKit!.totalSteps)) steps.", preferredStyle: UIAlertControllerStyle.Alert)
        alert!.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default){ (action) in
            self.theJourney!.resetSteps()
            
        })
               self.presentViewController(self.alert!, animated: true) { () -> Void in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateMapView(theJourney: Journey){
        if let coordinatesObjects = JourneyDatabaseManager().getCoordinates(theJourney.name!) {
            let cameraInfo = JourneyMapCamera().get(theJourney.name!)
            
            self.middleLongitude = cameraInfo.middleLongitude
            self.middleLatitude = cameraInfo.middleLatitude
            
            let mapTarget = CLLocationCoordinate2D(latitude: self.middleLatitude!, longitude: self.middleLongitude!)
            var camera = GMSCameraPosition.cameraWithTarget(mapTarget, zoom: cameraInfo.zoom!)
            mapView.camera = camera
            
            var path = GMSMutablePath()
            var theLongitudeString: String?
            var theLatitudeString: String?
            var theLatitude: Double?
            var theLongitude: Double?
            
            if let coordinatesObjects = JourneyDatabaseManager().getCoordinates(theJourney.name!) {
                for coordinate in coordinatesObjects {
                    theLongitudeString = coordinate.objectAtIndex(1) as? String
                    theLatitudeString = coordinate.objectAtIndex(2) as? String
                    
                    theLongitude = (theLongitudeString! as NSString).doubleValue
                    theLatitude = (theLatitudeString! as NSString).doubleValue
                    
                    path.addLatitude(theLatitude!, longitude: theLongitude!)
                }
            }
            
            
            
            var polyline = GMSPolyline(path: path)
            polyline.strokeColor = UIColor.blueColor()
            polyline.strokeWidth = 5.0
            polyline.map = mapView
            
            self.spanDistanceTraveled(theJourney)
        }
    }
    
    func spanDistanceTraveled(theJourney: Journey){
        if let coordinatesObjects = JourneyDatabaseManager().getCoordinates(theJourney.name!){
            let meters = self.milesToMeters(theJourney.healthKit!)
            
            var path: GMSMutablePath = GMSMutablePath()
            var theDistance: Double = 0.0
            var count: Int = 0
            var coordinateSize: Int = coordinatesObjects.count
            var theLongitudeString = coordinatesObjects[0].objectAtIndex(1) as? String
            var theLatitudeString = coordinatesObjects[0].objectAtIndex(2) as? String
            
            
            let theLongitude1 = (theLongitudeString! as NSString).doubleValue
            let theLatitude1 = (theLatitudeString! as NSString).doubleValue
            path.addLatitude(theLatitude1, longitude: theLongitude1)
            
            theJourney.streetViewLatitude = theLatitude1
            theJourney.streetViewLongitude = theLongitude1
            
            var theLongitude2 = (theLongitudeString! as NSString).doubleValue
            var theLatitude2 = (theLatitudeString! as NSString).doubleValue
            
            while theDistance < meters && count < (coordinateSize - 2) {
                
                theLongitudeString = coordinatesObjects[count].objectAtIndex(1) as? String
                theLatitudeString = coordinatesObjects[count].objectAtIndex(2) as? String
                count++
                
                theLongitude2 = (theLongitudeString! as NSString).doubleValue
                theLatitude2 = (theLatitudeString! as NSString).doubleValue
                
                path.addLatitude(theLatitude2, longitude: theLongitude2)
                
                theJourney.streetViewLongitude = theLongitude2
                theJourney.streetViewLatitude = theLatitude2
                
                theDistance = GMSGeometryLength(path)
                
            }
            
            var polyline = GMSPolyline(path: path)
            polyline.strokeColor = UIColor.redColor()
            polyline.strokeWidth = 5.0
            polyline.map = mapView
            
            let userPosition = CLLocationCoordinate2DMake(theLatitude2, theLongitude2)
            
            personMarker.position = userPosition
            personMarker.title = "You..."
            personMarker.snippet = "are here"
            personMarker.flat = true
            personMarker.map = mapView
            
//            theJourney.save()
        }
    }
    
    
    func milesToMeters(healthKit: HealthKitHandler)->Double{
        return Double(healthKit.miles) / 0.00062137
    }
    
    
    @IBAction func unwindToSegue(segue:UIStoryboardSegue) {
         self.viewDidLoad()
    }
    
    func updateDashboardLabels(){
        journeyNameLabel.text = theJourney!.name!
        if(theJourney!.healthKit!.totalSteps == 0)
        {
            percentageLabel.text = " 0% "
        } else{
            var percentageDone = (theJourney!.healthKit!.totalSteps / Double(theJourney!.distanceInSteps!)) * 100
            var label =  NSString(format: "%.2f", percentageDone)
            percentageLabel.text = "\(label) %"
        }
        var stepText = NSString(format:"%.f", theJourney!.healthKit!.totalSteps)
        
        stepValueLabel.text = "\(stepText)"
        if(defaults.objectForKey("units") as? String == "Metric")
        {
            var miles = theJourney!.healthKit!.miles
            var kilo = theJourney!.healthKit!.miles * 1.6
            distanceLabel.text = NSString(format: "%.2f", kilo)
            distanceDescriptionLabel.text = "KILOMETERS"
        }else{
            distanceDescriptionLabel.text = "MILES"
            distanceLabel.text = NSString(format:"%.2f", theJourney!.healthKit!.miles)
        }
        
        updateMapView(theJourney!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   
}
