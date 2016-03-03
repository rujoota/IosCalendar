//
//  CalendarManagement.swift
//  SimpleCalendar
//
//  Created by RujuRaj on 3/3/16.
//  Copyright © 2016 RujuRaj. All rights reserved.
//

import Foundation
import UIKit
class CalendarManagement
{
    var daysOfMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    
    var month=0, currentDayOfMonth=0,currentWeekDay=0,year=0, daysInMonth=0
    var daysList = Array<String>()
    func setup(monthVal: Int,yearVal: Int)
    {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year,.Weekday], fromDate: date)
        if(yearVal == -1)
        {
            year =  DateHelper.getThisYear()
        }
        else
        {
            year=yearVal
        }
        
        if(year%4==0)
        {
            daysOfMonth[1]=29
        }
        
        if(monthVal == -1)
        {
            month = DateHelper.getThisMonth()// current month based on index 1
        }
        else
        {
            month=monthVal
        }
        
        if(monthVal == -1 && yearVal == -1)
        {
            currentDayOfMonth = DateHelper.getThisDay()
            //currentWeekDay=components.weekday-1 // current weekday number based on index 1
        }
        else
        {
            
            currentDayOfMonth=1
            
        }
        
        // for testing
        /*month=2
         year=2016*/
        
        printMonth(month, yy: year)
        
    }
    func printMonth(mm:Int, yy:Int)
    {
        var trailingSpaces = 0
        var leadSpaces = 0
        var daysInPrevMonth = 0
        var prevMonth = 0
        var prevYear = 0
        var nextMonth = 0
        var nextYear = 0
        var currentMonth=mm-1
        
        daysInMonth = daysOfMonth[currentMonth];
        
        
        if (currentMonth == 11)//december
        {
            prevMonth = currentMonth - 1
            nextMonth = 0
            prevYear = yy
            nextYear = yy + 1
        }
        else if (currentMonth == 0)//january
        {
            prevMonth = 11
            prevYear = yy - 1
            nextYear = yy
            
            nextMonth = 1
        }
        else
        {
            prevMonth = currentMonth - 1
            nextMonth = currentMonth + 1
            nextYear = yy
            prevYear = yy
        }
        daysInMonth = daysOfMonth[currentMonth]
        
        currentWeekDay=DateHelper.getWeekDay(1, month: mm, year: yy)
        if(currentWeekDay == 1) // sunday is regarded as first day in general calendar
        {
            currentWeekDay=7;
        }
        else
        {
            currentWeekDay=currentWeekDay-1
        }
        
        trailingSpaces = currentWeekDay
        
        daysInPrevMonth = daysOfMonth[prevMonth];
        daysList.removeAll()
        // previous month
        if(trailingSpaces-2 >= 0)
        {
            for i in 0...trailingSpaces-2
            {
                daysList.append("\((daysInPrevMonth - trailingSpaces + 2 + i))-\(prevMonth+1)-\(prevYear)-GREY")
            }
        }
        // current month
        for i in 1...daysInMonth
        {
            if(i==currentDayOfMonth) // for today
            {
                daysList.append("\(i)-\(currentMonth+1)-\(yy)-YELLOW")
            }
            else
            {
                daysList.append("\(i)-\(currentMonth+1)-\(yy)-YELLOW")
            }
            
        }
        let leadingDays = 14 - (daysList.count%7) - 1
        if(leadingDays >= 0) // when there's a need to add days of next month
        {
            // next month
            for i in 0...leadingDays
            {
                daysList.append("\(i+1)-\(nextMonth+1)-\(nextYear)-GREY")
            }
        }
        
        /*for i in daysList
         {
         print(i)
         }*/
    }
    
    // for sorting buttons objects based on their current text
    func before(value1: UIButton, value2: UIButton) -> Bool {
        
        // ... True means value1 precedes value2.
        var val1=0,val2=0
        if let myNumber = NSNumberFormatter().numberFromString(value1.currentTitle!) {
            val1=myNumber.integerValue
        }
        else {
            
        }
        if let myNumber = NSNumberFormatter().numberFromString(value2.currentTitle!) {
            val2=myNumber.integerValue
        }
        else {
            
        }
        
        return val1 < val2;
    }
    func setupButtons(var btnsArr:Array<UIButton>)
    {
        var i=0
        //btnsArr.sortInPlace(before)
        for date in daysList
        {
            if(i>=btnsArr.count)
            {
                break
            }
            var dateArr=date.componentsSeparatedByString("-") // date is in format dd-mm-yyyy-color
            btnsArr[i].setTitle(dateArr[0], forState: UIControlState.Normal)
            if(dateArr[3] == "GREEN")
            {
                btnsArr[i].setTitleColor(UIColor.greenColor(),forState: .Normal)
            }
            else if(dateArr[3] == "GREY")
            {
                btnsArr[i].setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            }
            else
            {
                btnsArr[i].setTitleColor(UIColor.blackColor(), forState: .Normal)
            }
            i += 1
        }
    }
}