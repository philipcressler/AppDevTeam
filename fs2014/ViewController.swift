//
//  ViewController.swift
//  fs2014
//
//  Created by Philip Cressler on 10/21/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

/*

import UIKit
import HealthKit


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var healthStore: HealthKitHandler?
    var journeyStore: JourneyHandler?
    var stepSum: HKQuantity?
    var journeyPicker: UIPickerView?
    var startButton: UIButton?
    
    //test variable
    let testData = ["Appalachain Trail  - 200 miles", "Grand Canyon - 8 miles", "Great Wall of China - 2030", "Route 66 - 3033 miles", "Inca Trail - 30 miles", "Another Random trail - 10 miles", "Death Valley - 40 miles"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //healthstore setup and retrieve steps
        self.healthStore = HealthKitHandler()
        healthStore?.setupHealthStoreIfPossible()
        self.journeyStore = JourneyHandler()
        journeyStore?.testInitializeJournies()
        
        println("\(journeyStore?.allJournies)")
        
        var navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 75)
        navBar.barTintColor = UIColor(red: 141/255.0, green: 198/255.0, blue: 63/255.0, alpha: 1)
        
        var journeyTitle = UILabel()
        journeyTitle.text = "Journey+"
        journeyTitle.font = UIFont(name: "Helvetica Neue", size: 30)
        journeyTitle.textColor = UIColor.whiteColor()
        journeyTitle.textAlignment = .Center
        
        journeyTitle.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40)
        let navigationItem = UINavigationItem()
        navigationItem.titleView = journeyTitle
        navBar.items = [navigationItem]
        
        view.addSubview(navBar)

        journeyPicker = UIPickerView()
        journeyPicker!.dataSource = self
        journeyPicker!.delegate = self
        journeyPicker!.frame = CGRect(x: 0, y: 200, width: self.view.frame.width, height: 216)
        view.addSubview(journeyPicker!)
        
        startButton = UIButton()
        startButton!.setTitle("Start", forState: .Normal)
        startButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        startButton!.backgroundColor = UIColor(red: 141/255.0, green: 198/255.0, blue: 63/255.0, alpha: 1)
        startButton!.frame = CGRectMake(self.view.center.x - (75/2), 450, 75, 50)
        view.addSubview(startButton!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return testData.count    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
       return testData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getJourney()
    }
    
    
    //instance methods
    func getJourney() {
        let selectedJourney = testData[journeyPicker!.selectedRowInComponent(0)]
        
        println("\(selectedJourney)")
        
    }
}

*/
