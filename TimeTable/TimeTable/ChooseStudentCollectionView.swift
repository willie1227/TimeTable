//
//  ChooseStudentCollectionView.swift
//  TimeTable
//
//  Created by dulingkang on 15/12/25.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import UIKit
import RealmSwift

class ChooseStudentCollectionCell: UICollectionViewCell {
    var label: UILabel!
    var backView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        backView = UIView.init(frame: CGRect(x: self.width*0.05, y: self.height*0.05, width: self.width*0.9, height: self.height*0.9))
        backView.backgroundColor = kGreenBackColor
        self.addSubview(backView)
        
        label = UILabel.init(frame: self.bounds)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        self.addSubview(label)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
}

protocol ChooseStudentDelegate {
    func didChooseStudent(_ name: String)
}

class ChooseStudentCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var nameArray: [String] = []
    var chooseStudentDelegate: ChooseStudentDelegate?
    
    //MARK: - life cycle
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.white
        self.initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    //MARK: - collectionView datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "chooseStudentCollectionCell"
        collectionView.register(ChooseStudentCollectionCell.self, forCellWithReuseIdentifier: identifier)
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ChooseStudentCollectionCell
        if cell == nil {
            cell = ChooseStudentCollectionCell()
        }
        
        cell!.label.text = self.nameArray[(indexPath as NSIndexPath).row]

        return cell!
    }
    
    //MARK: - collectionView delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.chooseStudentDelegate?.didChooseStudent(self.nameArray[(indexPath as NSIndexPath).row])
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 30)
    }
    
    //MARK: - private method
    fileprivate func initViews() {
        self.addNameArray()
    }
    
    func addNameArray() {
        let realm = try! Realm()
        let studentsArray = realm.objects(Students.self)
        self.nameArray.removeAll()
        for student in studentsArray {
            let stu = student as Students
            self.nameArray.append(stu.name)
        }
    }
    
    func reloadChooseView() {
        self.addNameArray()
        self.reloadData()
    }
}
