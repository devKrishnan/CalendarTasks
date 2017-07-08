//
//  CalendarDataSource.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 07/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class CalendarDataSource: NSObject, UICollectionViewDataSource {
    var  years : [Year] = []
    var ignoreFirstRowForNextSection : Bool = false
    let dateFormatter = DateFormatter()
    var calendarHeaderView : UIStackView?
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
            }
            
        }else if (dayIndex >= 0 && dayIndex >= month.dayList.count && nextMonthIndex < nextYear.monthList.count){
            let nextMonth = nextYear.monthList[nextMonthIndex]
            let index = dayIndex-month.dayList.count
            if (index == 0) {
                cell.monthLabel.text = dateFormatter.shortMonthSymbols[nextMonthIndex]
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
        
        return cell
    }
    
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
