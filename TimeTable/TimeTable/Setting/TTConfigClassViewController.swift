//
//  TTConfigClassViewController.swift
//  TimeTable
//
//  Created by dulingkang on 16/3/31.
//  Copyright © 2016年 dulingkang. All rights reserved.
//

import UIKit

class TTConfigClassViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var amBeginText: UITextField!
    @IBOutlet weak var amEndText: UITextField!
    @IBOutlet weak var pmBeginText: UITextField!
    @IBOutlet weak var pmEndText: UITextField!
    @IBOutlet weak var stepText: UITextField!
    //MARK: - life cycle
    override func viewDidLoad() {
        self.view.backgroundColor = kGreenBackColor
        setTextDelegates()
        setTextDefaultValue()
    }
    
    //MARK: - UITextField delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let sharedTimeStr = TimeStr.sharedInstance
        switch textField {
        case amBeginText:
            sharedTimeStr.amBeginTime = Int(textField.text!)!
        case amEndText:
            sharedTimeStr.amEndTime = Int(textField.text!)!
        case pmBeginText:
            sharedTimeStr.pmBeginTime = Int(textField.text!)!
        case pmEndText:
            sharedTimeStr.pmEndTime = Int(textField.text!)!
        case stepText:
            sharedTimeStr.step = Int(textField.text!)!
        default:
            break
        }
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - private method
    func setTextDelegates() {
        amBeginText.delegate = self
        amEndText.delegate = self
        pmBeginText.delegate = self
        pmEndText.delegate = self
        stepText.delegate = self
    }
    
    func setTextDefaultValue() {
        let sharedTimeStr = TimeStr.sharedInstance
        amBeginText.text = "\(sharedTimeStr.amBeginTime)"
        amEndText.text = "\(sharedTimeStr.amEndTime)"
        pmBeginText.text = "\(sharedTimeStr.pmBeginTime)"
        pmEndText.text = "\(sharedTimeStr.pmEndTime)"
        stepText.text = "\(sharedTimeStr.step)"
    }
}
