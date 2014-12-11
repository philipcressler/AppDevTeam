//
//  Journey.swift
//  fs2014
//
//  Created by Philip Cressler on 10/27/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit
import CoreLocation

class Journey: NSObject {
    let names = ["California", "Grand Canyon", "Las Vegas", "Route 66", "Route to Hana"]
    let miles:[Double] = [1342, 8, 4530, 30, 2300]
    let steps:[Int] = [1342*2112, 8*2112, 4350*2112, 30*2112, 2300*2112]
    
    var name: String = ""
    var distanceInSteps:Int64 = 0
    var distanceInMiles:Double = 0.0
    var mapStartingCoordinates:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.0, 0.0)
    var mapEndingCoordinates:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.0, 0.0)
    var mapStartingLongtitude: Double = 0.0
    var mapStartingLatitude: Double = 0.0
    var mapEndingLongtitude: Double = 0.0
    var mapEndingLatitude: Double = 0.0
    
    
}
