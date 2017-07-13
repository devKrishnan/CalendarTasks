//
//  TasksTableViewController.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 07/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

let sectionHeaderReuseIdentifier = "DaySectionHeader"
class TasksTableViewController: UITableViewController {
    
    var currentYear : Year?
    let dateFormatter = DateFormatter()
    var currentMonth : Month? = nil
    var dayCountUntilCurrentMonth = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "DayHeaderView", bundle: nil)
        self.tableView.register(nib, forHeaderFooterViewReuseIdentifier: sectionHeaderReuseIdentifier)
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return currentYear == nil ? 0 : currentYear!.totalDays
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let year = currentYear {
            if currentMonth == nil{
                currentMonth = year.monthList.first
                dayCountUntilCurrentMonth = (currentMonth?.totalDays)!
            }else if section == dayCountUntilCurrentMonth{
                currentMonth = year.nextMonth(currentMonth: currentMonth!)
                if let month = currentMonth  {
                    dayCountUntilCurrentMonth = dayCountUntilCurrentMonth + month.totalDays
                }
                
            }else{
                
            }
            let totalDays = (currentMonth?.totalDays)!
            let dayIndex = section - dayCountUntilCurrentMonth + totalDays
            
            let weekDaysTitle = dateFormatter.weekdaySymbols[ (dayIndex + (currentMonth?.firstDay)!) % 7 ]
            let monthName = dateFormatter.monthSymbols[(currentMonth?.month)!-1]
            if let day  = currentMonth?.dayList[dayIndex]{
                let title = weekDaysTitle + " " + String(describing: day.day) + " " + monthName
                return title
            }
            else{
                return nil
            }
           
            
            
        }else{
            return nil
        }
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 20
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //let day =
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
