//
//  StuffViewController.swift
//  Cos What
//
//  Created by 周建明 on 15/10/17.
//  Copyright © 2015年 Uncle Jerry. All rights reserved.
//

import UIKit

class StuffViewController: UITableViewController {

    
    var counter = [Int]()
    var JobOrder = 0
    var stuffList = [String]()
    var stuffJobList = [String]()
    var rowNumber: Int?
    override func viewDidLoad() {
        super.viewDidLoad()


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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return stuffList.count
    }

    
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StuffsCell", forIndexPath: indexPath) as! StuffsViewCell
        cell.textLabel!.text = stuffList[indexPath.row]
        
        if indexPath.row == counter[JobOrder] {
            cell.detailTextLabel!.text = stuffJobList[++JobOrder]
        }else{
            
            cell.detailTextLabel!.text = stuffJobList[JobOrder]
        }
        
        return cell
    }
    
    @IBAction func unwindToStuffViewList(sender: UIStoryboardSegue) {
        
        
        let sourceController = sender.sourceViewController as? AddStuffController
        let stuffJob = sourceController!.seletedJob
        let stuffPerson = sourceController!.stuffPerson

        if stuffList.isEmpty{
            stuffList.append(stuffPerson!)
            stuffJobList.append(stuffJob!)
            counter.append(stuffList.count)
            planData[rowNumber!].stuff[stuffJob!] = [stuffPerson!]
        }else{
            if !stuffJobList.contains(stuffJob!){
                stuffJobList.append(stuffJob!)
                stuffJobList = stuffJobList.sort(>)
                let navigator = stuffJobList.indexOf(stuffJob!)
                stuffList.insert(stuffPerson!, atIndex: navigator!)
                if navigator == 0 {
                    counter.insert(1, atIndex: navigator!)
                }else{
                    counter.insert(counter[navigator! - 1] + 1, atIndex: navigator!)
                }
                planData[rowNumber!].stuff[stuffJob!] = [stuffPerson!]
                
            }else{
                if stuffJobList.indexOf(stuffJob!)! == stuffJobList.count - 1 {
                    stuffList.append(stuffPerson!)
                    ++counter[stuffJobList.count - 1]
                }else{
                    stuffList.insert(stuffPerson!, atIndex: counter[stuffJobList.indexOf(stuffJob!)!])
                    for index in stuffJobList.indexOf(stuffJob!)!...counter.count - 1{
                        ++counter[index]
                    }
                }
                planData[rowNumber!].stuff[stuffJob!]?.append(stuffPerson!)
                
            }
            
        }
        
        JobOrder = 0
        tableView.reloadData()
        savePlans()// Save the Plan.
        
        
        //let newIndexPath = NSIndexPath(forRow: counter[stuffJobList.indexOf(stuffJob!)!] + 1, inSection: 0)
        
    }
    

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            var deletedJob = 0
            for index in counter{//找出被删的人的职责
                if indexPath.row < index{
                    deletedJob = counter.indexOf(index)!
                    break
                }
            }
            
            if deletedJob == 0{
                planData[rowNumber!].stuff[stuffJobList[deletedJob]]!.removeAtIndex(indexPath.row)
            }else{
                planData[rowNumber!].stuff[stuffJobList[deletedJob]]!.removeAtIndex(indexPath.row - counter[deletedJob - 1])
            }
            //删人
            if planData[rowNumber!].stuff[stuffJobList[deletedJob]]!.isEmpty{
                planData[rowNumber!].stuff.removeValueForKey(stuffJobList[deletedJob])
            }//如果这个职位没人了，整体清除
            
            stuffList.removeAtIndex(indexPath.row)
            for index in deletedJob...counter.count - 1{
                --counter[index]
            }
        
            for index in 0...counter.count - 2{
                if counter[index] == counter[index + 1]{
                    counter.removeAtIndex(index)
                    break
                }
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            savePlans()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

