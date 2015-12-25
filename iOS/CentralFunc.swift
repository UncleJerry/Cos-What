//
//  CentralFunc.swift
//  出什么
//
//  Created by 周建明 on 15/11/16.
//  Copyright © 2015年 Uncle Jerry. All rights reserved.
//

import Foundation

func savePlans() {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(planData, toFile: Plan.ArchiveURL.path!)
    if !isSuccessfulSave {
        print("Failed to save meals...")
    }
}

func sortPlan(){
    planData = planData.sort { (plan1: Plan, plan2: Plan) -> Bool in
        if plan1.date.compare(plan2.date) == NSComparisonResult.OrderedAscending{
            return true
        }
        return false
    }
    savePlans()
    //reload root tableview
    NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
}

func dateInput(year:Int, month:Int, day: Int) -> NSDate {
    let c = NSDateComponents()
    c.year = year
    c.month = month
    c.day = day
    
    let gregorian = NSCalendar(identifier:NSCalendarIdentifierGregorian)
    let date = gregorian!.dateFromComponents(c)
    return date!
}

func pickupDate(inputDate: NSDate) -> [String]{
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components([.Year, .Month, .Day], fromDate: inputDate)
    let year = "\(components.year)"
    let month = "\(components.month)"
    let day = "\(components.day)"
    let combineDate = [year, month, day]
    
    return combineDate
}


func setDefaultData(){
    if defaults.objectForKey("TimeOrderKey") == nil {
        defaults.setBool(true, forKey: "TimeOrderKey")
    }
}

