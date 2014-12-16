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
    var healthStore: HKHealthStore
    
    //total miles based on total steps divided by 2112
    var miles: Double
    //total steps overall
    var totalSteps:Double

    //used for background fetch
    var stepSumSinceAppTermination:HKQuantity?
    //the data type that we are pulling from healthkit
    let readDataTypes = NSSet(array: [HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)])
    var lastUpdateTime: NSDate
    
    override init(){
        
        healthStore = HKHealthStore()
        miles = 0.0
        totalSteps = 0.0
        lastUpdateTime = NSDate()
        super.init()
        self.setupHealthStoreIfPossible()

    }
    func encodeWithCoder(coder : NSCoder){
        coder.encodeDouble(self.miles, forKey: "miles")
        coder.encodeDouble(self.totalSteps, forKey: "totalSteps")
        coder.encodeObject(self.lastUpdateTime, forKey:"lastUpdateTime")
        
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.miles = decoder.decodeDoubleForKey("miles")
        self.totalSteps = decoder.decodeDoubleForKey("totalSteps")
        self.lastUpdateTime = decoder.decodeObjectForKey("lastUpdateTime") as NSDate
        
    }
    
    //func that requests healthkit authorization and if successful calls retrieveStepData() func
    func setupHealthStoreIfPossible(){

        healthStore.requestAuthorizationToShareTypes(nil, readTypes: readDataTypes, completion: {(success, error) in
            if success {
               
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
        let stepSampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
        let predicate = HKQuery.predicateForSamplesWithStartDate(self.lastUpdateTime, endDate: endDate, options: .None)
        let sumOptions = HKStatisticsOptions.CumulativeSum
        let query = HKStatisticsQuery(quantityType: stepSampleType, quantitySamplePredicate: predicate, options: sumOptions, completionHandler:{
            (query, results, error) in
            if (results == nil) {
                println("There was an error running the query: \(error)")
            } else {
                if let stepSumFromQuery = results.sumQuantity() {
                    self.totalSteps += stepSumFromQuery.doubleValueForUnit(HKUnit.countUnit())
                    self.miles += stepSumFromQuery.doubleValueForUnit(HKUnit.countUnit()) / 2112
                    self.updateLastUpdateTime()
                    println("our first healthkit is \(self)")
                }
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName("updateLabels", object: nil)
        })
        self.healthStore.executeQuery(query)
        
    }

    func backgroundFetch(completionHandler: (Void -> Void))
    {
        let endDate = NSDate()

        println(endDate)
        let stepSampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
        let predicate = HKQuery.predicateForSamplesWithStartDate(self.lastUpdateTime, endDate: endDate, options: .None)
        let sumOptions = HKStatisticsOptions.CumulativeSum
        let query = HKStatisticsQuery(quantityType: stepSampleType, quantitySamplePredicate: predicate, options: sumOptions, completionHandler: {
            (query, results, error) in
            if(results == nil){
                println("There was an error running the query: \(error)")
            }
            else{
                self.stepSumSinceAppTermination = results.sumQuantity()
                if(self.stepSumSinceAppTermination != nil){
                     self.totalSteps += self.stepSumSinceAppTermination!.doubleValueForUnit(HKUnit.countUnit()) as Double
                    self.miles += self.stepSumSinceAppTermination!.doubleValueForUnit(HKUnit.countUnit()) / 2112
                    self.updateLastUpdateTime()
                } else{ println("nil") }
                
            }
            completionHandler()
        })
        self.healthStore.executeQuery(query)
    }
    
    func updateLastUpdateTime(){
        self.lastUpdateTime = NSDate()
    }
    
    
}
