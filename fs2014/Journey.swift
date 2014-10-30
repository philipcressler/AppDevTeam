//
//  Journey.swift
//  fs2014
//
//  Created by Philip Cressler on 10/27/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit

class Journey: NSObject {
    var journeyName: String?
    var distanceInSteps:Int?
    var distanceInMiles:Double?
    
    init(journeyName:String, distanceInSteps:Int, distanceInMiles:Double)
    {
        self.journeyName = journeyName
        self.distanceInSteps = distanceInSteps
        self.distanceInMiles = distanceInMiles
    }
}
