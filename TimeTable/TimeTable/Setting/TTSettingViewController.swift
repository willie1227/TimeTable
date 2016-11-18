//
//  TTSettingViewController.swift
//  TimeTable
//
//  Created by dulingkang on 16/3/30.
//  Copyright © 2016年 dulingkang. All rights reserved.
//

import UIKit

class TTSettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BaiduMobAdViewDelegate {

    var tableView: UITableView!
    var datasource: [String] = ["配置课表", "关于"]
    var classNames: [String] = ["TTConfigClassViewController", "TTAboutViewController"]
    let bottomHeight: CGFloat = 40
    //MARK: - life cycle
    override func viewDidLoad() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.lightGray
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.gray
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        addBaiduAds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "settingTableViewIdentifier"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = datasource[(indexPath as NSIndexPath).row]
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: cell.width, height: cell.height))
        backView.backgroundColor = kGreenBackColor
        cell.selectedBackgroundView = backView
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    //MARK: tableview delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: classNames[(indexPath as NSIndexPath).row])
        self.navigationController?.pushViewController(vc, animated: true)
    }

    //MARK: Baidu delegate
    func publisherId() -> String! {
        return kBaiduAdsId
    }

    fileprivate func addBaiduAds() {
        let adsView = UIView.init(frame: CGRect(x: 0, y: kScreenHeight - bottomHeight, width: kScreenWidth, height: bottomHeight))
        adsView.backgroundColor = UIColor.gray
        view.addSubview(adsView)
        
        let bannerView = BaiduMobAdView()
        bannerView.adUnitTag = kBannerBaiduId
        bannerView.adType = BaiduMobAdViewTypeBanner
        bannerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
        bannerView.delegate = self
        adsView.addSubview(bannerView)
        bannerView.start()
    }

}
