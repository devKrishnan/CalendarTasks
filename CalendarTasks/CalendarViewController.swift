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
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource  = CalendarDataSource()
        dataSource.years = ["2017","2018"]
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
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
extension CalendarViewController: UICollectionViewDelegate {
    
}
