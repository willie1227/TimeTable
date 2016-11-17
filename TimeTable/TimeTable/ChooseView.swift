//
//  ChooseView.swift
//  TimeTable
//
//  Created by dulingkang on 15/12/28.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import UIKit

protocol ChooseViewDelegate {
    func cancelChoose()
    func deleteName()
    func didSelectedStudent(_ name: String)
}

class ChooseView: UIView, ChooseStudentDelegate {

    var chooseCollectionView: ChooseStudentCollectionView?
    var delegate: ChooseViewDelegate?
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    //MARK: - delegate
    func didChooseStudent(_ name: String) {
        self.delegate?.didSelectedStudent(name)
    }
    
    //MARK: - private method
    fileprivate func initViews() {
        self.addTopView()
        self.addCollectionView()
    }
    
    fileprivate func addTopView() {
        let topView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.width, height: kButtonClickWidth))
        topView.backgroundColor = kGreenButtonColor
        self.addSubview(topView)
        
        let deleteButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: kButtonClickWidth, height: kButtonClickWidth))
        deleteButton.setTitle("删除", for: UIControlState())
        deleteButton.addTarget(self, action: #selector(ChooseView.deleteButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        topView.addSubview(deleteButton)
        
        let button = UIButton.init(frame: CGRect(x: self.width - kButtonClickWidth, y: 0, width: kButtonClickWidth, height: kButtonClickWidth))
        button.setTitle("取消", for: UIControlState())
        button.addTarget(self, action: #selector(ChooseView.cancelButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        topView.addSubview(button)
    }
    
    fileprivate func addCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        chooseCollectionView = ChooseStudentCollectionView.init(frame: CGRect(x: 0, y: kButtonClickWidth, width: self.width, height: self.height), collectionViewLayout: layout)
        chooseCollectionView?.chooseStudentDelegate = self
        self.addSubview(chooseCollectionView!)
    }
    
    func cancelButtonPressed(_ sender: UIButton) {
        self.delegate?.cancelChoose()
    }
    
    func deleteButtonPressed(_ sender: UIButton) {
        self.delegate?.deleteName()
    }
}
