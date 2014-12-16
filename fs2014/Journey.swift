//
//  Journey.swift
//  fs2014
//
//  Created by Philip Cressler on 10/27/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit

class JourneyMapCamera: NSObject {
    var middleLatitude : Double?
    var middleLongitude: Double?
    var zoom: Float?
    
    func get(name: String)-> JourneyMapCamera{
        switch name{
        case "Route 66":
            self.middleLatitude = 36.160838
            self.middleLongitude = -95.928848
            self.zoom = 4
        case "California":
            self.middleLatitude = 37.924708
            self.middleLongitude = -119.292388
            self.zoom = 5.16
        case "Road to Hana":
            self.middleLatitude = 20.801391
            self.middleLongitude = -156.329056
            self.zoom = 8.689
        case "Las Vegas Strip":
            self.middleLatitude = 36.116259
            self.middleLongitude = -115.173029
            self.zoom = 11.09
        default:
            self.middleLatitude = 37.924708
            self.middleLongitude = -119.292388
            self.zoom = 5.19
            
        }
        return self
    }
    
}

class JourneyDatabase: NSObject {
    let journiesImages:[(route:String, image:String)] = [("Route 66", "Route66_Picker.pdf"), ("California", "Cali_Picker.pdf"), ("Grand Canyon", "GrandCanyon_Picker.pdf"), ("Road to Hana", "RoadtoHana_Picker.pdf"), ("Las Vegas Strip", "VegasStrip_Picker.pdf")]
    let journiesImagesReverse:[(route:String, image:String)]  = [("Las Vegas Strip", "VegasStrip_Picker.pdf"), ("Road to Hana", "RoadtoHana_Picker.pdff"), ("Grand Canyon", "GrandCanyon_Picker.pdf"), ("California", "Cali_Picker.pdf"), ("Route 66", "Route66_Picker.pdf")]
    let journiesDistances:[(route:String,(steps: Int,miles:Int))] = [("Route 66", (2451*2112,2451)), ("California",(556*2112, 556)), ("Grand Canyon",(277*2112,277)), ("Road to Hana",(64*2112, 64)), ("Las Vegas Strip",(6*2112,6))]
    
    let journiesDistancesReverse:[(route:String,(steps: Int,miles:Int))] = [("Las Vegas Strip",(6*2112,6)), ("Road to Hana", (64*2112,64)), ("Grand Canyon", (277*2112, 277)), ("California",(556*2112, 556)),("Route 66",(2451*2112, 2451))]
    let journiesPostcards:[String:(stamp: String, postcard: String)] = ["Route 66":("route66-stamp.pdf","Route66_Postcard.pdf"), "California":("california-stamp.pdf","Cali_Postcard.pdf"), "Grand Canyon": ("grandcanyon-stamp.pdf","GrandCanyon_Postcard.pdf"), "Road to Hana":("roadtohana-stamp.pdf","RoadtoHana_Postcard.pdf"), "Las Vegas Strip":("lasvegas-stamp.pdf","VegasStrip_Postcard.pdf")]
}

class Journey: NSObject, NSCoding{
    var name: String?
    var distanceInSteps:Int?
    var distanceInMiles:Int?
    var startDate: NSDate?
    var endDate: NSDate?
    var healthKit: HealthKitHandler?
    var documentDirectories: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    var documentDirectory: String?
    var path: String?
    var notifications:[String:Bool]?
    var streetViewLongitude: Double?
    var streetViewLatitude: Double?
    
    
    init(name:String, distanceInSteps:Int, distanceInMiles:Int)
    {
        self.name = name
        self.distanceInSteps = distanceInSteps
        self.distanceInMiles = distanceInMiles
        self.healthKit = HealthKitHandler()
        self.startDate = NSDate()
        self.notifications = ["25":false, "50":false, "75":false, "100":false]
        self.streetViewLatitude = 0.0
        self.streetViewLongitude = 0.0
        
        //Init NSKeyedArciever paths
        self.documentDirectory = self.documentDirectories.objectAtIndex(0) as? String
        self.path = self.documentDirectory!.stringByAppendingPathComponent("journey.archive")
        
    }
    
    convenience override init(){
        self.init(name: "", distanceInSteps: 0, distanceInMiles: 0)
    }
    func save(){
        
        if(NSKeyedArchiver.archiveRootObject(self, toFile: self.path!)){
            println("WIN")
        } else {
            println("Dang")
        }
    }
    func encodeWithCoder(coder : NSCoder){
        coder.encodeObject(self.name!, forKey: "name")
        coder.encodeInteger(self.distanceInSteps!, forKey: "distanceInSteps")
        coder.encodeInteger(self.distanceInMiles!, forKey: "distanceInMiles")
        coder.encodeObject(self.healthKit!, forKey:"healthKit")
        coder.encodeObject(self.startDate!, forKey:"startDate")
        coder.encodeObject(self.notifications!, forKey: "notifications")
        coder.encodeDouble(self.streetViewLatitude!, forKey: "streetViewLatitude")
        coder.encodeDouble(self.streetViewLongitude!, forKey: "streetViewLongitude")
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init(name: "", distanceInSteps: 0, distanceInMiles: 0)
        self.name = decoder.decodeObjectForKey("name") as? String
        self.distanceInSteps = decoder.decodeIntegerForKey("distanceInSteps")
        self.distanceInMiles = decoder.decodeIntegerForKey("distanceInMiles")
        self.healthKit = decoder.decodeObjectForKey("healthKit") as? HealthKitHandler
        self.startDate = decoder.decodeObjectForKey("startDate") as? NSDate
        self.notifications = decoder.decodeObjectForKey("notifications") as? Dictionary<String,Bool>
        self.streetViewLongitude = decoder.decodeDoubleForKey("streetViewLongitude") as Double
        self.streetViewLatitude = decoder.decodeDoubleForKey("streetViewLatitude") as Double
    }
    
    func load() -> Journey? {
        if let unarchivedJourney = NSKeyedUnarchiver.unarchiveObjectWithFile(self.path!) as? Journey {
            return unarchivedJourney
        }else{
            println("Bad things!")
            return nil
        }
    }
    func updateJourney(name: String, distanceInSteps: Int, distanceInMiles: Int)
    {
        self.name = name
        self.distanceInSteps = distanceInSteps
        self.distanceInMiles = distanceInMiles
        self.notifications = ["25":false, "50":false, "75":false, "100":false]
        self.streetViewLatitude = 0.0
        self.streetViewLongitude = 0.0
    }
    
    func checkForNotifications(){
        var twentyFive:Double = Double(self.distanceInSteps!) / 4
        var fifty:Double = Double(self.distanceInSteps!) / 2
        var seventyFive:Double = Double(self.distanceInSteps!) * 0.75
        var hundred:Double = Double(self.distanceInSteps!)
        
        if self.healthKit!.totalSteps >= hundred && self.notifications!["100"] == false
        {
            //completed journey!
            self.notifications?.updateValue(true, forKey: "25")
            self.notifications?.updateValue(true, forKey: "50")
            self.notifications?.updateValue(true, forKey: "75")
            self.notifications?.updateValue(true, forKey: "100")
            //call func
            NSNotificationCenter.defaultCenter().postNotificationName("completeJourney",object:self)
            
            
            var localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertAction = "Journy+"
            localNotification.alertBody = "You finished your journey! Congratulations!"

            UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)            
        }else if(self.healthKit!.totalSteps >= seventyFive && self.notifications!["75"] == false){
            var localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertAction = "Journy+"
            localNotification.alertBody = "75%% of the way there! Almost there!"

            UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)            
            self.notifications?.updateValue(true, forKey: "25")
            self.notifications?.updateValue(true, forKey: "50")
            self.notifications?.updateValue(true, forKey: "75")
            
        }else if(self.healthKit!.totalSteps >= fifty && self.notifications!["50"] == false){
            var localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertAction = "Journy+"
            localNotification.alertBody = "50%% of the way there. Awesome job!"

            UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)
            self.notifications?.updateValue(true, forKey: "25")
            self.notifications?.updateValue(true, forKey: "50")
            
        }else if(self.healthKit!.totalSteps >= twentyFive && self.notifications!["25"]==false){
            var localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertAction = "Journy+"
            localNotification.alertBody = "25%% of the way there! Keep it up!"
            UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)
            self.notifications?.updateValue(true, forKey: "25")
            
        }else{
            
        }
        
        self.save()
    }
    func checkForNotificationsWithoutNSNotification(){
        var twentyFive:Double = Double(self.distanceInSteps!) / 4
        var fifty:Double = Double(self.distanceInSteps!) / 2
        var seventyFive:Double = Double(self.distanceInSteps!) * 0.75
        var hundred:Double = Double(self.distanceInSteps!)
        //call func
        if self.healthKit!.totalSteps >= hundred && self.notifications!["100"] == false
        {
            //completed journey!
            self.notifications?.updateValue(true, forKey: "25")
            self.notifications?.updateValue(true, forKey: "50")
            self.notifications?.updateValue(true, forKey: "75")
            self.notifications!.updateValue(true, forKey: "100")
            //call func
            
            
            var localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertAction = "Journy+"
            localNotification.alertBody = "You finished your journey! Congratulations!"

            UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)            
    }else if(self.healthKit!.totalSteps >= seventyFive && self.notifications!["75"] == false){
    var localNotification:UILocalNotification = UILocalNotification()
    localNotification.alertAction = "Journy+"
    localNotification.alertBody = "75%% of the way there! Almost there!"
    localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    self.notifications?.updateValue(true, forKey: "25")
    self.notifications?.updateValue(true, forKey: "50")
    self.notifications?.updateValue(true, forKey: "75")
    
    }else if(self.healthKit!.totalSteps >= fifty && self.notifications!["50"] == false){
    var localNotification:UILocalNotification = UILocalNotification()
    localNotification.alertAction = "Journy+"
    localNotification.alertBody = "50%% of the way there. Awesome job!"
    localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    self.notifications?.updateValue(true, forKey: "25")
    self.notifications?.updateValue(true, forKey: "50")
    
    }else if(self.healthKit!.totalSteps >= twentyFive && self.notifications!["25"]==false){
    var localNotification:UILocalNotification = UILocalNotification()
    localNotification.alertAction = "Journy+"
    localNotification.alertBody = "25%% of the way there! Keep it up!"
    localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    self.notifications?.updateValue(true, forKey: "25")
    
    }else{
    
    }
    
    self.save()
    }

    func resetSteps(){
        self.healthKit!.totalSteps = 0
        self.healthKit!.miles = 0
        self.healthKit!.updateLastUpdateTime()
        self.notifications = ["25":false, "50":false, "75":false, "100":false]
        self.save()
    }


}
