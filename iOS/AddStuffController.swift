//
//  AddStuffController.swift
//  Cos What
//
//  Created by 周建明 on 15/10/18.
//  Copyright © 2015年 Uncle Jerry. All rights reserved.
//

import UIKit

class AddStuffController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var StuffName: UITextField!
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var JobPicker: UIPickerView!
    var pickerData = [String]()
    
    var stuffJob: String?
    var seletedJob: String?
    var stuffPerson: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        SaveButton.enabled = false
        
        if localization == "zh-HK" || localization == "zh-Hant-MO" || localization == "zh-TW"{
            pickerData = ["", "攝影", "妝娘", "後期", "後勤"]
        }else{
            pickerData = ["", "摄影", "妆娘", "后期", "后勤"]
            
        }
        
        self.JobPicker.delegate = self
        self.JobPicker.dataSource = self
        
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAlert:",name:"alert", object: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func checkJob(sender: UIBarButtonItem) {
        stuffPerson = StuffName.text!
        if seletedJob == nil{
            
            if localization == "zh-HK" || localization == "zh-Hant-MO" || localization == "zh-TW"{
                let noJobAlert = UIAlertController(title: "殘念啊orz", message: "啊諾...app君貌似不知道\(stuffPerson!)桑的技能呢_(:з」∠)_", preferredStyle: .Alert)
                noJobAlert.addAction(UIAlertAction(title: "好吧( ･᷄ὢ･᷅ )", style: .Default, handler: nil))
                self.presentViewController(noJobAlert, animated: true, completion: nil)
            }else{
                let noJobAlert = UIAlertController(title: "残念啊orz", message: "啊诺...app君貌似不知道\(stuffPerson!)桑的技能呢_(:з」∠)_", preferredStyle: .Alert)
                noJobAlert.addAction(UIAlertAction(title: "好吧( ･᷄ὢ･᷅ )", style: .Default, handler: nil))
                self.presentViewController(noJobAlert, animated: true, completion: nil)
            }
            
        }else{
            self.performSegueWithIdentifier("unwindToStuffViewList", sender: self)
        }
        
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //enhanceable performance
        seletedJob = pickerData[row]
        if row == 0{
            seletedJob = nil
        }
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if SaveButton === sender {
            stuffPerson = StuffName.text!
        }
    }*/
    
    @IBAction func checkEmpty(sender: UITextField) {
        self.title = StuffName.text
        if !StuffName.text!.isEmpty{
            SaveButton.enabled = true
        }else{
            SaveButton.enabled = false
        }
    }

}
