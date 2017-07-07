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
        if let indexPath  = list.first{
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
}

