//
//  HealthKitHandler.swift
//  fs2014
//
//  Created by Philip Cressler on 10/23/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitHandler: NSObject {
    
    //healthstore var
    var healthStore: HKHealthStore?
    //total num of steps in HKUnit.countUnit()
    var stepSum: HKQuantity?
    //total miles based on total steps divided by 2112
    var miles: Double?
    
    //the data type that we are pulling from healthkit
    let readDataTypes = NSSet(array: [HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)])
    
    //func that requests healthkit authorization and if successful calls retrieveStepData() func
    func setupHealthStoreIfPossible(){
        healthStore = HKHealthStore()
        healthStore?.requestAuthorizationToShareTypes(nil, readTypes: readDataTypes, completion: {(success, error) in
            if success {
                println("User completed authorisation request")
                dispatch_async(dispatch_get_main_queue(), {
                    self.retrieveStepData()
                })
            } else{
                println("the user cancelled the authorisation request \(error)")
            }
        })
    }
    
    //calls an HKStatisticsQuery for step counts and then initiliazes stepSum and miles depending on data pulled. Eventually this func needs to take in the variable startDate.
    //currently this func pulls ALL step data even if it's a duplicate
    func retrieveStepData(){
        let endDate = NSDate()
        
        //Start date will be a variable that is set by pressing the start button
        let startDate = NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitMonth,
            value: -2, toDate: endDate, options: nil)
        
            let stepSampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
            let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .None)
            let sumOptions = HKStatisticsOptions.CumulativeSum
        let query = HKStatisticsQuery(quantityType: stepSampleType, quantitySamplePredicate: predicate, options: sumOptions, completionHandler:{
                (query, results, error) in
                if (results == nil) {
                    println("There was an error running the query: \(error)")
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.stepSum = results.sumQuantity()
                  //  println("\(self.stepSum!)")
                    if(self.stepSum != nil){
                    self.miles = self.stepSum!.doubleValueForUnit(HKUnit.countUnit()) / 2112
                    }
                  //  println("\(self.miles)");
                })
            })
            self.healthStore?.executeQuery(query)
    }

    
}