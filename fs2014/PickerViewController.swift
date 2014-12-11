//
//  PickerViewController.swift
//  fs2014
//
//  Created by Jerrod Carpenter on 11/13/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var journeyPicker: UIPickerView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var journeyStamps: UIImageView!
    var journeyDatabase: JourneyDatabase = JourneyDatabase()
    var journies:[(route:String, miles: Int)]?
    var journiesImages:[(route:String, image:String)]?
 
    
    // On button press, switches to dashboardViewController 
    @IBAction func toDashboardView(sender: AnyObject) {
        let vc = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Changes sort of picker based on segmented control selection.
    @IBAction func sortJourneys(sender:UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
            case 0:
                journies = journeyDatabase.journiesDistances
                journiesImages = journeyDatabase.journiesImages
            case 1:
               journies = journeyDatabase.journiesDistancesReverse
               journiesImages = journeyDatabase.journiesImagesReverse
            default:
                break;
            
        }

        self.journeyPicker.reloadAllComponents()
        journeyStamps.image = UIImage(named:journiesImages![journeyPicker.selectedRowInComponent(0)].image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        journies = journeyDatabase.journiesDistances
        journiesImages = journeyDatabase.journiesImages
        
        journeyPicker.delegate = self
        journeyPicker.dataSource = self
        journeyStamps.image = UIImage(named: journiesImages![journeyPicker.selectedRowInComponent(0)].image)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return journies!.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String
    {
        
        var pickerText = journies![row].route + " - "
        var distance = Float(journies![row].miles)
        var math = distance * 1.6
        var distanceKilo:Int = Int(math)
        //CHECK FOR KILOMETER
        if(true){
            pickerText += NSString(format: "%.01d",journies![row].miles)
            pickerText += " Miles"
        }
        else{
            pickerText += NSString(format: "%.01d", distanceKilo)
            pickerText += " KM"
        }
        return pickerText
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row:Int, inComponent component: Int)
    {
        journeyStamps.image = UIImage(named:journiesImages![pickerView.selectedRowInComponent(0)].image)
    }
    


}
