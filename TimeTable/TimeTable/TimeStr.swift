//
//  TimeStr.swift
//  TimeTable
//
//  Created by dulingkang on 16/3/28.
//  Copyright © 2016年 dulingkang. All rights reserved.
//

import Foundation

let kAmBeginTimeKey = "kAmBeginTimeKey"
let kAmEndTimeKey = "kAmEndTimeKey"
let kPmBeginTimeKey = "kPmBeginTimeKey"
let kPmEndTimeKey = "kPmEndTimeKey"
let kStepKey = "kStep"

class TimeStr: NSObject {
    var amBeginTime: Int {
        didSet {
            if amBeginTime != 0 {
                UserDefaults.standard.set(amBeginTime, forKey: kAmBeginTimeKey)
                UserDefaults.standard.synchronize()
            }
        }
    }
    var amEndTime: Int {
        didSet {
            if amEndTime != 0 {
                UserDefaults.standard.set(amEndTime, forKey: kAmEndTimeKey)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    var pmBeginTime: Int {
        didSet {
            if pmBeginTime != 0 {
                UserDefaults.standard.set(pmBeginTime, forKey: kPmBeginTimeKey)
                UserDefaults.standard.synchronize()
            }
        }
    }
    var pmEndTime: Int {
        didSet {
            if pmEndTime != 0 {
                UserDefaults.standard.set(pmEndTime, forKey: kPmEndTimeKey)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    
    var step: Int {
        didSet {
            if step != 0 {
                UserDefaults.standard.set(step, forKey: kStepKey)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    var count: Int {
        get {
            return ((amEndTime - amBeginTime) + (pmEndTime - pmBeginTime))/step + 2
        }
    }
    
    var cellHeight: CGFloat {
        get {
            return (kScreenHeight - 185) / CGFloat(count - 1)
        }
    }
    
    var displayedTimeStr: [String] {
        get {
            var timeStrArray: [String] = []
            var oneTimeStr: Int = amBeginTime
            for _ in 0..<count {
                timeStrArray.append("\(oneTimeStr)")
                if oneTimeStr == amEndTime && oneTimeStr != pmBeginTime {
                    oneTimeStr = pmBeginTime
                } else {
                    oneTimeStr += step
                }
            }
            return timeStrArray
        }
    }
    
    override init() {
        let userDefaults = UserDefaults.standard
        
        amBeginTime = userDefaults.integer(forKey: kAmBeginTimeKey)
        amBeginTime = amBeginTime == 0 ? 8 : amBeginTime
        
        amEndTime = userDefaults.integer(forKey: kAmEndTimeKey)
        amEndTime = amEndTime == 0 ? 12 : amEndTime
        
        pmBeginTime = userDefaults.integer(forKey: kPmBeginTimeKey)
        pmBeginTime = pmBeginTime == 0 ? 13 : pmBeginTime
        
        pmEndTime = userDefaults.integer(forKey: kPmEndTimeKey)
        pmEndTime = pmEndTime == 0 ? 23 : pmEndTime
        
        step = userDefaults.integer(forKey: kStepKey)
        step = step == 0 ? 2 : step
        

    }
    static let sharedInstance = TimeStr()
}
