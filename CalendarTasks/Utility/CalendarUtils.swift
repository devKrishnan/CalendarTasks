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
