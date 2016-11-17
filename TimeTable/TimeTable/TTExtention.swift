//
//  TTExtention.swift
//  XiaoKa
//
//  Created by liuk on 11/19/15.
//  Copyright © 2015 SmarterEye. All rights reserved.
//

import UIKit

extension UIView{
    var width : CGFloat{
        return self.frame.size.width
    }
    var height : CGFloat{
        return self.frame.size.height
    }
    var top : CGFloat{
        return self.frame.origin.y
    }
    var right : CGFloat{
        return self.frame.origin.x + self.frame.size.width
    }
    var bottom : CGFloat{
        return self.frame.origin.y + self.frame.size.height
    }
    var left : CGFloat{
        return self.frame.origin.x
    }
}

extension UIImage {
    var width : CGFloat{
        return self.size.width
    }
    var height : CGFloat{
        return self.size.height
    }
}

extension Date {
    func Year() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.year, from: self)
        return components.year!
    }
    
    func Month() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.month, from: self)
        return components.month!
    }
    
    func Day() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        return components.day!
    }
    
    func Hour() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.hour, from: self)
        return components.hour!
    }
    
    func Second() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.second, from: self)
        return components.second!
    }
    
    func WeekDay() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.weekday, from: self)
        return components.weekday! - 1
    }
    
    func WeekOfYear() -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.weekOfYear, from: self)
        return components.weekOfYear!
    }
    
    func first() -> Int {
        let calendar = Calendar.current
        let first = calendar.firstWeekday
        return first
    }
}

extension UIButton {
    func setOneImage(_ imagePrefix: String) {
        self.setImage(UIImage(named: imagePrefix + "Normal"), for: UIControlState())
        self.setImage(UIImage(named: imagePrefix + "Normal"), for: .highlighted)
    }
    
    func setAllImage(_ imagePrefix: String) {
        self.setImage(UIImage(named: imagePrefix + "Normal"), for: UIControlState())
        self.setImage(UIImage(named: imagePrefix + "Press"), for: .highlighted)
    }
}
