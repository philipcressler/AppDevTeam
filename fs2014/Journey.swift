//
//  Journey.swift
//  fs2014
//
//  Created by Philip Cressler on 10/27/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit
import CoreLocation


class JourneyDatabase: NSObject {
    let journiesImages:[(route:String, image:String)] = [("Route 66", "route66-stamp.pdf"), ("California", "california-stamp.pdf"), ("Grand Canyon", "grandcanyon-stamp.pdf"), ("Road to Hana", "roadtohana-stamp.pdf"), ("Las Vegas Strip", "lasvegas-stamp.pdf")]
    let journiesImagesReverse:[(route:String, image:String)]  = [("Las Vegas Strip", "lasvegas-stamp.pdf"), ("Road to Hana", "roadtohana-stamp.pdf"), ("Grand Canyon", "grandcanyon-stamp.pdf"), ("California", "california-stamp.pdf"), ("Route 66", "route66-stamp.pdf")]
    let journiesDistances:[(route:String,miles:Int)] = [("Route 66", 2451), ("California", 556), ("Grand Canyon", 277), ("Road to Hana", 64), ("Las Vegas Strip", 6)]
    let journiesDistancesReverse:[(route:String,miles:Int)] = [("Las Vegas Strip", 6), ("Road to Hana", 64), ("Grand Canyon", 277), ("California", 556),("Route 66", 2451)]
    let journiesDistancesSteps:[(route:String,steps:Int)] = [("Route 66", 2451*2112), ("California", 556*2112), ("Grand Canyon", 277*2112), ("Road to Hana", 64*2112), ("Las Vegas Strip", 6*2112)]
    
    
}
class Journey: NSObject {
    
    var name: String = ""
    var distanceInSteps:Int64 = 0
    var distanceInMiles:Double = 0.0
//    var mapStartingCoordinates:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.0, 0.0)
//    var mapEndingCoordinates:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.0, 0.0)
    
    var pathStartingLongtitude: Double = 0.0
    var pathStartingLatitude: Double = 0.0
    var pathEndingLongtitude: Double = 0.0
    var pathEndingLatitude: Double = 0.0
    
    var pathLongitudeList: [Double] = [0.0]
    var pathLatitudeList: [Double] = [0.0]
    
    
//    
//    override init(na) {
//        self.name = "Appalachian Trial"
//        self.distanceInMiles = 1342.0
//        self.distanceInSteps = 1342*2112
//        self.mapStartingLatitude =
//        self.mapStartingLongtitude =
//        self.mapEndingLatitude = 
//        self.mapEndingLongtitude =
//    }
//    
//    required convenience init(coder decoder: NSCoder) {
//        self.init()
//        self.name = decoder.decodeObjectForKey("name") as String
//        self.distanceInSteps = decoder.decodeInt64ForKey("distanceInSteps") as Int64
//        self.distanceInMiles = decoder.decodeDoubleForKey("distanceInMiles") as Double
//        self.mapStartingLatitude = decoder.decodeDoubleForKey("mapStartingLatitude") as Double
//        self.mapStartingLongtitude = decoder.decodeDoubleForKey("mapStartingLongtitude") as Double
//        self.mapEndingLatitude = decoder.decodeDoubleForKey("mapEndingLatitude") as Double
//        self.mapEndingLongtitude = decoder.decodeDoubleForKey("mapEndingLongtitude") as Double
//    }
//    
//    func encodeWithCoder(coder: NSCoder) {
//        coder.encodeObject(self.name, forKey: "name")
//        coder.encodeInt64(self.distanceInSteps, forKey: "distanceInSteps")
//        coder.encodeDouble(self.distanceInMiles, forKey: "distanceInMiles")
//        coder.encodeObject(self.mapStartingLongtitude, forKey: "mapStartingLongtitude")
//        coder.encodeObject(self.mapStartingLatitude, forKey: "mapStartingLatitude")
//        coder.encodeObject(self.mapEndingLongtitude, forKey: "mapEndingLongtitude")
//        coder.encodeObject(self.mapEndingLatitude, forKey: "mapEndingLatitude")
//        
//        self.mapStartingCoordinates = CLLocationCoordinate2D(latitude: self.mapStartingLatitude, longitude: self.mapStartingLongtitude)
//        self.mapEndingCoordinates = CLLocationCoordinate2D(latitude: self.mapEndingLatitude, longitude: self.mapEndingLongtitude)
//    }
}
