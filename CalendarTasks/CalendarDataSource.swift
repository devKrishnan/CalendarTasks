//
//  CalendarDataSource.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 07/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
//We are displaying days of a  month in previous month if there are empty rows
//Section 0 - January
//J1    2  3   4   5   6   7
//..........................
//..........................
//22  23  24  25  26  27  28
//29  30  31  F1  2    3   4

//Section 1 - February - Febraury has begun in the previous section itself
//F5  6   7   8   9    10  11
//..........................
//..........................
//19  20  21  22  23   24  25
//26  27  28  M1  2     3  4
//Section 2 - March -

class CalendarDataSource: NSObject, UICollectionViewDataSource {
    var  years : [Year] = []
    //Since we are displaying the next month's days in prev month, we use this bool value to determine if the firstRow has to be ignored or not
    var ignoreFirstRowForNextSection : Bool = false
    let dateFormatter = DateFormatter()
    var calendarHeaderView : UIStackView?
    var selectedIndexPath : NSIndexPath? = nil
    public func addDaysInHeader(collectionView : UICollectionView){
        if let header =  calendarHeaderView{
            let size = CGSize(width: header.frame.size.width / CGFloat(CalendarConstants.totalNumberOfDaysInWeek), height: 43.0)
            let symbols = dateFormatter.shortWeekdaySymbols
            for i in 0 ..< CalendarConstants.totalNumberOfDaysInWeek{
                let label = UILabel(frame: CGRect.zero)
                label.textAlignment = NSTextAlignment.center
                label.frame.size = size
                label.text = symbols?[i]
                calendarHeaderView?.addArrangedSubview(label)
            }

        }
        
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        let yearIndex = section / CalendarConstants.totalMonths
        let monthIndex = section % CalendarConstants.totalMonths
        let year = years[yearIndex]
        let month = year.monthList[monthIndex]
        let daysInMonth = month.dayList.count
        let daysDisplayedInFirstVisibleRow = CalendarConstants.totalNumberOfDaysInWeek - month.firstDay
        let lastVisbleRowCount = (daysInMonth - daysDisplayedInFirstVisibleRow) % CalendarConstants.totalNumberOfDaysInWeek
        var nextMonthDays = 0
        if lastVisbleRowCount > 0 {
            nextMonthDays = CalendarConstants.totalNumberOfDaysInWeek - lastVisbleRowCount
        }
        
        var totalItems = daysInMonth + month.firstDay + nextMonthDays
        if ignoreFirstRowForNextSection {
            totalItems -= ( daysDisplayedInFirstVisibleRow + month.firstDay )
        }
        ignoreFirstRowForNextSection = nextMonthDays > 0 ? true : false
        
        return totalItems
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell : DayCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        cell.monthLabel.text = ""
        let  (dayIndex, monthIndex, yearIndex, nextMonthIndex, nextYearIndex) = calendarIndex(indexPath: indexPath)
    
        let year = years[yearIndex]
        let month = year.monthList[monthIndex]
        
        
        var nextYear : Year = years[nextYearIndex]
       
        var currentDay : Day?
        if (dayIndex >= 0 && dayIndex < month.dayList.count)
        {
            currentDay = month.dayList[dayIndex]
            if (dayIndex == 0) {
                cell.monthLabel.text = dateFormatter.shortMonthSymbols[monthIndex]
                cell.showMonth()
            }else{
                cell.hideMonth()
            }
            
        }else if (dayIndex >= 0 && dayIndex >= month.dayList.count && nextMonthIndex < nextYear.monthList.count){
            let nextMonth = nextYear.monthList[nextMonthIndex]
            let index = dayIndex-month.dayList.count
            if (index == 0) {
                cell.monthLabel.text = dateFormatter.shortMonthSymbols[nextMonthIndex]
                cell.showMonth()
            }else{
                cell.hideMonth()
            }
            currentDay = nextMonth.dayList[index]
            
        }
        if let day = currentDay {
            cell.dayLabel.text = String(day.day)
            cell.today = day.isEqualToDate(fromDate: Date())
            
        }else{
            cell.dayLabel.text = nil
            cell.today = false
        }
        if self.selectedIndexPath?.compare(indexPath) == .orderedSame {
            cell.addSelectionLayer()
            cell.isSelected = true
        }else{
            cell.hideSelectionLayer()
            cell.isSelected = false
        }
        
        return cell
    }
    //The return value contains the current month and year index together with nextMonth index and next year index for cases where next month day is displayed in the current month's empty cells
    func calendarIndex(indexPath : IndexPath) -> (dayIndex : Int, monthIndex : Int, yearIndex : Int, nextMonthIndex : Int, nextYearIndex : Int) {
        let yearIndex = indexPath.section / CalendarConstants.totalMonths
        let monthIndex = indexPath.section % CalendarConstants.totalMonths
        let year = years[yearIndex]
        let month = year.monthList[monthIndex]
        var dayIndex = 0
        if  indexPath.section == 0 {
            dayIndex = indexPath.row - month.firstDay
        }else{
            if (month.firstDay == 0) {
                dayIndex = indexPath.row;
            }else{
                dayIndex = (CalendarConstants.totalNumberOfDaysInWeek - 1)  - month.firstDay + 1 + indexPath.row;
            }
        }
        var nextMonthIndex = monthIndex + 1
        
        if ( monthIndex >= (CalendarConstants.totalMonths-1) && ((yearIndex + 1) < years.count) )  {
            nextMonthIndex = 0
            return (dayIndex, monthIndex, yearIndex, nextMonthIndex, yearIndex + 1 )
        }
        else{
            return (dayIndex, monthIndex, yearIndex, nextMonthIndex, yearIndex )
        }
    }
    
    
    @available(iOS 6.0, *)
    public func numberOfSections(in collectionView: UICollectionView) -> Int{
        return  years.count * CalendarConstants.totalMonths
    }
    
   

}
