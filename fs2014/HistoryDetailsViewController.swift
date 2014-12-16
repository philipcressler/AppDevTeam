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

    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var journey: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    
    var postcard:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var facebookImage = UIImage(named: "facebook_gray_22x22.pdf")
        var twitterImage = UIImage(named: "twitter_gray_22x22.pdf")
        var photoImage = UIImage(named: "photos_gray_22x22.pdf")
        
        facebookButton.setImage(facebookImage, forState: .Normal)
        twitterButton.setImage(twitterImage, forState: .Normal)
        photoButton.setImage(photoImage, forState: .Normal)
        
        journey.image = UIImage(named: postcard)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareOnFacebook() {
        var shareOnFacebook : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        shareOnFacebook.setInitialText("I completed a journey with journey+! ")
        shareOnFacebook.addImage(journey.image)
        self.presentViewController(shareOnFacebook, animated: true, completion: nil)
        var image = UIImage(named: "facebook_color_22x22.pdf")
        facebookButton.setImage(image, forState: .Normal)
    }
    
    @IBAction func shareOnTwitter() {
        var shareOnTwitter : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        shareOnTwitter.setInitialText("I completed a journey with journey+! ")
        shareOnTwitter.addImage(journey.image)
        self.presentViewController(shareOnTwitter, animated: true, completion: nil)
        var image = UIImage(named: "twitter_color_22x22.pdf")
        twitterButton.setImage(image, forState: .Normal)
    }
    
    @IBAction func savePhoto() {
        let imageToSave = journey.image!.CGImage
        let library = ALAssetsLibrary()
        var orientation:ALAssetOrientation = ALAssetOrientation(rawValue: UIImage().imageOrientation.rawValue)!
        library.writeImageToSavedPhotosAlbum(imageToSave, orientation: orientation, completionBlock:nil)
        var image = UIImage(named: "photos_color_22x22.pdf")
        photoButton.setImage(image, forState: .Normal)
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
