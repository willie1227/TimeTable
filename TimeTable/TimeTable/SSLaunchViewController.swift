//
//  SSLaunchViewController.swift
//  Capture
//
//  Created by dulingkang on 16/4/5.
//  Copyright © 2016年 ShawnDu. All rights reserved.
//

import UIKit

class SSLaunchViewController: UIViewController, BaiduMobAdSplashDelegate {
    @IBOutlet weak var adsImageView: UIImageView!
    @IBOutlet weak var jumpButton: UIButton!
    var splash: BaiduMobAdSplash?
    
    override func viewDidLoad() {
        adsImageView.contentMode = .scaleAspectFill
        adsImageView.isUserInteractionEnabled = true
        jumpButton.layer.cornerRadius = 20
        jumpButton.layer.borderColor = kGreenButtonColor.cgColor
        jumpButton.layer.borderWidth = 0.5
        addBaiduSplash()
    }
    
    @IBAction func skippAdsButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false) {
        }
    }
        
    //MARK - delegate
    func publisherId() -> String! {
        return kBaiduAdsId
    }
    
    func splashSuccessPresentScreen(_ splash: BaiduMobAdSplash!) {
        print("success!!")
    }
    
    func splashDidClicked(_ splash: BaiduMobAdSplash!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func splashlFailPresentScreen(_ splash: BaiduMobAdSplash!, withError reason: BaiduMobFailReason) {
        print("fail reason \(reason)")
        self.dismiss(animated: true, completion: nil)
    }
    
    func splashDidDismissScreen(_ splash: BaiduMobAdSplash!) {
        self.dismiss(animated: true, completion: nil)
    }

    fileprivate func addBaiduSplash() {
        splash = BaiduMobAdSplash()
        splash!.delegate = self
        splash!.adUnitTag = kSplashBaiduId
        splash!.canSplashClick = true
        splash!.loadAndDisplay(usingContainerView: adsImageView)
    }

}
