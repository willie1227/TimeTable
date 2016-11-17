//
//  MainViewController.swift
//  TimeTable
//
//  Created by dulingkang on 15/12/23.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, TTMainViewDelegte, ChooseViewDelegate, BaiduMobAdViewDelegate {

    var chooseStudentView: ChooseView?
    var mainView: TTMainView!
    var collectionIndex: Int = 0
    var selectedId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kGreenButtonColor
        print(NSTemporaryDirectory())
        URLCache.shared.removeAllCachedResponses()
        self.addTTMainView()
        self.addGesture()
        self.addBaiduAds()
//        CalendarHelper.delay(2, task: {print("after 2m")})
//        let task = CalendarHelper.delay(5, task: {print("after 5s")})
//        CalendarHelper.cancel(task)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        mainView.refreshView()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    //MARK: - delegate
    //MARK: mainView delegate
    func addStudentsPressed() {
        let studentsVC = StudentsViewController()
        self.navigationController?.pushViewController(studentsVC, animated: true)
    }
    
    func didSelectCollectionCell(_ index: Int) {
        self.collectionIndex = index
        if chooseStudentView == nil {
            chooseStudentView = ChooseView.init(frame: CGRect(x: 0, y: self.view.height*0.65, width: self.view.width, height: self.view.height*0.35))
            chooseStudentView?.delegate = self
            self.view.addSubview(chooseStudentView!)
            chooseStudentView?.alpha = 0.0
        }
        
        if chooseStudentView?.alpha == 0 {
            chooseStudentView?.chooseCollectionView?.reloadChooseView()
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.chooseStudentView?.alpha = 1
            }) 
        }
        selectedId = CalendarHelper.selectedIdBySingleIndex(index)
    }
    
    func deleteName() {
        RealmManager.deleteOneClass(selectedId)
        mainView.singleCollectionView!.reloadData()
    }
    
    func settingButtonPressed() {
        let settingVC = TTSettingViewController()
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    //MARK: choose student delegate
    func didSelectedStudent(_ name: String) {
        let classModel = ClassModel.init(id: selectedId, name: name)
        RealmManager.saveObjectToRealm(classModel, id: selectedId)
        mainView.singleCollectionView!.reloadData()
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.chooseStudentView?.alpha = 0.0
            }) 
    }
    
    func cancelChoose() {
        mainView.singleCollectionView!.reloadData()
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.chooseStudentView?.alpha = 0.0
        }) 
    }
    
    //MARK: gestureView delegate
    func leftSwipe() {
        UIView.animate(withDuration: 0.1, animations: {
            self.mainView.alpha = 0.7
            }) { (success) in
            self.mainView.mainViewIndex += 1
             UIView.animate(withDuration: 0.6, animations: {
                self.mainView.alpha = 1;
             })
        }
    }
    
    func rightSwipe() {
        UIView.animate(withDuration: 0.1, animations: {
            self.mainView.alpha = 0.7
        }) { (success) in
            self.mainView.mainViewIndex -= 1
            UIView.animate(withDuration: 0.6, animations: {
                self.mainView.alpha = 1;
            })
        }
    }
    
    //MARK: Baidu delegate
    func publisherId() -> String! {
        return kBaiduAdsId
    }

    //MARK: - private method
    fileprivate func addTTMainView() {
        mainView = TTMainView.init(frame: self.view.bounds)
        mainView.delegate = self
        self.view.addSubview(mainView)
    }
    
    fileprivate func addGesture() {
        let leftSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(MainViewController.leftSwipe))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(MainViewController.rightSwipe))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    fileprivate func addBaiduAds() {
        let bannerView = BaiduMobAdView()
        bannerView.adUnitTag = kBannerBaiduId
        bannerView.adType = BaiduMobAdViewTypeBanner
        bannerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
        bannerView.delegate = self
        mainView.adsView.addSubview(bannerView)
        bannerView.start()
    }


}

