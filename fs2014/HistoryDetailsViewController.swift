//
//  HistoryDetailsViewController.swift
//  fs2014
//
//  Created by Jerrod Carpenter on 12/4/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit
import Social
import AssetsLibrary

class HistoryDetailsViewController: UIViewController {

    @IBOutlet weak var journey: UIImageView!
    var journeyImage = UIImage(named: "Cali_Postcard.pdf")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        journey.image = journeyImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareOnFacebook() {
        var shareOnFacebook : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        shareOnFacebook.setInitialText("I completed a journey with journey+! ")
        shareOnFacebook.addImage(journeyImage)
        self.presentViewController(shareOnFacebook, animated: true, completion: nil)
    }
    
    @IBAction func shareOnTwitter() {
        var shareOnTwitter : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        shareOnTwitter.setInitialText("I completed a journey with journey+! ")
        shareOnTwitter.addImage(journeyImage)
        self.presentViewController(shareOnTwitter, animated: true, completion: nil)
    }
    
    @IBAction func savePhoto() {
        let imageToSave = journeyImage?.CGImage
        let library = ALAssetsLibrary()
        var orientation:ALAssetOrientation = ALAssetOrientation(rawValue: UIImage().imageOrientation.rawValue)!
        
        library.writeImageToSavedPhotosAlbum(imageToSave, orientation: orientation, completionBlock:nil)
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
