//
//  StudentsTableView.swift
//  TimeTable
//
//  Created by dulingkang on 16/1/21.
//  Copyright © 2016年 dulingkang. All rights reserved.
//

import UIKit
import RealmSwift

class StudentsTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    var nameArray: [String] = []
    //MARK: - life cycle
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.initViews()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    //MARK: - private method
    fileprivate func initViews() {
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.white
        self.addNamesToArray()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "StudentsTableViewCell")
        
        cell.textLabel?.text = nameArray[(indexPath as NSIndexPath).row]        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            RealmManager.deleteOneStudent(nameArray[(indexPath as NSIndexPath).row])
            nameArray.remove(at: (indexPath as NSIndexPath).row)
            self.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func addNamesToArray() {
        let realm = try! Realm()
        let studentsArray = realm.objects(Students.self)
        self.nameArray.removeAll()
        for student in studentsArray {
            let stu = student as Students
            self.nameArray.append(stu.name)
        }
    }
    
    func reloadStudentsTable() {
        self.addNamesToArray()
        self.reloadData()
    }
}
