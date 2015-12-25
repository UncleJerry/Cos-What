//
//  Script.swift
//  出什么
//
//  Created by 周建明 on 15/12/10.
//  Copyright © 2015年 Uncle Jerry. All rights reserved.
//

import Foundation
import UIKit

class Script: NSObject, NSCoding {

    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("scriptData")//url
    
    struct PropertyKey{
        static let titleKey = "title"
        static let contentKey = "content"
        static let modifiedTimeKey = "modifiedTime"
    }
    
    
    var title: String
    var content: String
    var modifiedTime: NSDate
    
    init(inputText: String){
        content = inputText
        modifiedTime = NSDate()
        title = ""
        super.init()
    }

    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(modifiedTime, forKey: PropertyKey.modifiedTimeKey)
        aCoder.encodeObject(content, forKey: PropertyKey.contentKey)
    }

    required convenience init?(coder aDecoder: NSCoder){
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let content = aDecoder.decodeObjectForKey(PropertyKey.contentKey) as! String
        let modifiedTime = aDecoder.decodeObjectForKey(PropertyKey.modifiedTimeKey)as! NSDate

        self.init(title: title, content: content, modifiedTime: modifiedTime)
    }

}