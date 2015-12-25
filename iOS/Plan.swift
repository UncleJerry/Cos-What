//
//  Plan.swift
//  CosPlan
//
//  Created by 周建明 on 15/9/18.
//  Copyright © 2015年 Uncle Jerry. All rights reserved.
//

import Foundation
import UIKit

class Plan: NSObject, NSCoding {
    // MARK: Properties
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("planData")//url
    
    //key for telling system what to store
    struct PropertyKey {
        static let nameKey = "roleName"
        static let animeKey = "anime"
        static let versionKey = "version"
        static let wareKey = "ware"
        static let photoKey = "photo"
        static let stuffKey = "stuff"
        static let dateKey = "date"
    }
    //variable
    var roleName: String
    var anime: String
    var version: String
    var ware = [String: Bool]()
    var stuff = [String: [String]]()
    var photo: UIImage?
    var date: NSDate
    
    
    
    init(roleName: String, anime: String, version: String, photo: UIImage?, ware: [String: Bool], stuff: [String: [String]], date: NSDate){
        self.roleName = roleName
        self.anime = anime
        self.version = version
        self.photo = photo
        self.stuff = stuff
        self.ware = ware
        self.date = date
        
        super.init()
    }
    //coding the data to local
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(roleName, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(anime, forKey: PropertyKey.animeKey)
        aCoder.encodeObject(version, forKey: PropertyKey.versionKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(ware, forKey: PropertyKey.wareKey)
        aCoder.encodeObject(stuff, forKey: PropertyKey.stuffKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        
    }
    //load from local
    required convenience init?(coder aDecoder: NSCoder) {
        let roleName = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let anime = aDecoder.decodeObjectForKey(PropertyKey.animeKey) as! String
        let version = aDecoder.decodeObjectForKey(PropertyKey.versionKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let ware = aDecoder.decodeObjectForKey(PropertyKey.wareKey) as! [String: Bool]
        let stuff = aDecoder.decodeObjectForKey(PropertyKey.stuffKey) as! [String: [String]]
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        
        self.init(roleName: roleName, anime: anime, version: version, photo: photo, ware: ware, stuff: stuff, date: date)
    }
    
}




