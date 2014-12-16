//
//  HistoryViewController.swift
//  fs2014
//
//  Created by Jerrod Carpenter on 11/14/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit


class HistoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private let reuseIdentifier = "journeyStamp"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var historyCell: UICollectionViewCell!
    
    var stamps:[String] = []
    var postcards:[String] = []
    var error: NSError?
    var hist:[History]? = []
    var nextScreenRow:Int = 0
    var unar: [History]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var documentDirectories: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var documentDirectory:String = documentDirectories.objectAtIndex(0) as String
        var path:String = documentDirectory.stringByAppendingPathComponent("history.archive")
        
        unar = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [History]
        if(unar != nil){
             self.hist! = unar!
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToSegue(segue:UIStoryboardSegue) {}
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hist!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var stamps:[String] = []
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("journeyStamp", forIndexPath: indexPath) as HistoryCellView
        if(hist != nil){
        for h in hist! {
            stamps.append(h.stamp)
            postcards.append(h.postcard)
        }
      
        cell.stamp.image = UIImage(named: stamps[indexPath.row])
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toDetails" {
            let cell = sender as UICollectionViewCell
            let indexPath = collectionView.indexPathForCell(cell)
            let vc = segue.destinationViewController as HistoryDetailsViewController
            vc.postcard = postcards[indexPath!.item]
        }
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
