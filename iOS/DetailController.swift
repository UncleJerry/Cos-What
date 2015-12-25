//
//  DetailPartOneController.swift
//  Cos What
//
//  Created by 周建明 on 15/10/13.
//  Copyright © 2015年 Uncle Jerry. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    //variable
    
    var thisPlan:Plan?
    var rowNumber: Int?
    
    
    @IBOutlet weak var PhotoImageView: UIImageView!
    @IBOutlet weak var VersionLabel: UILabel!
    @IBOutlet weak var RoleNameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if thisPlan == thisPlan {
            printIt()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "StuffView" {
            let stuffPage = segue.destinationViewController as! StuffViewController
            if !thisPlan!.stuff.isEmpty{
                let separateStuffs = [[String]](thisPlan!.stuff.values)
                var counter = [Int]()
                var allStuff = [String]()
                var stuffList = [String]()
                var secondaryCounter = [Int]()
                for singleStuff in separateStuffs{
                    counter.append(allStuff.count)
                    allStuff += singleStuff
                }
                let stuffJob = [String](thisPlan!.stuff.keys)
                let orderedJob = stuffJob.sort(>)
                for index in 0...orderedJob.count - 1{
                    
                    if stuffJob.indexOf(orderedJob[index])! == orderedJob.count - 1 {
                        
                        stuffList += allStuff[counter[stuffJob.indexOf(orderedJob[index])!]...allStuff.count - 1]
                    }else{
                        stuffList += allStuff[counter[stuffJob.indexOf(orderedJob[index])!]...counter[stuffJob.indexOf(orderedJob[index])! + 1] - 1]
                    }
                    secondaryCounter.append(stuffList.count)
                }
                stuffPage.counter = secondaryCounter
                stuffPage.stuffList = stuffList
                stuffPage.stuffJobList = orderedJob
            }
            
            stuffPage.rowNumber = rowNumber
        
        }
        
        if segue.identifier == "WareView" {
            let warePage = segue.destinationViewController as! WareController
            warePage.wares = [String](thisPlan!.ware.keys)
            warePage.didWarePrepared = [Bool](thisPlan!.ware.values)
            warePage.rowNumber = rowNumber
        }
        
        if segue.identifier == "EditBase"{
            let basePlanPage = segue.destinationViewController as! EditPlanController
            basePlanPage.editingPlan = thisPlan
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindToDetail(sender: UIStoryboardSegue) {
        
        
        let sourceController = sender.sourceViewController as? EditPlanController
        
        planData[rowNumber!] = (sourceController?.editingPlan)!
        thisPlan = sourceController?.editingPlan!
        if defaults.boolForKey("TimeOrderKey"){
            sortPlan()
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        }
        savePlans()// Save the Plan.
        //sent notification
        printIt()
    }
    
    func dateToString(inputDate: NSDate) -> String{
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day], fromDate: inputDate)
        let year = components.year
        let month = components.month
        let day = components.day
        
        if localization == "zh-HK" || localization == "zh-Hant-MO" || localization == "zh-TW"{
            let combineDate = "大概在\(year)年\(month)月\(day)日_(:з」∠)_"
            return combineDate
        }else{
            let combineDate = "大概在\(year)年\(month)月\(day)日_(:з」∠)_"
            return combineDate
        }
        
    }
    func printIt(){
        PhotoImageView.image = thisPlan!.photo
        RoleNameLabel.text = thisPlan!.roleName
        VersionLabel.text = thisPlan!.version
        DateLabel.text = dateToString(thisPlan!.date)
        self.title = thisPlan!.anime
    }
    

}
