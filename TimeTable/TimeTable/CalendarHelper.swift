//
//  CalendarHelper.swift
//  TimeTable
//
//  Created by dulingkang on 15/12/24.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import Foundation

struct CalendarHelper {
    
    static func daysInWeek(_ date: Date) -> [String] {
        let weekDay = date.WeekDay()
        let calendar = Calendar.current
        var startComponents = (calendar as NSCalendar).components([NSCalendar.Unit.year,.month,.day,.weekday], from: date)
        let sourceDay = startComponents.day
        var addValue = 7 - weekDay
        var dayStrArray: [String] = []
        for i in 0...6 {
            addValue = i - (weekDay - calendar.firstWeekday)
            startComponents.day = sourceDay! + addValue
            let currentDay = calendar.date(from: startComponents)
            let dayStr = String(currentDay!.Year()) + "-" + String(currentDay!.Month()) + "-" + String(currentDay!.Day())
            dayStrArray.append(dayStr)
        }
        return dayStrArray
    }
    
    static func fullDaysToDay(_ fullDays: [String]) -> [String] {
        var days: [String] = []
        for fullDay in fullDays {
            let seperateArray = fullDay.components(separatedBy: "-")
            days.append(seperateArray[1] + "-" + seperateArray[2])
        }
        return days
    }
    
    static func dateByIndex(_ index: Int) -> Date {
        let now = Date()
        let calendar = Calendar.current
        var startComponents = (calendar as NSCalendar).components([NSCalendar.Unit.year,.month,.day,.weekday], from: now)
        startComponents.day = startComponents.day! + index * 7
        return calendar.date(from: startComponents)!
    }
    
    static func caculateTimeByIndex(_ index: Int) -> (weekday: Int, hour: Int) {
        let weekday = index % 7 + 1
        let hour = index / 7 + 1
        return (weekday, hour)
    }
    
    static func currentTimeString() -> String {
        let date = Date()
        let weekArray = ["日", "一", "二", "三", "四", "五", "六"]
        return String(date.Year()) + "年" + String(date.Month()) + "月" + String(date.Day()) + "日" + " " + "周" + weekArray[date.WeekDay()]
    }
    
    static func selectedIdBySingleIndex(_ singleIndex: Int) -> String {
        let weekday = CalendarHelper.caculateTimeByIndex(singleIndex).0
        let hour = CalendarHelper.caculateTimeByIndex(singleIndex).1
        let selectedDay = DateModel.sharedInstance.daysInWeek[weekday - 1]
        return selectedDay + "-" + String(hour)
    }
    
//    typealias Task = (cancel: Bool) -> Void
//    static func delay(time: NSTimeInterval, task: () -> ()) -> Task? {
//        func dispatch_later(block: ()-> ()) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block)
//        }
//        
//        var closure: dispatch_block_t? = task
//        var result: Task?
//        let delayedClosure: Task = {
//            cancel in
//            if let internalClosure = closure {
//                if !cancel {
//                    dispatch_async(dispatch_get_main_queue(), internalClosure)
//                }
//            }
//            closure = nil
//            result = nil
//        }
//        result = delayedClosure
//        dispatch_later {
//            if let delayedClosure = result {
//                delayedClosure(cancel: false)
//            }
//        }
//        return result
//    }
//    
//    static func cancel(task: Task?) {
//        task?(cancel: true)
//    }
}
