//
//  PlanViewController.swift
//  Cos What
//
//  Created by 周建明 on 15/10/8.
//  Copyright © 2015年 Uncle Jerry. All rights reserved.
//

import UIKit

class PlanViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //load stored data or sample data
        if let savedPlans = loadPlanData() {
            planData += savedPlans
        }else{
            loadSamplePlans()
            savePlans()
        }
        //reload planData to table if receives some notificaiton
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
        
        navigationItem.leftBarButtonItem = editButtonItem()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(animated: Bool) {
        
        if(defaults.boolForKey("firstLaunch") == false) {
            defaults.setBool(true, forKey: "firstLaunch")
            setDefaultData()
            if localization == "zh-HK" || localization == "zh-Hant-MO" || localization == "zh-TW"{
                let firstStartAlert = UIAlertController(title: "Hello", message: "感謝下載可愛愚蠢的我(*ﾟｪﾟ*)\n接下來點擊示例計劃感受一下我的能力吧", preferredStyle: .Alert)
                firstStartAlert.addAction(UIAlertAction(title: "get(๑•̀ㅂ•́)و✧", style: .Default, handler: nil))
                self.presentViewController(firstStartAlert, animated: true, completion: nil)
            }else{
                let firstStartAlert = UIAlertController(title: "雷猴啊", message: "感谢下载可爱愚蠢的我(*ﾟｪﾟ*)\n接下来点击示例计划感受一下我的能力吧", preferredStyle: .Alert)
                firstStartAlert.addAction(UIAlertAction(title: "get(๑•̀ㅂ•́)و✧", style: .Default, handler: nil))
                self.presentViewController(firstStartAlert, animated: true, completion: nil)
            }
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            planData.removeAtIndex(indexPath.row)
            savePlans()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        
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
        return planData.count
    }

    
    
    
    //loadSamplePlans
    func loadSamplePlans() {
        
        
        let photo1 = UIImage(named: "plan1")!
        let photo2 = UIImage(named: "plan2")!
        if localization == "zh-HK" || localization == "zh-Hant-MO" || localization == "zh-TW"{
            let plan2 = Plan (roleName:"逢阪大河", anime: "龍虎鬥", version: "冬季校服", photo: photo1, ware: ["校服":true, "假髮": true, "長筒襪": false, "美瞳": false], stuff: ["攝影":["Av", "Raven", "菲利普"], "後期":["小明"], "後勤":["蓋子","羊駝"], "妝娘":["茉茉"]], date: dateInput(2016, month: 12, day: 25))
            let plan1 = Plan (roleName:"土方十四郎", anime: "銀魂", version: "真選組常服", photo: photo2, ware: ["假髮":false, "刀":false, "煙":true, "真選組制服":true], stuff: ["攝影":["阿布", "大熊"], "後期":["小明"], "後勤":["遠非","Zeta", "龍澤", "淼"], "妝娘":["璐璐", "夭夭"]], date: dateInput(2015, month: 12, day: 17))
            planData += [plan1, plan2]
        }else{
            let plan2 = Plan (roleName:"逢坂大河", anime: "龙与虎", version: "冬季校服", photo: photo1, ware: ["校服":true, "假毛": true, "长筒袜": false, "美瞳": false], stuff: ["摄影":["Av", "Raven", "菲利普"], "后期":["小明"], "后勤":["盖子","羊驼"], "妆娘":["茉茉"]], date: dateInput(2016, month: 12, day: 25))
            let plan1 = Plan (roleName:"土方十四郎", anime: "银他妈", version: "真选组常服", photo: photo2, ware: ["假毛":false, "刀":false, "烟":true, "真选组制服":true], stuff: ["摄影":["阿布", "大熊"], "后期":["小明"], "后勤":["远非","Zeta", "龙泽", "淼"], "妆娘":["璐璐", "夭夭"]], date: dateInput(2015, month: 12, day: 17))
            planData += [plan1, plan2]
        }
    }
    
    
    
    //load data to cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("CurrentPlan", forIndexPath: indexPath) as! PlanViewCell
            
            let singlePlan = planData[indexPath.row]
            cell.RoleCell.text = singlePlan.roleName
            cell.AnimeNameCell.text = singlePlan.anime
            cell.PhotoImageView.image = singlePlan.photo
            
            return cell
    }
    //sava plan in memory
    @IBAction func unwindToPlanList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddPlanController, newPlan = sourceViewController.newPlan {
            planData.append(newPlan)
            if defaults.boolForKey("TimeOrderKey"){
                sortPlan()
            }
            tableView.reloadData()
            
            savePlans()
        }
    }
    
    //load
    func loadPlanData() -> [Plan]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Plan.ArchiveURL.path!) as? [Plan]
    }
    //reload the tableview
    func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }
    
    //check detail plan stuffs
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let planDetailController = segue.destinationViewController as! DetailController
            
            if let selectedPlanCell = sender as? PlanViewCell {
                let indexPath = tableView.indexPathForCell(selectedPlanCell)!
                let selectedPlan = planData[indexPath.row]
                planDetailController.thisPlan = selectedPlan
                planDetailController.rowNumber = indexPath.row
            }
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
