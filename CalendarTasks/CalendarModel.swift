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
    
}

struct Month {
    var month : Int
    var dayList : [Day]
    var year : Int
    //THis is weekday. It is used to identify the beginning of a month
    var firstDay : Int
    init?(ayear: Int, aMonth:Int, aFirstDay : Int) {
        month = aMonth
        year = ayear
        let calendar : Calendar =  globalCalendar()
        let components = dateComponents(year: ayear, month: aMonth, day: 1)
        if let datefirstDay = calendar.date(from: components) {
            firstDay = calendar.component(.weekday, from: datefirstDay)
            dayList = []
            if let dayCount = noOfdaysInMonth(month: month, year: year){
                for index in 0 ..< dayCount{
                    let day = Day(day: index + 1, month: month, year: year, weekday: (firstDay + (index % CalendarConstants.totalNumberOfDaysInWeek))%CalendarConstants.totalNumberOfDaysInWeek , isLastDayInMonth: index == dayCount-1 )
                    dayList.append(day)
                }
            }
        }
        else{
            return nil
        }
        
        
    }

}

struct Year {
    var year : Int
    var monthList : [Month]
    init?(currentYear : Int) {
        year = currentYear
        monthList = []
        let calendar : Calendar =  globalCalendar()
        let components = dateComponentsForFirstDay(year: currentYear)
    
        if let datefirstDayInYear = calendar.date(from: components) {
            let firstDay = calendar.component(.weekday, from: datefirstDayInYear)
            var index = 0
            while index < CalendarConstants.totalMonths {
                if let month : Month = Month(ayear: currentYear, aMonth: index + 1, aFirstDay: firstDay){
                    monthList.append(month)
                    index = index + 1
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
func dateComponentsForFirstDay(year: Int) -> DateComponents {
    return dateComponents(year: year, month: 1, day: 1)
    
}

func dateComponents(year: Int, month: Int, day : Int) -> DateComponents {
    var components =  DateComponents()
    components.year = year
    components.month = month
    components.day = day
    return components
    
}
func globalCalendar() -> Calendar {
    return  Calendar(identifier: .gregorian)
}
func noOfdaysInMonth(month : Int, year : Int)->Int?{
    let calendar : Calendar =  globalCalendar()
    let components = dateComponents(year: year, month: month, day: 1)
    if  let date =  calendar.date(from: components) {
        let range = calendar.range(of: .day, in: .month, for: date)
        return range?.count
    }
    else{
        return nil
    }
    
}
