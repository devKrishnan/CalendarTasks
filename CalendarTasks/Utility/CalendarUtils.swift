//
//  CalendarUtils.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 08/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation
func years(beginYear : Int, count: Int) -> [Year]? {
    if beginYear <= 0 {
        return nil
    }
    else{
        var yearList : [Year] = []
        for i in 0 ..< count {
            if let year =  Year(currentYear: beginYear + i){
                yearList.append(year)
            }else{
                return nil
            }
        }
        return yearList
    }
}
//dayIndex begins from 0 ....
func dayInMonth(fromdayIndex dayIndex: Int, inYear year : Year)->(Int?,Month?){
    //TODO:-IMprove the  performance by removng the for loop as this affects the performance of the scroll
    var totalDays = 0
    var dayInMonth : Int = 0
    var currentMonth : Month?
    if dayIndex < year.totalDays {
        for month in year.monthList {
            totalDays = totalDays + month.totalDays
            if dayIndex < totalDays{
                dayInMonth = dayIndex - (totalDays-month.totalDays)
                currentMonth = month
                break
            }
        }
        return (dayInMonth :dayInMonth , month: currentMonth )
    }else{
        return (dayInMonth : nil , month: nil )
    }
    
}


