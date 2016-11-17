//
//  RealmManager.swift
//  TimeTable
//
//  Created by dulingkang on 15/12/25.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import RealmSwift

struct RealmManager {
    
    static func saveStringsToRealm(_ strings: String) {
        let stringArray = strings.components(separatedBy: " ")
        let realm = try! Realm()
        realm.beginWrite()
        for name in stringArray {
            if !name.isEmpty {
                let predicate = NSPredicate(format: "name == %@", name)
                let findName = realm.objects(Students.self).filter(predicate)
                if findName.count == 0{
                    let students = Students()
                    students.name = name
                    realm.add(students)
                }
            }
        }
        try! realm.commitWrite()
    }
    
    static func saveObjectToRealm(_ obj: Object, id: String) {
        self.deleteOneClass(id)
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(obj)
        try! realm.commitWrite()
    }
    
    static func findNameWithString(_ string: String) -> String? {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == %@", string)
        let findName = realm.objects(ClassModel.self).filter(predicate)
        if findName.count != 0 {
            return findName[0].name
        } else {
            return nil
        }
    }
    
    static func deleteOneClass(_ id: String) {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == %@", id)
        let findName = realm.objects(ClassModel.self).filter(predicate)
        if findName.count != 0 {
            realm.beginWrite()
            realm.delete(findName)
            try! realm.commitWrite()
        }
    }
    
    static func deleteOneStudent(_ name: String) {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "name == %@", name)
        let findStudent = realm.objects(Students.self).filter(predicate)
        let findClass = realm.objects(ClassModel.self).filter(predicate)
        realm.beginWrite()
        realm.delete(findStudent)
        realm.delete(findClass)
        try! realm.commitWrite()
    }
}
