//
//  PickerViewController.swift
//  fs2014
//
//  Created by Jerrod Carpenter on 11/13/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var journeyPicker: UIPickerView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //var journies = ["Route 66 - 2,451 miles", "California - 556 miles", "Grand Canyon - 277 miles", "Road to Hana - 64 miles", "Las Vegas Strip - 6 miles"]
    
    // On button press, switches to dashboardViewController 
    @IBAction func toDashboardView(sender: AnyObject) {
        let vc = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Changes sort of picker based on segmented control selection.
    @IBAction func sortJourneys(sender:UISegmentedControl) {
        self.journeyPicker.reloadAllComponents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        journeyPicker.delegate = self
        journeyPicker.dataSource = self
        
        updateMapView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var journies = ["Route 66 - 2,451 miles", "California - 556 miles", "Grand Canyon - 277 miles", "Road to Hana - 64 miles", "Las Vegas Strip - 6 miles"]
        
        if segmentedControl.selectedSegmentIndex == 1 {
            journies = ["Las Vegas Strip - 6 miles", "Road to Hana - 64 miles", "Grand Canyon - 277 miles", "California - 556 miles", "Route 66 - 2,451 miles"]
        }
        
        return journies.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        var journies = ["Route 66 - 2,451 miles", "California - 556 miles", "Grand Canyon - 277 miles", "Road to Hana - 64 miles", "Las Vegas Strip - 6 miles"]

        if segmentedControl.selectedSegmentIndex == 1 {
            journies = ["Las Vegas Strip - 6 miles", "Road to Hana - 64 miles", "Grand Canyon - 277 miles", "California - 556 miles", "Route 66 - 2,451 miles"]
        }
        
        return journies[row]
    }
    
    func updateMapView(){
        let coordinatesObjects = JourneyDatabaseManager().getCoordinates()
        let middleCoordinate = coordinatesObjects.count / 2
        let middleLongitude = coordinatesObjects[middleCoordinate].objectAtIndex(0) as Double
        let middleLatitude = coordinatesObjects[middleCoordinate].objectAtIndex(1) as Double
        
        let mapTarget = CLLocationCoordinate2D(latitude: middleLatitude, longitude:middleLongitude)
        var camera = GMSCameraPosition.cameraWithTarget(mapTarget, zoom: 1)
        mapView.camera = camera
        
        var path = GMSMutablePath()
        var theLatitude: Double?
        var theLongitude: Double?
        
        for coordinate in coordinatesObjects as [AnyObject] {
            theLongitude = coordinate.objectAtIndex(0) as Double
            theLatitude = coordinate.objectAtIndex(1) as Double
            path.addLatitude(theLatitude!, longitude: theLongitude!)
        }
        
        
        
        var polyline = GMSPolyline(path: path)
        polyline.strokeColor = UIColor.blueColor()
        polyline.strokeWidth = 5.0
        polyline.map = mapView
        
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
