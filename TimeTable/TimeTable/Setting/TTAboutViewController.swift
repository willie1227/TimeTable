
//
//  TTAboutViewController.swift
//  TimeTable
//
//  Created by ShawnDu on 2016/11/17.
//  Copyright © 2016年 dulingkang. All rights reserved.
//

import UIKit

class TTAboutViewController: UIViewController {

    @IBOutlet weak var blogLable: UILabel!
    @IBOutlet weak var versionLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLable.text = text
        }
        blogLable.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(TTAboutViewController.blogTapped))
        blogLable.addGestureRecognizer(tap)
    }
    
    func blogTapped() {
        UIApplication.shared.openURL(URL(string:"https://devthinking.com")!)
    }
}
