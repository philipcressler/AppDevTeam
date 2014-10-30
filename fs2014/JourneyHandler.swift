//
//  JourneyHandler.swift
//  fs2014
//
//  Created by Philip Cressler on 10/27/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit


class JourneyHandler: NSObject {
    var allJournies:[Journey]?
    var selectedJourney:Journey?
    
    
    //This func pulls all the journey info from file and creates the allJournies instance var
    func initializeJournies()
    {
        
    }
    
    //just a test func until the previous func is working
    func testInitializeJournies()
    {
        let names = ["Appalachian Trail", "Grand Canyon", "Route 66", "Inca Trail", "Great Wall of China"]
        let miles:[Double] = [1342, 8, 4530, 30, 2300]
        let steps:[Int] = [1342*2112, 8*2112, 4350*2112, 30*2112, 2300*2112]
   
        
        for(var i=0; i<names.count; i++)
        {
            var newJourny = Journey(journeyName: names[i], distanceInSteps: steps[i], distanceInMiles: miles[i])
            allJournies?.append(newJourny)
        }
        
    }
    
    //this func sets the selected journey from the wheel picker
    func setSelectedJourney()
    {
        
    }
    
}
