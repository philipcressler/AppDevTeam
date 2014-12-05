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
    var journies:[(route:String, image:String)] = [("Route 66 - 2,451 miles", "route66-stamp.pdf"), ("California - 556 miles", "california-stamp.pdf"), ("Grand Canyon - 277 miles", "grandcanyon-stamp.pdf"), ("Road to Hana - 64 miles", "roadtohana-stamp.pdf"), ("Las Vegas Strip - 6 miles", "lasvegas-stamp.pdf")]
    
    // On button press, switches to dashboardViewController 
    @IBAction func toDashboardView(sender: AnyObject) {
        let vc = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Changes sort of picker based on segmented control selection.
    @IBAction func sortJourneys(sender:UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
            case 0:
                journies = [("Route 66 - 2,451 miles", "route66-stamp.pdf"), ("California - 556 miles", "california-stamp.pdf"), ("Grand Canyon - 277 miles", "grandcanyon-stamp.pdf"), ("Road to Hana - 64 miles", "roadtohana-stamp.pdf"), ("Las Vegas Strip - 6 miles", "lasvegas-stamp.pdf")]
            case 1:
                journies = [("Las Vegas Strip - 6 miles", "lasvegas-stamp.pdf"), ("Road to Hana - 64 miles", "roadtohana-stamp.pdf"), ("Grand Canyon - 277 miles", "grandcanyon-stamp.pdf"), ("California - 556 miles", "california-stamp.pdf"), ("Route 66 - 2,451 miles", "route66-stamp.pdf")]
            default:
                break;
            
        }

        self.journeyPicker.reloadAllComponents()
        journeyStamps.image = UIImage(named: journies[journeyPicker.selectedRowInComponent(0)].image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        journeyPicker.delegate = self
        journeyPicker.dataSource = self
        journeyStamps.image = UIImage(named: journies[journeyPicker.selectedRowInComponent(0)].image)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return journies.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {

        return journies[row].route
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row:Int, inComponent component: Int)
    {
        journeyStamps.image = UIImage(named:journies[pickerView.selectedRowInComponent(0)].image)
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
