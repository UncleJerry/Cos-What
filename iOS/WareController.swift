//
//  WareController.swift
//  Cos What
//
//  Created by 周建明 on 15/10/18.
//  Copyright © 2015年 Uncle Jerry. All rights reserved.
//

import UIKit

class WareController: UITableViewController {

    
    
    var wares = [String]()
    var didWarePrepared = [Bool]()
    var rowNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.dataSource = self
        //tableView.delegate = self
        //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "WaresCell")
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
        return wares.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WaresCell", forIndexPath: indexPath) as! WaresCell
        cell.WareName!.text = wares[indexPath.row]

        if didWarePrepared[indexPath.row]{
            cell.StatusView.hidden = false
        }else{
            cell.StatusView.hidden = true
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentRow = indexPath.row
        
        if didWarePrepared[currentRow] {
            planData[rowNumber!].ware[wares[currentRow]] = false
            didWarePrepared[currentRow] = false
            
        }else{
            planData[rowNumber!].ware[wares[currentRow]] = true
            didWarePrepared[currentRow] = true
        }
        savePlans()
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    

    @IBAction func unwindToWareList(sender: UIStoryboardSegue) {
        
        
        let sourceController = sender.sourceViewController as? AddWareController
        let wareName = sourceController!.WareName.text
        let wareStatus: Bool?
        if sourceController!.WareStatusSwitch.on {
            wareStatus = true
        }else{
            wareStatus = false
        }
        
        let newIndexPath = NSIndexPath(forRow: wares.count, inSection: 0)
        
        planData[rowNumber!].ware[wareName!] = wareStatus
        didWarePrepared.append(wareStatus!)
        wares.append(wareName!)
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        
        // Save the Plan.
        savePlans()
    }
    
    
    // Override to support conditional editing of the table view.
    /*
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            planData[rowNumber!].ware.removeValueForKey(wares[indexPath.row])
            wares.removeAtIndex(indexPath.row)
            savePlans()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
