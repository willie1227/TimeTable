//
//  AppDelegate.swift
//  TimeTable
//
//  Created by dulingkang on 15/12/23.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CAAnimationDelegate {

    var window: UIWindow?
    let launchIconWidth: Int = 60
    let minLauchIconWidth: Int = 50
    let maxLauchIconWidth: Int = 2000
    var splash: GDTSplashAd?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        addGDTSplash()
        configureUmeng()
//        addAnimation()
        self.window!.makeKeyAndVisible()
        self.window!.backgroundColor = UIColor.white
//        let navigationVC = self.window!.rootViewController
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let launchVC = storyboard.instantiateViewController(withIdentifier: "SSLaunchViewController")
//        navigationVC?.present(launchVC, animated: false, completion: nil)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    //MARK - private method
    fileprivate func configureUmeng() {
        let configure = UMAnalyticsConfig.sharedInstance()
        configure?.appKey = kUmengAppKey
        MobClick.start(withConfigure: configure)
    }

    fileprivate func addAnimation() {
        let navigationVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
        self.window!.makeKeyAndVisible()
        self.window!.backgroundColor = UIColor.white
        self.window!.rootViewController = navigationVC
        
        //logo mask
        let layer = CALayer.init()
        layer.contents = UIImage(named: "launchIcon")!.cgImage
        layer.position = navigationVC!.view.center
        layer.bounds = CGRect(x: 0, y: 0, width: launchIconWidth, height: launchIconWidth)
        navigationVC!.view.layer.mask = layer
        
        //mask background view
        let maskBackgroundView = UIView.init(frame: navigationVC!.view.bounds)
        maskBackgroundView.backgroundColor = UIColor(red: 0.047, green:0.996,blue:0.447, alpha:1)
        navigationVC!.view.addSubview(maskBackgroundView)
        navigationVC!.view.bringSubview(toFront: maskBackgroundView)
        
        //mask animation
        let launchIconAnimation = CAKeyframeAnimation(keyPath: "bounds")
        let sourceBounds = NSValue(cgRect: navigationVC!.view.layer.mask!.bounds)
        let middleBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: minLauchIconWidth, height: minLauchIconWidth))
        let lastBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: maxLauchIconWidth, height: maxLauchIconWidth))
        launchIconAnimation.delegate = self
        launchIconAnimation.duration = 1
        launchIconAnimation.beginTime = CACurrentMediaTime() + 1
        
        launchIconAnimation.values = [sourceBounds, middleBounds, lastBounds]
        launchIconAnimation.keyTimes = [0, 0.5, 1]
        launchIconAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        launchIconAnimation.isRemovedOnCompletion = false
        launchIconAnimation.fillMode = kCAFillModeForwards
        navigationVC!.view.layer.mask!.add(launchIconAnimation, forKey: "launchAnimation")
        
        //maskBackgroundView animation
        UIView.animate(withDuration: 0.1, delay: 1.3, options: UIViewAnimationOptions.curveEaseIn, animations: {
            maskBackgroundView.alpha = 0.0
        }, completion: {
            finished in
            maskBackgroundView.removeFromSuperview()
            layer.removeFromSuperlayer()
        })
        
        // animation of navigation Controller
        UIView.animate(withDuration: 0.3, delay: 1.3, options: UIViewAnimationOptions(), animations: {
            navigationVC!.view.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        },completion: {
            finished in
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions(), animations: {
                navigationVC!.view.transform = CGAffineTransform.identity
            }, completion: nil)
        })
    }
    
//    func splashAdSuccessPresentScreen(_ splashAd: GDTSplashAd!) {
//        print("success!!")
//    }
//    
//    func splashAdClicked(_ splashAd: GDTSplashAd!) {
//        self.splash = nil
//    }
//    
//    func splashAdClosed(_ splashAd: GDTSplashAd!) {
//        self.splash = nil
//    }
//    
//    func splashAdFail(toPresent splashAd: GDTSplashAd!, withError error: Error!) {
//        self.splash = nil
//    }
    
    fileprivate func addGDTSplash() {
        splash = GDTSplashAd.init(appkey: kTencentAdsId, placementId: kTencentSplashId)
        splash?.fetchDelay = 4
//        let bottomView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
//        let iconView = UIView.init(frame: CGRect(x: (kScreenWidth - 60)/2, y: 5, width: 60, height: 60))
//        iconView.layer.contents = UIImage(named: "Icon")?.cgImage
//        let label = UILabel.init(frame: CGRect(x: 0, y: 70, width: kScreenWidth, height: 30))
//        label.textAlignment = .center
//        label.text = "Copyright © 2015-2016 Shawn.Du All Rights Reserved."
//        bottomView.addSubview(label)
//        bottomView.addSubview(iconView)
//        bottomView.backgroundColor = UIColor.red
        splash?.loadAndShow(in: self.window)
    }

}

