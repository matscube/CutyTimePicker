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
    func getMonthDaySet(year: Int, month: Int) -> [NSDate] {
        let monthSize = getMonthSize(year, month: month)
        var result = [NSDate]()
        for day in 1..<(monthSize + 1) {
            let date = getDate(year, month: month, day: Int(day))
            result.append(date)
        }
        return result
    }
    func getCalendarMonthDaySet(year: Int, month: Int) -> [NSDate] {
        var monthDaySet = getMonthDaySet(year, month: month)

        let firstDate = monthDaySet.first!
        let lastDate = monthDaySet.last!
        let firstDateComp = getDateComponents(firstDate)
        let lastDateComp = getDateComponents(lastDate)

        if firstDateComp.weekday != 1 {
            let startDate = getDate(year, month: month, day: 2 - firstDateComp.weekday)
            let dateComp = getDateComponents(startDate)
            let monthSize = getMonthSize(dateComp.year, month: dateComp.month)
            
            var beforeMonthDaySet = [NSDate]()
            for var i = dateComp.day; i <= Int(monthSize); i++ {
                beforeMonthDaySet.append(getDate(dateComp.year, month: dateComp.month, day: i))
            }
            monthDaySet = beforeMonthDaySet + monthDaySet
        }
        
        if lastDateComp.weekday != 7 {
            var nextYear = lastDateComp.year
            var nextMonth = lastDateComp.month + 1
            if nextMonth == 13 {
                nextYear++
                nextMonth = 1
            }
            var nextMonthDaySet = [NSDate]()
            
            for var i = 1; i <= (7 - lastDateComp.weekday); i++ {
                nextMonthDaySet.append(getDate(nextYear, month: nextMonth, day: i))
            }
            monthDaySet = monthDaySet + nextMonthDaySet
        }
        
        return monthDaySet
    }
    
}