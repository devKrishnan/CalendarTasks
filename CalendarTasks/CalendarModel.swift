//
//  CalendarModel.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 07/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation
struct Day {
    var day : Int
    var month : Int
    var year : Int
    var weekday : Int
    var isLastDayInMonth : Bool
    init?(aDay : Int, aMonth : Int, aYear: Int, aWeekday : Int, isLastDayInMonth value: Bool) {
        if ( aDay <= 0 || aMonth <= 0 || aYear <= 0)  {
            return nil
        }
        day = aDay
        month = aMonth
        year = aYear
        weekday = aWeekday
        isLastDayInMonth = value
    }
    
}

struct Month {
    var month : Int
    var dayList : [Day]
    var year : Int
    //THis is weekday. It is used to identify the beginning of a month
    var firstDay : Int
    init?(ayear: Int, aMonth:Int, aFirstDay : Int) {
        if (aMonth <= 0 || ayear <= 0) {
            return nil
        }
        
        month = aMonth
        year = ayear
        let calendar : Calendar =  globalCalendar()
    
        if let datefirstDay = dateFromComponents(year: ayear, month: aMonth, day: 1) {
            firstDay = calendar.component(.weekday, from: datefirstDay - 1)
            dayList = []
            if let dayCount = noOfdaysInMonth(month: month, year: year){
                for index in 0 ..< dayCount{
                    
                    if let day = Day(aDay: index + 1, aMonth: month, aYear: year, aWeekday: (firstDay + (index % CalendarConstants.totalNumberOfDaysInWeek))%CalendarConstants.totalNumberOfDaysInWeek , isLastDayInMonth: index == dayCount-1 ) {
                        dayList.append(day)
                    }
                    else{
                        return nil
                    }
                }
            }
        }
        else{
            return nil
        }
        
        
    }

}

struct Year {
    public var year : Int
    var monthList : [Month]
    var totalDays : Int = 0
    init?(currentYear : Int) {
        if currentYear <= 0 {
            return nil
        }
        year = currentYear
        monthList = []
        let calendar : Calendar =  globalCalendar()
    
        if let datefirstDayInYear =  dateFromComponents(year: year, month: 1, day: 1) {
            let firstDay = calendar.component(.weekday, from: datefirstDayInYear)-1
            var index = 0
            while index < CalendarConstants.totalMonths {
                if let month : Month = Month(ayear: currentYear, aMonth: index + 1, aFirstDay: firstDay){
                    monthList.append(month)
                    index = index + 1
                    totalDays += month.dayList.count
                }
                else{
                    return nil
                }
            }
        }else{
            return nil
        }
        
        
    }
}

