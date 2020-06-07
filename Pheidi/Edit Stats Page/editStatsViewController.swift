//
//  editStatsViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/22/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import StatusAlert
import CoreData


let gpaChars: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
let testScoreChars: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
let intEventChars: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ":", "0"]
let doubleEventChars: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ".", "0"]
let fieldEventChars: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "-", "0"]

class editStatsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var label: UITextField!
    @IBOutlet weak var slider: UISlider!
    var stat: String? = nil
    var initVal: String? = nil
    var fromAdd: Bool = false
    var key: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Edit " + stat!
        label.becomeFirstResponder()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        let alphaColor = UIColor(red:0.00, green:0.70, blue:0.56, alpha:1.0)
        pheidiColors.addGradientColorToView(view: self.view, color: alphaColor)
        
        let minMaxArr = statSettings[stat!]
        slider.maximumValue = Float(minMaxArr![1])
        slider.minimumValue = Float(minMaxArr![0])
        label.becomeFirstResponder()
        
        switch stat! {
        case "SAT":
            //label.text = initVal!
            //slider.value = Float(initVal!)!
            initVal = String(user.sat)
            label.text = String(user.sat)
            slider.value = Float(user.sat)
        case "ACT":
//            label.text = initVal!
//            slider.value = Float(initVal!)!
            initVal = String(user.act)
            label.text = String(user.act)
            slider.value = Float(user.act)
        case "3200M":
//            label.text = initVal!
//            slider.value = Float(user.twoMile)
            initVal = User.secsToString(user.twoMile)
            label.text = User.secsToString(user.twoMile)
            slider.value = Float(user.twoMile)
        case "GPA":
//            label.text = initVal!
//            slider.value = Float(initVal!)!
            initVal = String(user.gpa)
            label.text = String(user.gpa)
            slider.value = Float(user.gpa)
        case "100M":
//            label.text = initVal!
//            slider.value = Float(user.onehundredm)
            initVal = User.doubleToString(user.onehundredm)
            label.text = User.doubleToString(user.onehundredm)
            slider.value = Float(user.onehundredm)
        case "200M":
//            label.text = initVal!
//            slider.value = Float(user.twohundredm)
            initVal = User.doubleToString(user.twohundredm)
            label.text = User.doubleToString(user.twohundredm)
            slider.value = Float(user.twohundredm)
        case "400M":
//            label.text = initVal!
//            slider.value = Float(user.fourhundredm)
            initVal = User.doubleToString(user.fourhundredm)
            label.text = User.doubleToString(user.fourhundredm)
            slider.value = Float(user.fourhundredm)
        case "800M":
//            label.text = initVal!
//            slider.value = Float(user.eighthundredm)
            initVal = User.doubleToString(user.eighthundredm)
            label.text = User.doubleToString(user.eighthundredm)
            slider.value = Float(user.eighthundredm)
        case "1600M":
//            label.text = initVal!
//            slider.value = Float(user.mile)
            initVal = User.secsToString(user.mile)
            label.text = User.secsToString(user.mile)
            slider.value = Float(user.mile)
        case "Shotput":
//            label.text = initVal!
//            slider.value = Float(user.shotput)
            initVal = User.ftToString(user.shotput)
            label.text = User.ftToString(user.shotput)
            slider.value = Float(user.shotput)
        case "Discus":
//            label.text = initVal!
//            slider.value = Float(user.discus)
            initVal = User.ftToString(user.discus)
            label.text = User.ftToString(user.discus)
            slider.value = Float(user.discus)
        case "Long Jump":
//            label.text = initVal!
//            slider.value = Float(user.longJump)
            initVal = User.ftToString(user.longJump)
            label.text = User.ftToString(user.longJump)
            slider.value = Float(user.longJump)
        case "High Jump":
//            label.text = initVal!
//            slider.value = Float(user.highJump)
            initVal = User.ftToString(user.highJump)
            label.text = User.ftToString(user.highJump)
            slider.value = Float(user.highJump)
        case "Triple Jump":
//            label.text = initVal!
//            slider.value = Float(user.tripleJump)
            initVal = User.ftToString(user.tripleJump)
            label.text = User.ftToString(user.tripleJump)
            slider.value = Float(user.tripleJump)
        case "110M Hurdles":
//            label.text = initVal!
//            slider.value = Float(user.onetenHurdles)
            initVal = User.doubleToString(user.onetenHurdles)
            label.text = User.doubleToString(user.onetenHurdles)
            slider.value = Float(user.onetenHurdles)
        case "300M Hurdles":
//            label.text = initVal!
//            slider.value = Float(user.threehundredHurdles)
            initVal = User.doubleToString(user.threehundredHurdles)
            label.text = User.doubleToString(user.threehundredHurdles)
            slider.value = Float(user.threehundredHurdles)
        case "Pole Vault":
//            label.text = initVal!
//            slider.value = Float(user.poleVault)
            initVal = User.ftToString(user.poleVault)
            label.text = User.ftToString(user.poleVault)
            slider.value = Float(user.poleVault)
        default:
            print("whoops")
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        if stat! == "3200M" || stat! == "1600M" {
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
            label.text = stringMins + ":" + stringSecs
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.selectionChanged()
            return
        }
        if stat! == "SAT" || stat! == "ACT" {
            label.text = String(Int(slider.value))
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.selectionChanged()
            return
        }
        if ftEvents.contains(stat!) {
            label.text = User.ftToString(Double(slider.value))
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.selectionChanged()
            return
        }
        label.text = User.doubleToString(Double(slider.value).truncate(places: 2))
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
    }
    
    @IBAction func textFieldEditingEnd(_ sender: Any) {
        if label.text == "" || label.text == nil {
            label.text = initVal!
        }
        labelToSlider()
//        if stat! == "3200M" {
//            let mark = label.text!
//            let splitMark = (mark.split(separator: ":"))
//            let intMins = Int(splitMark[0])
//            let intSecs = Int(splitMark[1])
//            slider.value = Float(intMins! * 60 + intSecs!)
//            return
//        } else if doubleEvents.contains(valKeyDict[stat!]!) {
//            slider.value = Float(User.stringToDouble(label.text!))
//        } else if intEvents.contains(valKeyDict[stat!]!) {
//            slider.value = Float(User.stringToSecs(label.text!))
//        } else if ftEvents.contains(valKeyDict[stat!]!) {
//            slider.value = Float(User.stringToFt(label.text!))
//        }
//        let text: String = label.text!
//        let val = Float(text)
//        slider.value = val!
    }
    
    
    func labelToSlider() {
        if stat! == "3200M" {
            var mark = label.text!
            if mark == ":" || mark == "-" || mark == "." {
                mark = initVal!
                label.text = initVal!
            }
            let splitMark = (mark.split(separator: ":"))
            let intMins = Int(splitMark[0])
            let intSecs = Int(splitMark[1])
            slider.value = Float(intMins! * 60 + intSecs!)
            return
        } else if ftEvents.contains(stat!) {
            var mark = label.text!
            if mark == ":" || mark == "-" || mark == "." {
                mark = initVal!
                label.text = initVal!
            }
            slider.value = Float(User.stringToFt(mark))
        }  else if doubleEvents.contains(valKeyDict[stat!]!) {
            var mark = label.text!
            if mark == ":" || mark == "-" || mark == "." {
                mark = initVal!
                label.text = initVal
            }
            slider.value = Float(User.stringToDouble(mark))
        } else if intEvents.contains(valKeyDict[stat!]!) {
            var mark = label.text!
            if mark == ":" || mark == "-" || mark == "."  {
                mark = initVal!
                label.text = initVal
            }
            slider.value = Float(User.stringToSecs(mark))
        }
        return
    }
    
    @IBAction func dismiss(_ sender: Any) {
        if label.text == "" || label.text == nil {
            label.text = initVal!
        }
        
        if label.text == "0:00" || label.text == "0.0" || label.text == "0" {
            self.dismiss(animated: true)
            return
        }
        
        labelToSlider()
        if (initVal! == label.text!) && (fromAdd == false) {
            self.dismiss(animated: true)
            return
        }
        
        if doubleEvents.contains(key) {
            let roundedVal = (Double(slider.value) * 100).rounded() / 100
            user.saveDoubleEvent(key, roundedVal)
            if fromAdd {
                addToStatArr(stat!)
            }
        } else if intEvents.contains(key) {
            user.saveIntEvent(key, Int(slider.value))
            if fromAdd {
                addToStatArr(stat!)
            }
        }
        user.populateUserAtLaunch()
        NotificationCenter.default.post(name: Notification.Name("Reload Requested"), object: nil, userInfo: nil)
        
        
        
        self.dismiss(animated: true)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        let statusAlert = StatusAlert()
        statusAlert.title = stat! + " Updated"
        statusAlert.image = UIImage(named: "checkmark")
        statusAlert.appearance.blurStyle = .dark
        statusAlert.showInKeyWindow()
        
    }
    
    func addToStatArr(_ topic: String) {
        if fromAdd {
            if !user.statArr.contains(topic) {
                user.statArr.append(topic)
                user.saveCurrStats(user.statArr)
            }
            if !user.currEvents.contains(topic) && topic != "SAT" && topic != "ACT" && topic != "GPA" {
                user.currEvents.append(topic)
                user.saveCurrEvents(user.currEvents)
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
    
    @IBAction func clearField(_ sender: Any) {
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
                        textField.text = initVal!
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
                    textField.text = initVal!
                }
            }
        }
    }
    
    @IBAction func labelChanged(_ sender: Any) {
        switch stat! {
        case "GPA":
            checkMaxLength(textField: label, maxLength: 4)
            checkAllowedChars(textField: label, allowedChars: gpaChars)
        case "SAT":
            checkMaxLength(textField: label, maxLength: 4)
            checkAllowedChars(textField: label, allowedChars: testScoreChars)
        case "ACT":
            checkMaxLength(textField: label, maxLength: 2)
            checkAllowedChars(textField: label, allowedChars: testScoreChars)
        case "3200M":
            checkMaxLength(textField: label, maxLength: 5)
            checkAllowedChars(textField: label, allowedChars: intEventChars)
            checkLongTrackFormat(textField: label)
        case "1600M":
            checkMaxLength(textField: label, maxLength: 5)
            checkAllowedChars(textField: label, allowedChars: intEventChars)
            checkLongTrackFormat(textField: label)
        case "100M":
            checkMaxLength(textField: label, maxLength: 5)
            checkAllowedChars(textField: label, allowedChars: doubleEventChars)
            checkShortTrackFormat(textField: label)
        case "200M":
            checkMaxLength(textField: label, maxLength: 5)
            checkAllowedChars(textField: label, allowedChars: doubleEventChars)
            checkShortTrackFormat(textField: label)
        case "400M":
            checkMaxLength(textField: label, maxLength: 6)
            checkAllowedChars(textField: label, allowedChars: doubleEventChars)
            checkLongTrackFormat(textField: label)
        case "800M":
            checkMaxLength(textField: label, maxLength: 7)
            checkAllowedChars(textField: label, allowedChars: doubleEventChars)
            checkLongTrackFormat(textField: label)
        case "110M Hurdles":
            checkMaxLength(textField: label, maxLength: 5)
            checkAllowedChars(textField: label, allowedChars: doubleEventChars)
            checkShortTrackFormat(textField: label)
        case "300M Hurdles":
            checkMaxLength(textField: label, maxLength: 6)
            checkAllowedChars(textField: label, allowedChars: doubleEventChars)
            checkLongTrackFormat(textField: label)
        case "Shotput":
            checkMaxLength(textField: label, maxLength: 8)
            checkAllowedChars(textField: label, allowedChars: fieldEventChars)
            checkFieldFormat(textField: label)
        case "Discus":
            checkMaxLength(textField: label, maxLength: 9)
            checkAllowedChars(textField: label, allowedChars: fieldEventChars)
            checkFieldFormat(textField: label)
        case "High Jump":
            checkMaxLength(textField: label, maxLength: 7)
            checkAllowedChars(textField: label, allowedChars: fieldEventChars)
            checkFieldFormat(textField: label)
        case "Long Jump":
            checkMaxLength(textField: label, maxLength: 8)
            checkAllowedChars(textField: label, allowedChars: fieldEventChars)
            checkFieldFormat(textField: label)
        case "Triple Jump":
            checkMaxLength(textField: label, maxLength: 8)
            checkAllowedChars(textField: label, allowedChars: fieldEventChars)
            checkFieldFormat(textField: label)
        case "Pole Vault":
            checkMaxLength(textField: label, maxLength: 8)
            checkAllowedChars(textField: label, allowedChars: fieldEventChars)
            checkFieldFormat(textField: label)
        default:
            checkMaxLength(textField: label, maxLength: 9)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
