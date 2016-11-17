//
//  TTSingleCollectionView.swift
//  TimeTable
//
//  Created by dulingkang on 15/12/24.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import UIKit

let cellWidth = (kScreenWidth - 30)/7
let kGreenBackColor = UIColor(red: 0.918, green: 0.988, blue: 0.878, alpha: 1.0)

class TTSingleCollectionCell: UICollectionViewCell {
    var label: UILabel!
    var backView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        backView = UIView.init(frame: CGRect(x: self.width*0.05, y: self.height*0.05, width: self.width*0.9, height: self.height*0.9))
        backView.backgroundColor = kGreenBackColor
        self.addSubview(backView)
        
        let labelHeight: CGFloat = 12
        label = UILabel.init(frame: CGRect(x: 0, y: (TimeStr.sharedInstance.cellHeight - labelHeight)/2, width: cellWidth, height: labelHeight))
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

protocol TTSingleCollectionViewDelegate {
    func didSelectedCollectionCell(_ index: Int)
}

class TTSingleCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var singleCollectionDelegate: TTSingleCollectionViewDelegate?
    
    //MARK: - life cycle
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }

    //MARK: - collectionView datasource    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7 * (TimeStr.sharedInstance.count - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "ttSingleCollectionCell"
        collectionView.register(TTSingleCollectionCell.self, forCellWithReuseIdentifier: identifier)
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? TTSingleCollectionCell
        if cell == nil {
            cell = TTSingleCollectionCell()
        }
        let selectedId = CalendarHelper.selectedIdBySingleIndex((indexPath as NSIndexPath).row)
        cell!.label.text = RealmManager.findNameWithString(selectedId)
        cell!.backView.backgroundColor = kGreenBackColor
        
        return cell!
    }
    
    //MARK: - collectionView delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for oneCell in self.visibleCells {
            let one = oneCell as! TTSingleCollectionCell
            one.backView.backgroundColor = kGreenBackColor
        }
        
        let cell = self.cellForItem(at: indexPath) as! TTSingleCollectionCell
        cell.backView.backgroundColor = UIColor.gray
        
        self.singleCollectionDelegate?.didSelectedCollectionCell((indexPath as NSIndexPath).row)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: TimeStr.sharedInstance.cellHeight)
    }

}
