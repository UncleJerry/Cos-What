//
//  EditPlanController.swift
//  出什么
//
//  Created by 周建明 on 15/11/16.
//  Copyright © 2015年 Uncle Jerry. All rights reserved.
//

import UIKit

class EditPlanController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        if let editingPlan = editingPlan{
            RoleNameField.text = editingPlan.roleName
            self.title = editingPlan.anime
            AnimeField.text = editingPlan.anime
            VersionField.text = editingPlan.version
            PhotoImageView.image = editingPlan.photo
            let thisDate = pickupDate(editingPlan.date)
            YearField.text = thisDate[0]
            MonthField.text = thisDate[1]
            DayField.text = thisDate[2]
        }
        
        if !RoleNameField.text!.isEmpty && !AnimeField.text!.isEmpty && !VersionField.text!.isEmpty && !YearField.text!.isEmpty && !MonthField.text!.isEmpty && !DayField.text!.isEmpty {
            SaveButton.enabled = true
        }else{
            SaveButton.enabled = false
        }
        initializeTextFields()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //variable
    let picker = UIImagePickerController()
    var editingPlan:Plan?
    
    
    //link
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var RoleNameField: UITextField!
    @IBOutlet weak var AnimeField: UITextField!
    @IBOutlet weak var VersionField: UITextField!
    @IBOutlet var PhotoImageView: UIImageView!
    @IBOutlet weak var YearField: UITextField!
    @IBOutlet weak var MonthField: UITextField!
    @IBOutlet weak var DayField: UITextField!
    @IBAction func LoadPhoto(sender: UIButton) {
        picker.allowsEditing = true
        picker.sourceType = .PhotoLibrary
        //picker.modalPresentationStyle = .Popover
        presentViewController(picker,
            animated: true,
            completion: nil)
        
    }
    
    
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]){
            let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
            PhotoImageView.contentMode = .ScaleAspectFit
            PhotoImageView.image = chosenImage
            dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if SaveButton === sender {
            if PhotoImageView.image! == UIImage(named: "seletephoto_zh") {
                PhotoImageView.image = UIImage(named: "NoPhoto_zh")
            }
            editingPlan = Plan(roleName: self.RoleNameField.text!, anime: self.AnimeField.text!, version: self.VersionField.text!, photo: self.PhotoImageView.image, ware: [:], stuff: [:], date: dateInput(Int(self.YearField.text!)!, month: Int(self.MonthField.text!)!, day: Int(self.DayField.text!)!))
        }
    }*/
    
    @IBAction func SavePlan(sender: AnyObject) {
        if checkDateValid(){
            let thisDate: NSDate = dateInput(Int(self.YearField.text!)!, month: Int(self.MonthField.text!)!, day: Int(self.DayField.text!)!)
            if thisDate.compare(NSDate()) == NSComparisonResult.OrderedAscending{
                if localization == "zh-HK" || localization == "zh-Hant-MO" || localization == "zh-TW"{
                    let historyAlert = UIAlertController(title: "出錯啦", message: "啊諾...這計劃日期是不是穿越了呢0.0", preferredStyle: .Alert)
                    historyAlert.addAction(UIAlertAction(title: "對哦(゜_゜>)", style: .Default, handler: nil))
                    self.presentViewController(historyAlert, animated: true, completion: nil)
                }else{
                    let historyAlert = UIAlertController(title: "出错辣", message: "啊诺...这计划日期是不是穿越了呢0.0", preferredStyle: .Alert)
                    historyAlert.addAction(UIAlertAction(title: "对哦(゜_゜>)", style: .Default, handler: nil))
                    self.presentViewController(historyAlert, animated: true, completion: nil)
                }
            }else{
                if SaveButton === sender {
                    if PhotoImageView.image! == UIImage(named: "seletephoto_zh") {
                        PhotoImageView.image = UIImage(named: "NoPhoto_zh")
                    }
                    editingPlan = Plan(roleName: self.RoleNameField.text!, anime: self.AnimeField.text!, version: self.VersionField.text!, photo: self.PhotoImageView.image, ware: [:], stuff: [:], date: thisDate)
                }
                self.performSegueWithIdentifier("unwindToDetail", sender: self)
            }
        }else{
            if localization == "zh-HK" || localization == "zh-Hant-MO" || localization == "zh-TW"{
                let dateErrorAlert = UIAlertController(title: "出錯啦", message: "啊諾...這計劃日期是不是有些奇怪呢0.0", preferredStyle: .Alert)
                dateErrorAlert.addAction(UIAlertAction(title: "對哦(゜_゜>)", style: .Default, handler: nil))
                self.presentViewController(dateErrorAlert, animated: true, completion: nil)
            }else{
                let dateErrorAlert = UIAlertController(title: "出錯啦", message: "啊诺...这计划日期是不是有些奇怪呢0.0", preferredStyle: .Alert)
                dateErrorAlert.addAction(UIAlertAction(title: "对哦(゜_゜>)", style: .Default, handler: nil))
                self.presentViewController(dateErrorAlert, animated: true, completion: nil)
            }
            
        }
    }
    @IBAction func beginEditing(sender: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    @IBAction func EndEditing(sender: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    
    @IBAction func checkEmpty(sender: UITextField) {
        if !RoleNameField.text!.isEmpty && !AnimeField.text!.isEmpty && !VersionField.text!.isEmpty && !YearField.text!.isEmpty && !MonthField.text!.isEmpty && !DayField.text!.isEmpty {
            SaveButton.enabled = true
        }else{
            SaveButton.enabled = false
        }
    }
    
    @IBAction func naviTitle(sender: UITextField) {
        self.title = RoleNameField.text!
    }
    
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = (up ? -moveValue : moveValue)
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    func checkDateValid() ->Bool{
        guard let textYear = YearField.text else { return false }
        guard (Int(textYear) != nil) else { return false }
        if textYear.characters.count > 4{
            return false
        }
        
        guard let textMonth = Int(MonthField.text!) else { return false }
        if textMonth > 12{
            return false
        }
        
        guard let textDay = Int(DayField.text!) else { return false }
        let daysInMonths = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        return textDay <= daysInMonths[Int(textMonth - 1)]
    }
    func initializeTextFields(){
        YearField.delegate = self
        YearField.keyboardType = UIKeyboardType.NumberPad
        MonthField.delegate = self
        MonthField.keyboardType = UIKeyboardType.NumberPad
        DayField.delegate = self
        DayField.keyboardType = UIKeyboardType.NumberPad
    }
    
}