//
//  TimeManager.swift
//  CutyTimePicker
//
//  Created by TakanoriMatsumoto on 2015/02/05.
//  Copyright (c) 2015年 TakanoriMatsumoto. All rights reserved.
//

import Foundation

class TimeManager {
    private let calendar = NSCalendar(identifier: NSGregorianCalendar)
    
    // MARK: - Get Date
    func getDate(year: Int, month: Int, day: Int) -> NSDate {
        let dateComp = NSDateComponents()
        dateComp.year = year
        dateComp.month = month
        dateComp.day = day
        
        return getDate(dateComp)
    }
    func getDate(dateComp: NSDateComponents) -> NSDate {
        if let date = calendar.dateFromComponents(dateComp) {
            return date
        } else {
            // Error
            return NSDate()
        }
    }
    
    // MARK: - Get DateComponents
    func getDateComponents(date: NSDate) -> NSDateComponents {
        let flags = NSCalendarUnit(UInt.max)
        let dateComp = calendar.components(flags, fromDate: date)
        return dateComp
    }
    func getDateComponents(year: Int, month: Int, day: Int) -> NSDateComponents {
        let date = getDate(year, month: month, day: day)
        return getDateComponents(date)
    }
    
    // MARK: - Calendar
    func getMonthSize(year: Int, month: Int) -> UInt {
        let date = getDate(year, month: month, day: 1)
        let range: NSRange = calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: date)
        return UInt(range.length)
    }
    
}