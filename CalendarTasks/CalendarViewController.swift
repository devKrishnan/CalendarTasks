//
//  CalendarViewController.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 07/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    var dataSource : CalendarDataSource!
    var years : [Year] = []
    var selectedIndexPath : NSIndexPath? = nil
    @IBOutlet weak var calendarHeaderView: UIStackView!
    let dateFormatter  = DateFormatter()
    var onMonthYearUpdate : ( (_ monthText: String)->Void)?
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource  = CalendarDataSource()
        dataSource.years = self.years
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.reloadData()
        dataSource.calendarHeaderView = calendarHeaderView
        dataSource.addDaysInHeader(collectionView: collectionView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let list = self.collectionView .indexPathsForVisibleItems
        //TODO:- Exception for first row and last row
        if let indexPath  = list.last{
            let year = years[indexPath.section / 12]
            let month = year.monthList[indexPath.section % 12]
            if let callback = self.onMonthYearUpdate {
                callback(dateFormatter.shortMonthSymbols[month.month-1] + " " + String(year.year ))
            }
        
        }

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.bounds.size.width / CGFloat(CalendarConstants.totalNumberOfDaysInWeek), height: 44.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       let  (dayIndex, monthIndex, yearIndex, nextMonthIndex, nextYearIndex) =  dataSource.calendarIndex(indexPath: indexPath)
        
        let year = years[yearIndex]
        let month = year.monthList[monthIndex]
        
        
        var nextYear : Year = years[nextYearIndex]
        
        var currentDay : Day?
        if (dayIndex >= 0 && dayIndex < month.dayList.count)
        {
            currentDay = month.dayList[dayIndex]
            if (dayIndex == 0) {
                print("First day in a month")
            }
            
        }else if (dayIndex >= 0 && dayIndex >= month.dayList.count && nextMonthIndex < nextYear.monthList.count){
            let nextMonth = nextYear.monthList[nextMonthIndex]
            let index = dayIndex-month.dayList.count
            if (dayIndex == 0) {
                print("First day in a month")
            }
            currentDay = nextMonth.dayList[index]
            
        }
        if let callback = self.onMonthYearUpdate, let year =  currentDay?.year, let month = currentDay?.month {
            callback(dateFormatter.shortMonthSymbols[month-1] + " " + String(year ))
        }
        var cell : DayCell
        if let _ = selectedIndexPath {
             cell = collectionView.cellForItem(at: selectedIndexPath! as IndexPath) as! DayCell
            cell.hideSelectionLayer()
        }
       
        cell  = collectionView.cellForItem(at: indexPath as IndexPath) as! DayCell
        cell.addSelectionLayer()
        dataSource.selectedIndexPath = indexPath as NSIndexPath
        self.selectedIndexPath = indexPath as NSIndexPath
        //let
    }
}

