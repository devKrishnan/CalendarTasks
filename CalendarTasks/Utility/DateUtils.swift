//
//  DateUtils.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 08/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation

private func dateComponents(year: Int, month: Int, day : Int) -> DateComponents {
    var components =  DateComponents()
    components.year = year
    components.month = month
    components.day = day
    return components
    
}
func dateFromComponents(year: Int, month: Int, day : Int) -> Date? {
    let components = dateComponents(year: year, month: month, day: day)
    return  globalCalendar().date(from: components)
}
public func globalCalendar() -> Calendar {
    return  Calendar(identifier: .gregorian)
}
public func noOfdaysInMonth(month : Int, year : Int)->Int?{
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
