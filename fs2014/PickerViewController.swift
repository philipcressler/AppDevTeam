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
    
    // Just for test purposes..
    // Will add images (stamps) when they add the vector images..
    let journies = ["Las Vegas Strip", "Road to Hana", "Grand Canyon", "California", "Route 66"]
    
    // On button press, switches to dashboardViewController 
    @IBAction func toDashboardView(sender: AnyObject) {
        let vc = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        journeyPicker.delegate = self
        journeyPicker.dataSource = self
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
        return journies[row]
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
