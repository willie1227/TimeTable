//
//  ClassModel.swift
//  TimeTable
//
//  Created by dulingkang on 15/12/23.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import RealmSwift

class ClassModel: Object {
//    dynamic var year: Int = 2015 //2015-2016
//    dynamic var month: Int = 12 //1-58
//    dynamic var day: Int = 24  //1-31
//    dynamic var hour: Int = 1 //1-7
    dynamic var id: String = "2015-12-24-1"
    dynamic var name: String = ""
    
    convenience init(id: String, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }

}

class Students: Object {
    dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
