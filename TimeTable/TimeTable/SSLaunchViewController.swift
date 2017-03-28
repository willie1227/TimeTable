//
//  SSLaunchViewController.swift
//  Capture
//
//  Created by dulingkang on 16/4/5.
//  Copyright © 2016年 ShawnDu. All rights reserved.
//

import UIKit

class SSLaunchViewController: UIViewController, GDTSplashAdDelegate {
    @IBOutlet weak var adsImageView: UIImageView!
    @IBOutlet weak var jumpButton: UIButton!
    var splash: GDTSplashAd?
    
    override func viewDidLoad() {
        adsImageView.contentMode = .scaleAspectFill
        adsImageView.isUserInteractionEnabled = true
        jumpButton.layer.cornerRadius = 20
        jumpButton.layer.borderColor = kGreenButtonColor.cgColor
        jumpButton.layer.borderWidth = 0.5
        addGDTSplash()
    }
    
    @IBAction func skippAdsButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false) {
        }
    }
        
    //MARK - delegate
    func splashAdSuccessPresentScreen(_ splashAd: GDTSplashAd!) {
        print("success!!")
    }
    
    func splashAdClicked(_ splashAd: GDTSplashAd!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func splashAdWillClosed(_ splashAd: GDTSplashAd!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func splashAdFail(toPresent splashAd: GDTSplashAd!, withError error: Error!) {
        self.dismiss(animated: true, completion: nil)
    }

    fileprivate func addGDTSplash() {
        splash = GDTSplashAd.init(appkey: kTencentAdsId, placementId: kTencentSplashId)
        splash!.delegate = self
        splash?.fetchDelay = 4
        splash?.loadAndShow(in: UIApplication.shared.windows.last)
    }

}
