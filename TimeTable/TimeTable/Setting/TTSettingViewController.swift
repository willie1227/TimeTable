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
    
    //MARK: - life cycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = kGreenBackColor
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "settingTableViewIdentifier"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = datasource[(indexPath as NSIndexPath).row]
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    //MARK: tableview delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: classNames[(indexPath as NSIndexPath).row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
