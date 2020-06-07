//
//  addEvents.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/23/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class addEvents: UIView {
    @IBOutlet weak var markLabel: UITextField!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    var stat = ""
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func labelToSlider() {
        let u = valKeyDict[stat]
        if stat == "3200M" {
            let mark = markLabel.text!
            let splitMark = (mark.split(separator: ":"))
            let intMins = Int(splitMark[0])
            let intSecs = Int(splitMark[1])
            slider.value = Float(intMins! * 60 + intSecs!)
            return
        } else if ftEvents.contains(stat) {
            slider.value = Float(User.stringToFt(markLabel.text!))
        }  else if doubleEvents.contains(valKeyDict[stat]!) {
            slider.value = Float(User.stringToDouble(markLabel.text!))
        } else if intEvents.contains(valKeyDict[stat]!) {
            slider.value = Float(User.stringToSecs(markLabel.text!))
        }
        return
    }
    
    @IBAction func editingEnd(_ sender: Any) {
        if markLabel.text == "" || markLabel.text == nil {
            if stat == "SAT" || stat == "ACT" {
                markLabel.text = "0"
            } else if intEvents.contains(valKeyDict[stat]!) {
                markLabel.text = "0:00"
            } else {
                markLabel.text = "0.0"
            }
        }
        labelToSlider()
    }
    
    
    @IBAction func sliderChanged(_ sender: Any) {
        if stat == "3200M" || stat == "1600M" {
            let sliderSecs = Int(slider.value)
            let mins = (sliderSecs / 60)
            let secs = (sliderSecs - (mins * 60))
            let stringMins = String(mins)
            var stringSecs = "0"
            if secs < 10 {
                stringSecs = stringSecs + String(secs)
            } else {
                stringSecs = String(secs)
            }
            markLabel.text = stringMins + ":" + stringSecs
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.selectionChanged()
            return
        }
        if stat == "SAT" || stat == "ACT" {
            markLabel.text = String(Int(slider.value))
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.selectionChanged()
            return
        }
        if ftEvents.contains(stat) {
            markLabel.text = User.ftToString(Double(slider.value))
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.selectionChanged()
            return
        }
        markLabel.text = User.doubleToString(Double(slider.value).truncate(places: 2))
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
    }
    
    func checkShortTrackFormat(textField: UITextField) {
        let text: String = textField.text!
        if !text.contains(".") {
            if text.count > 2 {
                textField.deleteBackward()
            }
        } else {
            let charArr = Array(text)
            let periodCount = charArr.filter{$0 == "."}.count
            if periodCount > 1 {
                textField.deleteBackward()
            } else if charArr[0] == "." {
                textField.deleteBackward()
            }
        }
    }
    
    func checkLongTrackFormat(textField: UITextField) {
        let text: String = textField.text!
        if !text.contains(".") && !text.contains(":") {
            if text.count > 2 {
                textField.deleteBackward()
            }
        } else {
            let charArr = Array(text)
            if charArr.contains(":") {
                let colonCount = charArr.filter{$0 == ":"}.count
                if colonCount > 1 {
                    textField.deleteBackward()
                }
                if charArr.count == 1 {
                    textField.deleteBackward()
                }
                if charArr.count > 3 {
                    if !(charArr[1] == ":" || charArr[2] == ":") {
                        textField.deleteBackward()
                    }
                }
            } else if charArr.contains(".") {
                let periodCount = charArr.filter{$0 == "."}.count
                if periodCount > 1 {
                    textField.deleteBackward()
                } else if charArr.count == 1 {
                    textField.deleteBackward()
                }
            } else {
                let charArr = Array(text)
                if charArr.contains(":") && charArr.contains(".") {
                    if charArr.firstIndex(of: ".")! > charArr.firstIndex(of: ":")! {
                        textField.text = ""
                    }
                }
            }
        }
    }
    
    func checkFieldFormat(textField: UITextField) {
        let text: String = textField.text!
        if text.count == 1 {
            if text.contains("-") || text.contains(".") {
                textField.deleteBackward()
            }
        } else if text.count == 3 {
            let charArr = Array(text)
            let dashCount = charArr.filter{$0 == "-"}.count
            let periodCount = charArr.filter{$0 == "."}.count
            if dashCount > 1 {
                textField.deleteBackward()
            }
            if periodCount > 1 {
                textField.deleteBackward()
            }
        } else {
            let charArr = Array(text)
            if charArr.contains(":") && charArr.contains("-") {
                if charArr.firstIndex(of: ".")! > charArr.firstIndex(of: "-")! {
                    textField.text = ""
                }
            }
        }
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text!.count > maxLength) {
            textField.deleteBackward()
        }
    }
    
    func checkAllowedChars(textField: UITextField, allowedChars: [Character]) {
        for char in textField.text! {
            if !(allowedChars.contains(char)) {
                textField.deleteBackward()
            }
        }
    }
    
    @IBAction func editStart(_ sender: Any) {
        //markLabel.text = ""
    }
    
    @IBAction func labelChanged(_ sender: Any) {
        switch stat {
        case "GPA":
            checkMaxLength(textField: markLabel, maxLength: 4)
            checkAllowedChars(textField: markLabel, allowedChars: gpaChars)
        case "SAT":
            checkMaxLength(textField: markLabel, maxLength: 4)
            checkAllowedChars(textField: markLabel, allowedChars: testScoreChars)
        case "ACT":
            checkMaxLength(textField: markLabel, maxLength: 2)
            checkAllowedChars(textField: markLabel, allowedChars: testScoreChars)
        case "3200M":
            checkMaxLength(textField: markLabel, maxLength: 5)
            checkAllowedChars(textField: markLabel, allowedChars: intEventChars)
            checkLongTrackFormat(textField: markLabel)
        case "1600M":
            checkMaxLength(textField: markLabel, maxLength: 5)
            checkAllowedChars(textField: markLabel, allowedChars: intEventChars)
            checkLongTrackFormat(textField: markLabel)
        case "100M":
            checkMaxLength(textField: markLabel, maxLength: 5)
            checkAllowedChars(textField: markLabel, allowedChars: doubleEventChars)
            checkShortTrackFormat(textField: markLabel)
        case "200M":
            checkMaxLength(textField: markLabel, maxLength: 5)
            checkAllowedChars(textField: markLabel, allowedChars: doubleEventChars)
            checkShortTrackFormat(textField: markLabel)
        case "400M":
            checkMaxLength(textField: markLabel, maxLength: 6)
            checkAllowedChars(textField: markLabel, allowedChars: doubleEventChars)
            checkLongTrackFormat(textField: markLabel)
        case "800M":
            checkMaxLength(textField: markLabel, maxLength: 7)
            checkAllowedChars(textField: markLabel, allowedChars: doubleEventChars)
            checkLongTrackFormat(textField: markLabel)
        case "110M Hurdles":
            checkMaxLength(textField: markLabel, maxLength: 5)
            checkAllowedChars(textField: markLabel, allowedChars: doubleEventChars)
            checkShortTrackFormat(textField: markLabel)
        case "300M Hurdles":
            checkMaxLength(textField: markLabel, maxLength: 6)
            checkAllowedChars(textField: markLabel, allowedChars: doubleEventChars)
            checkLongTrackFormat(textField: markLabel)
        case "Shotput":
            checkMaxLength(textField: markLabel, maxLength: 8)
            checkAllowedChars(textField: markLabel, allowedChars: fieldEventChars)
            checkFieldFormat(textField: markLabel)
        case "Discus":
            checkMaxLength(textField: markLabel, maxLength: 9)
            checkAllowedChars(textField: markLabel, allowedChars: fieldEventChars)
            checkFieldFormat(textField: markLabel)
        case "High Jump":
            checkMaxLength(textField: markLabel, maxLength: 7)
            checkAllowedChars(textField: markLabel, allowedChars: fieldEventChars)
            checkFieldFormat(textField: markLabel)
        case "Long Jump":
            checkMaxLength(textField: markLabel, maxLength: 8)
            checkAllowedChars(textField: markLabel, allowedChars: fieldEventChars)
            checkFieldFormat(textField: markLabel)
        case "Triple Jump":
            checkMaxLength(textField: markLabel, maxLength: 8)
            checkAllowedChars(textField: markLabel, allowedChars: fieldEventChars)
            checkFieldFormat(textField: markLabel)
        case "Pole Vault":
            checkMaxLength(textField: markLabel, maxLength: 8)
            checkAllowedChars(textField: markLabel, allowedChars: fieldEventChars)
            checkFieldFormat(textField: markLabel)
        default:
            checkMaxLength(textField: markLabel, maxLength: 9)
        }
    }
    
    
}
