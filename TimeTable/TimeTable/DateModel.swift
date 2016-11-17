//
//  DateModel.swift
//  TimeTable
//
//  Created by dulingkang on 15/12/26.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import Foundation

class DateModel {
    var currentDate = CalendarHelper.dateByIndex(0)
    var daysInWeek: [String] = CalendarHelper.daysInWeek(Date())
    dynamic var index: Int = 0 {
        didSet{
            currentDate = CalendarHelper.dateByIndex(index)
            daysInWeek = CalendarHelper.daysInWeek(currentDate)
        }
    }
    
    static let sharedInstance = DateModel()
}
