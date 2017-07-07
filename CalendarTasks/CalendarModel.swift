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
    
    //THis is weekday. It is used to identify the beginning of a month
    var firstDay : Int
    init(aMonth:Int, aFirstDay : Int) {
        month = aMonth
        firstDay = aFirstDay
        dayList = []
    }

}

struct Year {
    var year : Int
    var monthList : [Month]
    init?(currentYear : Int) {
        year = currentYear
        monthList = []
        let calendar : Calendar =  Calendar(identifier: .gregorian)
        let components = dateComponentsForFirstDay(year: currentYear)
    
        if let datefirstDayInYear = calendar.date(from: components) {
            let firstDay = calendar.component(.weekday, from: datefirstDayInYear)
            var index = 0
            while index < CalendarConstants.totalMonths {
                let month : Month = Month(aMonth: index + 1, aFirstDay: firstDay)
                monthList.append(month)
                index = index + 1
            }
        }else{
            return nil
        }
        
        
    }
}
func dateComponentsForFirstDay(year: Int) -> DateComponents {
    var components =  DateComponents()
    components.year = year
    components.month = 1
    components.day = 1
    return components
    
}
