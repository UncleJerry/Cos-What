//
//  AddWareController.swift
//  出什么
//
//  Created by 周建明 on 15/10/20.
//  Copyright © 2015年 Uncle Jerry. All rights reserved.
//

import UIKit

class AddWareController: UIViewController{

    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var WareStatusSwitch: UISwitch!
    @IBOutlet weak var WareName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        SaveButton.enabled = false
        WareName.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func checkEmpty(sender: UITextField) {
        self.title = WareName.text
        if !WareName.text!.isEmpty{
            SaveButton.enabled = true
        }else{
            SaveButton.enabled = false
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
