//
//  TTLabel.swift
//  TimeTable
//
//  Created by dulingkang on 16/1/23.
//  Copyright © 2016年 dulingkang. All rights reserved.
//

import UIKit

class TTLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 15)
        self.textAlignment = NSTextAlignment.center
    }
    
    convenience init(frame: CGRect, fontSize: CGFloat) {
        self.init(frame: frame)
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    convenience init(frame: CGRect, fontColor: UIColor) {
        self.init(frame: frame)
        self.textColor = fontColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
