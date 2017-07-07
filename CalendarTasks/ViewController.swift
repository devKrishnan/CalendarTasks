//
//  ViewController.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 07/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
let heightOfTopBar: CGFloat = 64
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var yearList: [Year] = []
        for _ in 0 ..< 4 {
            if let year =  Year(currentYear: 2017){
               yearList.append(year)
            }
            else{
                let alertController : UIAlertController = UIAlertController(title: "Invalid Data", message: "The calendar can not be displayed", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let calendar : CalendarViewController = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        calendar.years = yearList
        calendar.onMonthYearUpdate = {(text: String) -> Void in
            self.navigationItem.title = text
        }
        let tasks = storyboard.instantiateViewController(withIdentifier: "TasksTableViewController")
        self.addChildViewController(calendar)
        calendar.view.frame = self.frameForCalendarController();
        self.view.addSubview(calendar.view)
        calendar.didMove(toParentViewController: self)
        self.addChildViewController(tasks)
        tasks.view.frame = self.frameForTaskController();
        self.view.addSubview(tasks.view)
        tasks.didMove(toParentViewController: self)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func frameForCalendarController() -> CGRect {
        return CGRect(x: 0, y: heightOfTopBar, width: self.view.frame.width, height: (self.view.frame.height-heightOfTopBar)/2)
    }
    func frameForTaskController() -> CGRect {
        return CGRect(x: 0, y: view.frame.height/2, width: self.view.frame.width, height: (self.view.frame.height-heightOfTopBar))
    }

}

