//
//  planData.swift
//  Cos What
//
//  Created by 周建明 on 15/10/15.
//  Copyright © 2015年 Uncle Jerry. All rights reserved.
//

import Foundation
//variable
var planData = [Plan]()
let defaults = NSUserDefaults.standardUserDefaults()
let localization = NSLocale.preferredLanguages()[0] as String