//
//  DateHelper.swift
//  SimpleCalendar
//
//  Created by RujuRaj on 3/3/16.
//  Copyright © 2016 RujuRaj. All rights reserved.
//

import Foundation
class DateHelper
{
    static let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    static func getThisDay() -> Int
    {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: NSDate()).day
    }
    static func getThisMonth() -> Int
    {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: NSDate()).month
    }
    static func getThisYear() -> Int
    {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: NSDate()).year
    }
    static func getWeekDay(day:Int,month:Int,year:Int) -> Int
    {
        let cal = NSCalendar.currentCalendar() // user calendar
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let someDateTime = formatter.dateFromString("\(year)/\(month)/\(day)")
        //formatter.dateFromString("2016/02/01")
        let components = cal.components([.Day , .Month , .Year,.Weekday], fromDate: someDateTime!)
        
        return components.weekday
        
    }
    static func getMonthText(month:Int) -> String
    {
        return months[month-1]
    }

}