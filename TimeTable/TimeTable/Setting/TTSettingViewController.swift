//
//  TTSettingViewController.swift
//  TimeTable
//
//  Created by dulingkang on 16/3/30.
//  Copyright © 2016年 dulingkang. All rights reserved.
//

import UIKit

class TTSettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    var datasource: [String] = ["配置课表", "关于"]
    var classNames: [String] = ["TTConfigClassViewController", "TTAboutViewController"]
    let bottomHeight: CGFloat = 55
    //MARK: - life cycle
    override func viewDidLoad() {
        tableView = UITableView(frame: CGRect(x: 0,y: 0,width: kScreenWidth,height: kScreenHeight - bottomHeight), style: .plain)
        tableView.backgroundColor = UIColor.lightGray
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.gray
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        addGDTAds()
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
    
    fileprivate func addGDTAds() {
        let bannerView = GDTMobBannerView.init(frame:CGRect(x: 0, y: self.tableView.bottom, width: kScreenWidth, height: bottomHeight) , appkey: kTencentAdsId, placementId: kTencentBannerId)
        bannerView?.currentViewController = self
        bannerView?.interval = 6
        self.view.addSubview(bannerView!)
        bannerView?.loadAdAndShow()
    }

}
