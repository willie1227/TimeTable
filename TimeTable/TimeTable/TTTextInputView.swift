//
//  TTTextInputView.swift
//  TimeTable
//
//  Created by dulingkang on 15/12/25.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import UIKit

protocol TTTextInputViewDelegate {
    func textCancel()
    func textConfirm()
}

class TTTextInputView: UIView, UITextViewDelegate{

    let buttonHeight: CGFloat = 40
    var delegate: TTTextInputViewDelegate?
    var textView: UITextView!
    
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    //MARK: - event response
    func leftButtonPressed(_ sender: UIButton) {
        self.delegate?.textCancel()
    }
    
    func rightButtonPressed(_ sender: UIButton) {
        self.delegate?.textConfirm()
    }
    
    //MARK: - private method
    fileprivate func initViews() {
        self.backgroundColor = UIColor.black
        self.alpha = 0.8
        
        let usedView = UIView.init(frame: CGRect(x: self.width*0.2, y: self.height*0.2, width: self.width*0.6, height: self.height*0.5))
        usedView.backgroundColor = UIColor.white
        self.addSubview(usedView)
        
        textView = UITextView.init(frame: CGRect(x: 0, y: 0, width: usedView.width, height: usedView.height - buttonHeight))
        textView.text = "请输入多个人名，用空格分开！"
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = UIColor.lightGray
        textView.delegate = self
        usedView.addSubview(textView)
        
        let leftButton = UIButton.init(frame: CGRect(x: 6, y: usedView.height - buttonHeight - 5, width: usedView.width/2 - 10, height: buttonHeight))
        leftButton.backgroundColor = kGreenButtonColor
        leftButton.layer.cornerRadius = 10
        leftButton.setTitle("取消", for: UIControlState())
        leftButton.setTitleColor(UIColor.white, for: UIControlState())
        leftButton.addTarget(self, action: #selector(TTTextInputView.leftButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        usedView.addSubview(leftButton)
        
        let rightButton = UIButton.init(frame: CGRect(x: usedView.width/2 + 3, y: usedView.height - buttonHeight - 5, width: usedView.width/2 - 10, height: buttonHeight))
        rightButton.backgroundColor = kGreenButtonColor
        rightButton.layer.cornerRadius = 10
        rightButton.setTitle("确定", for: UIControlState())
        rightButton.setTitleColor(UIColor.white, for: UIControlState())
        rightButton.addTarget(self, action: #selector(TTTextInputView.rightButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        usedView.addSubview(rightButton)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        textView.textColor = UIColor.black
        return true
    }
}
