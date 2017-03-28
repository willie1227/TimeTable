//
//  TTMainView.swift
//  TimeTable
//
//  Created by dulingkang on 15/12/24.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import UIKit

let kGreenButtonColor = UIColor(red: 0.082, green: 0.584, blue: 0.278, alpha: 1.0)

protocol TTMainViewDelegte {
    func addStudentsPressed()
    func didSelectCollectionCell(_ index: Int)
    func settingButtonPressed()
}

class TTMainView: UIView, TTSingleCollectionViewDelegate {

    let topLabelViewHeight: CGFloat = 40
    let topOneLabelWidth: CGFloat = 100
    let bottomHeight: CGFloat = 47
    let todayViewHeight: CGFloat = 40
    let margin: CGFloat = 1
    let dayLabelStartTag: Int = 1200

    let leftViewWidth: CGFloat = 25
    let topWeekViewHeight: CGFloat = 50
    let topWeekViewRightMargin: CGFloat = 5
    
    fileprivate var topView: UIView!
    fileprivate var todayView: UIView!
    fileprivate var weekTopView: UIView!
    fileprivate var dayLabelView: UIView!
    fileprivate var leftView: UIView?
    
    var topLeftLabel: TTLabel!
    var topRightLabel: TTLabel!
    var weekMiddleLabel: TTLabel!
    
    var singleCollectionView: TTSingleCollectionView?
    var delegate: TTMainViewDelegte?
    
    var adsView: UIView!
    
    var mainViewIndex: Int = 0 {
        didSet {
            DateModel.sharedInstance.index = mainViewIndex
            self.reloadViews()
        }
    }
    var dayStrArray: [String] = []
    
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)        
        self.initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    //MARK: - event response
    func settingButtonPressed(_ sender: UIButton) {
        self.delegate?.settingButtonPressed()
    }
    
    func thisWeekButtonPressed(_ sender: UIButton) {
        self.mainViewIndex = 0
    }
    
    func listButtonPressed(_ sender: UIButton) {
        self.delegate?.addStudentsPressed()
    }
    
    //MARK: - delegate
    func didSelectedCollectionCell(_ index: Int) {
        self.delegate?.didSelectCollectionCell(index)
    }
    
    //MARK: - public method
    func refreshView() {
        refreshLeftView()
        singleCollectionView?.removeFromSuperview()
        self.addCollectionView()
    }
    
    func refreshLeftView() {
        leftView?.removeFromSuperview()
        addLeftView()
    }
    
    //MARK: - private method
    fileprivate func initViews() {
        self.backgroundColor = UIColor.white
        self.addTopView()
        self.addTodayView()
        self.addWeekTopView()
        self.addLeftView()
        self.addCollectionView()
//        self.addBottomButtons()
        addBottomAdsView()
    }
    
    fileprivate func addTopView() {
        let now = Date()
        
        topView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.width, height: topLabelViewHeight))
        topView.backgroundColor = kGreenButtonColor
        self.addSubview(topView)
        
        let topLeftLabelLeftMargin = (self.width - 2 * topOneLabelWidth)/2
        self.topLeftLabel = TTLabel.init(frame: CGRect(x: topLeftLabelLeftMargin, y: 0, width: topOneLabelWidth, height: topLabelViewHeight))
        topLeftLabel.text = DateModel.sharedInstance.daysInWeek[0]
        topView.addSubview(topLeftLabel)
        
        self.topRightLabel = TTLabel.init(frame: CGRect(x: topLeftLabelLeftMargin + topOneLabelWidth, y: 0, width: topOneLabelWidth, height: topLabelViewHeight))
        topRightLabel.text = DateModel.sharedInstance.daysInWeek[6]
        topView.addSubview(topRightLabel)
        
        let topMiddleLabel = TTLabel.init(frame: CGRect(x: (self.width - 10)/2, y: 0, width: 10, height: topLabelViewHeight))
        topMiddleLabel.text = "~"
        topView.addSubview(topMiddleLabel)
        
        /************** 第几周 ****************/
        let weekLabelWidth: CGFloat = 60
        let weekView = UIView.init(frame: CGRect(x: 10, y: 0, width: weekLabelWidth, height: topLabelViewHeight))
        topView.addSubview(weekView)
        
        let weekLeftLabel = TTLabel.init(frame: CGRect(x: 0, y: 0, width: 20, height: topLabelViewHeight))
        weekLeftLabel.text = "第"
        weekView.addSubview(weekLeftLabel)
        
        weekMiddleLabel = TTLabel.init(frame: CGRect(x: 20, y: 0, width: 20, height: topLabelViewHeight))
        weekMiddleLabel.text = String(now.WeekOfYear())
        weekView.addSubview(weekMiddleLabel)

        let weekRightLabel = TTLabel.init(frame: CGRect(x: 40, y: 0, width: 20, height: topLabelViewHeight))
        weekRightLabel.text = "周"
        weekView.addSubview(weekRightLabel)
        
        /************** 设置 ****************/
        let settingButton = UIButton(type: .custom)
        settingButton.frame = CGRect(x: kScreenWidth - kButtonClickWidth - 4, y: 0, width: kButtonClickWidth, height: kButtonClickWidth)
        settingButton.contentMode = .center
        settingButton.setAllImage("settingButton")
        settingButton.addTarget(self, action: #selector(TTMainView.settingButtonPressed(_:)), for: .touchUpInside)
        topView.addSubview(settingButton)
        
    }
    
    fileprivate func addTodayView() {
        todayView = UIView.init(frame: CGRect(x: 0, y: topLabelViewHeight + margin, width: self.width, height: todayViewHeight))
        todayView.backgroundColor = kGreenButtonColor
        self.addSubview(todayView)
        
        let todayLabelWidth: CGFloat = 200
        let todayLabel = TTLabel.init(frame: CGRect(x: (self.width - todayLabelWidth)/2, y: 0, width: todayLabelWidth, height: todayViewHeight))
        todayLabel.text = "今天: " + CalendarHelper.currentTimeString()
        todayView.addSubview(todayLabel)

        addThisWeekButton()
        addListButton()
    }
    
    fileprivate func addThisWeekButton() {
        let thisWeekButton = UIButton(type: .custom)
        thisWeekButton.frame = CGRect(x: 4, y: 0, width: kButtonClickWidth, height: kButtonClickWidth)
        thisWeekButton.contentMode = .center
        thisWeekButton.setAllImage("thisWeek")
        thisWeekButton.addTarget(self, action: #selector(TTMainView.thisWeekButtonPressed(_:)), for: .touchUpInside)
        todayView.addSubview(thisWeekButton)
    }
    
    fileprivate func addListButton() {
        let listButton = UIButton(type: .custom)
        listButton.frame = CGRect(x: kScreenWidth - kButtonClickWidth - 4, y: 0, width: kButtonClickWidth, height: kButtonClickWidth)
        listButton.contentMode = .center
        listButton.setAllImage("studentList")
        listButton.addTarget(self, action: #selector(TTMainView.listButtonPressed(_:)), for: .touchUpInside)
        todayView.addSubview(listButton)
    }
    
    fileprivate func addWeekTopView() {
        weekTopView = UIView.init(frame: CGRect(x: 0, y: todayView.bottom + margin, width: self.width, height: topWeekViewHeight))
        weekTopView.backgroundColor = kGreenButtonColor
        let labelView = UIView.init(frame: CGRect(x: leftViewWidth, y: 8, width: self.width - leftViewWidth - topWeekViewRightMargin, height: topWeekViewHeight/2))
        self.addSubview(weekTopView)
        weekTopView.addSubview(labelView)
        let weekText = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
        for i in 0..<weekText.count {
            let iFloat = CGFloat(i)
            let label = TTLabel.init(frame: CGRect(x: cellWidth * iFloat, y: 0, width: cellWidth, height: labelView.height))
            label.text = weekText[i]
            labelView.addSubview(label)
        }
        self.addWeekDayLabelView()
    }
    
    fileprivate func addWeekDayLabelView() {
        dayLabelView = UIView.init(frame: CGRect(x: leftViewWidth, y: topWeekViewHeight/2, width: self.width - leftViewWidth - topWeekViewRightMargin, height: topWeekViewHeight/2))
        weekTopView.addSubview(dayLabelView)
        dayStrArray = CalendarHelper.fullDaysToDay(DateModel.sharedInstance.daysInWeek)
        for i in 0..<dayStrArray.count {
            let iFloat = CGFloat(i)
            let label = TTLabel.init(frame: CGRect(x: cellWidth * iFloat, y: 0, width: cellWidth, height: dayLabelView.height), fontSize: 12)
            label.text = dayStrArray[i]
            label.tag = dayLabelStartTag + i
            dayLabelView.addSubview(label)
        }
    }
    
    fileprivate func addLeftView() {
        let count = TimeStr.sharedInstance.count
        leftView = UIView.init(frame: CGRect(x: 0, y: weekTopView.bottom - 4, width: leftViewWidth, height: TimeStr.sharedInstance.cellHeight*CGFloat(count - 1) + 14))
        leftView!.backgroundColor = kGreenButtonColor
        self.addSubview(leftView!)
        
        for i in 0..<count {
            let iFloat = CGFloat(i)
            let label = UILabel.init(frame: CGRect(x: 0, y: TimeStr.sharedInstance.cellHeight * iFloat, width: leftView!.width, height: 12))
            label.text = TimeStr.sharedInstance.displayedTimeStr[i]
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 14)
            label.textAlignment = NSTextAlignment.center
            leftView!.addSubview(label)
        }
    }
    
    fileprivate func addCollectionView() {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        singleCollectionView = TTSingleCollectionView.init(frame: CGRect(x: leftViewWidth, y: weekTopView.bottom + margin, width: self.width - leftViewWidth - topWeekViewRightMargin, height: kScreenHeight - topLabelViewHeight - todayViewHeight - topWeekViewHeight - bottomHeight - 5), collectionViewLayout: layout)
        singleCollectionView!.singleCollectionDelegate = self
        singleCollectionView!.backgroundColor = UIColor.white
        self.addSubview(singleCollectionView!)
    }
    
//    private func addBottomButtons() {
//        
//        let bottomView = UIView.init(frame: CGRectMake(0, self.height - bottomHeight - 5, self.width, bottomHeight))
//        bottomView.backgroundColor = UIColor.clearColor()
//        self.addSubview(bottomView)
//        
//        let leftButton = UIButton.init(frame: CGRectMake(6, 0, self.width/2 - 10, bottomHeight))
//        leftButton.backgroundColor = kGreenButtonColor
//        leftButton.layer.cornerRadius = 10
//        leftButton.setTitle("本周", forState: UIControlState.Normal)
//        leftButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        leftButton.addTarget(self, action: #selector(TTMainView.leftButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        bottomView.addSubview(leftButton)
//
//        let rightButton = UIButton.init(frame: CGRectMake(self.width/2 + 3, 0, self.width/2 - 10, bottomHeight))
//        rightButton.backgroundColor = kGreenButtonColor
//        rightButton.layer.cornerRadius = 10
//        rightButton.setTitle("列表", forState: UIControlState.Normal)
//        rightButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        rightButton.addTarget(self, action: #selector(TTMainView.rightButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//
//        bottomView.addSubview(rightButton)
//    }
    
    fileprivate func addBottomAdsView() {
        adsView = UIView.init(frame: CGRect(x: 0, y: kScreenHeight - bottomHeight, width: kScreenWidth, height: bottomHeight))
        adsView.backgroundColor = kGreenButtonColor
        self.addSubview(adsView)
    }
    
    fileprivate func refreshDaysLabelInWeek() {
        for view in dayLabelView.subviews {
            if view.isKind(of: TTLabel.self) {
                let label = view as! TTLabel
                label.text = dayStrArray[label.tag - dayLabelStartTag]
            }
        }
    }
    
    fileprivate func reloadViews() {
        let date = DateModel.sharedInstance.currentDate
        topLeftLabel.text = DateModel.sharedInstance.daysInWeek[0]
        topRightLabel.text = DateModel.sharedInstance.daysInWeek[6]
        weekMiddleLabel.text = String(date.WeekOfYear())
        dayStrArray = CalendarHelper.fullDaysToDay(DateModel.sharedInstance.daysInWeek)
        refreshDaysLabelInWeek()
        singleCollectionView?.reloadData()
    }
}

