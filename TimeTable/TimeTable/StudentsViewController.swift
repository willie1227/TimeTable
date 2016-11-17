//
//  StudentsViewController.swift
//  TimeTable
//
//  Created by dulingkang on 16/1/21.
//  Copyright © 2016年 dulingkang. All rights reserved.
//

import UIKit

let kInsertAdsRect = CGRect(x: (kScreenWidth - 300)/2, y: (kScreenHeight - 450)/2, width: 300, height: 450)

class StudentsViewController: UIViewController, TTTextInputViewDelegate, BaiduMobAdInterstitialDelegate {

    var studentTable: StudentsTableView!
    var textView: TTTextInputView!
    var interstitialView: BaiduMobAdInterstitial!
    var adsContainerView: UIView?
    var cancelImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStudentsTableView()
        addRightBarButton()
        loadBaiduAds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        if studentTable.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            studentTable.separatorInset = UIEdgeInsets.zero
        }
        if studentTable.responds(to: #selector(setter: UIView.layoutMargins)) {
            studentTable.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    //MARK: - delegate
    //MARK: TextInputView Delegate
    func textCancel() {
        textView.removeFromSuperview()
    }
    
    func textConfirm() {
        RealmManager.saveStringsToRealm(textView.textView.text)
        textView.removeFromSuperview()
        studentTable.reloadStudentsTable()
    }
    
    //MARK: Baidu delegate
    func publisherId() -> String! {
        return kBaiduAdsId
    }
    
    func interstitialSuccess(toLoadAd interstitial: BaiduMobAdInterstitial!) {
        adsContainerView = UIView(frame: kInsertAdsRect)
        adsContainerView?.backgroundColor = UIColor.clear
        self.view.addSubview(adsContainerView!)
        showBaiduAds()
        addCancelImageView()
    }
    
    func interstitialFail(toLoadAd interstitial: BaiduMobAdInterstitial!) {
        adsContainerView?.removeFromSuperview()
        cancelImageView?.removeFromSuperview()
    }
    
    func interstitialDidAdClicked(_ interstitial: BaiduMobAdInterstitial!) {
        adsContainerView?.removeFromSuperview()
        cancelImageView?.removeFromSuperview()
    }
    
    func interstitialDidDismissScreen(_ interstitial: BaiduMobAdInterstitial!) {
        adsContainerView?.removeFromSuperview()
        cancelImageView?.removeFromSuperview()
    }
    
    //MARK: - event response
    func addStudents() {
        textView = TTTextInputView.init(frame: self.view.bounds)
        textView.delegate = self
        self.view.addSubview(textView)
    }
    
    func cancelTapped() {
        adsContainerView?.removeFromSuperview()
        cancelImageView?.removeFromSuperview()
    }
    
    //MARK: - private method
    fileprivate func addStudentsTableView() {
        studentTable = StudentsTableView.init(frame: self.view.bounds, style: .plain)
        self.view.addSubview(studentTable)
    }
    
    fileprivate func addRightBarButton() {
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(StudentsViewController.addStudents))
        self.navigationItem.setRightBarButton(item, animated: true)
    }
    
    fileprivate func loadBaiduAds() {
        interstitialView = BaiduMobAdInterstitial()
        interstitialView.delegate = self
        interstitialView.adUnitTag = kInsertBaiduId
        interstitialView.interstitialType = BaiduMobAdViewTypeInterstitialOther
        interstitialView.load(usingSize: kInsertAdsRect)
    }
    
    fileprivate func showBaiduAds() {
        if interstitialView.isReady {
            interstitialView.present(from: adsContainerView)
        } else {
            adsContainerView?.removeFromSuperview()
            cancelImageView?.removeFromSuperview()
        }
    }
    
    fileprivate func addCancelImageView() {
        cancelImageView = UIImageView(image: UIImage(named: "cancel"))
        cancelImageView!.frame = CGRect(x: (kScreenWidth - cancelImageView!.width)/2, y: adsContainerView!.bottom, width: cancelImageView!.width, height: cancelImageView!.height)
        cancelImageView!.isUserInteractionEnabled = true
        cancelImageView!.contentMode = .scaleAspectFit
        let tap = UITapGestureRecognizer(target: self, action: #selector(StudentsViewController.cancelTapped))
        cancelImageView!.addGestureRecognizer(tap)
        self.view.addSubview(cancelImageView!)
    }


}
