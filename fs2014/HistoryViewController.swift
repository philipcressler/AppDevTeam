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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var stamps = ["california-stamp.pdf"]
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
        //return stamps.count
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("journeyStamp", forIndexPath: indexPath) as HistoryCellView
        cell.stamp.image = UIImage(named: "california-stamp.pdf")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
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
