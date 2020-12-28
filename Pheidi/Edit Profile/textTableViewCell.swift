//
//  textTableViewCell.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/23/20.
//

import UIKit

class textTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var value: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup() {
        switch title.text {
        case "First Name":
            value.text = "Shyam"
        case "Last Name":
            value.text = "Kumar"
        case "GPA":
            value.text = String(user.gpa)
        case "SAT":
            value.text = String(user.sat)
        case "ACT":
            value.text = String(user.act)
        case "100M":
            if user.onehundredm == 0 {
                value.text = "-"
            } else {
                value.text = User.doubleToString(user.onehundredm)
            }
        case "200M":
            if user.twohundredm == 0 {
                value.text = "-"
            } else {
                value.text = User.doubleToString(user.twohundredm)
            }
        case "400M":
            if user.fourhundredm == 0 {
                value.text = "-"
            } else {
                value.text = User.doubleToString(user.fourhundredm)
            }
        case "800M":
            if user.eighthundredm == 0 {
                value.text = "-"
            } else {
                value.text = User.doubleToString(user.eighthundredm)
            }
        case "1600M":
            if user.mile == 0 {
                value.text = "-"
            } else {
                value.text = User.secsToString(user.mile)
            }
        case "3200M":
            if user.twoMile == 0 {
                value.text = "-"
            } else {
                value.text = User.secsToString(user.twoMile)
            }
        case "Shotput":
            if user.shotput == 0 {
                value.text = "-"
            } else {
                value.text = User.ftToString(user.shotput)
            }
        case "Discus":
            if user.discus == 0 {
                value.text = "-"
            } else {
                value.text = User.ftToString(user.discus)
            }
        case "High Jump":
            if user.highJump == 0 {
                value.text = "-"
            } else {
                value.text = User.ftToString(user.highJump)
            }
        case "Long Jump":
            if user.longJump == 0 {
                value.text = "-"
            } else {
                value.text = User.ftToString(user.longJump)
            }
        case "Triple Jump":
            if user.tripleJump == 0 {
                value.text = "-"
            } else {
                value.text = User.ftToString(user.tripleJump)
            }
        case "Pole Vault":
            if user.poleVault == 0 {
                value.text = "-"
            } else {
                value.text = User.ftToString(user.poleVault)
            }
        default:
            print("whoops")
        }
    }
    
    @IBAction func fieldEditingEnded(_ sender: Any) {
        if value.text != "" && value.text != "-" {
            if !user.currEvents.contains(title.text!) {
                user.currEvents.append(title.text!)
            }
        } else {
            if user.currEvents.contains(title.text!) {
                user.currEvents = user.currEvents.filter {event in
                    return event != title.text!
                }
            }
        }
        switch title.text {
        case "First Name":
            value.text = "Shyam"
        case "Last Name":
            value.text = "Kumar"
        case "GPA":
            if value.text != "" && value.text != "-"{
                user.gpa = User.stringToDouble(value.text!)
            }
        case "SAT":
            if value.text != "" && value.text != "-"{
                user.sat = Int(value.text!) ?? 0
            }
        case "ACT":
            if value.text != "" && value.text != "-"{
                user.act = Int(value.text!) ?? 0
            }
        case "100M":
            if value.text != "" && value.text != "-"{
                user.onehundredm = User.stringToDouble(value.text!)
            }
        case "200M":
            if value.text != "" && value.text != "-"{
                user.twohundredm = User.stringToDouble(value.text!)
            }
        case "400M":
            if value.text != "" && value.text != "-"{
                user.fourhundredm = User.stringToDouble(value.text!)
            }
        case "800M":
            if value.text != "" && value.text != "-"{
                user.eighthundredm = User.stringToDouble(value.text!)
            }
        case "1600M":
            if value.text != "" && value.text != "-"{
                user.mile = User.stringToSecs(value.text!)
            }
        case "3200M":
            if value.text != "" && value.text != "-"{
                user.twoMile = User.stringToSecs(value.text!)
            }
        case "Shotput":
            if value.text != "" && value.text != "-"{
                user.shotput = User.stringToFt(value.text!)
            }
        case "Discus":
            if value.text != "" && value.text != "-"{
                user.discus = User.stringToFt(value.text!)
            }
        case "High Jump":
            if value.text != "" && value.text != "-"{
                user.highJump = User.stringToFt(value.text!)
            }
        case "Long Jump":
            if value.text != "" && value.text != "-"{
                user.longJump = User.stringToFt(value.text!)
            }
        case "Triple Jump":
            if value.text != "" && value.text != "-"{
                user.tripleJump = User.stringToFt(value.text!)
            }
        case "Pole Vault":
            if value.text != "" && value.text != "-"{
                user.poleVault = User.stringToFt(value.text!)
            }
        default:
            print("whoops")
        }
        user.saveUser()
        user.populateUserAtLaunch()
        University.loadMatchesMale()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
