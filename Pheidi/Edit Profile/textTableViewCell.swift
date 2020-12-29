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
            value.text = String(user.name.split(separator: " ")[0])
        case "Last Name":
            value.text = String(user.name.split(separator: " ")[1])
        case "GPA":
            value.text = String(user.gpa)
        case "SAT":
            if user.sat == 0 {
                value.text = "-"
            } else {
                value.text = String(user.sat)
            }
        case "ACT":
            if user.act == 0 {
                value.text = "-"
            } else {
                value.text = String(user.act)
            }
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
        case "110M Hurdles":
            if user.onetenHurdles == 0 {
                value.text = "-"
            } else {
                value.text = User.doubleToString(user.onetenHurdles)
            }
        case "300M Hurdles":
            if user.threehundredHurdles == 0 {
                value.text = "-"
            } else {
                value.text = User.doubleToString(user.threehundredHurdles)
            }
        default:
            print("whoops")
        }
    }
    
    @IBAction func fieldEditingEnded(_ sender: Any) {
        if value.text != "" && value.text != "-" {
            if !user.statArr.contains(title.text!) {
                user.statArr.append(title.text!)
            }
        } else {
            if user.statArr.contains(title.text!) {
                user.statArr = user.statArr.filter {event in
                    return event != title.text!
                }
            }
        }
        
        user.statArr.append(title.text!)
        print(user.statArr)
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
            } else {
                if user.statArr.contains("SAT") {
                    user.sat = 0
                    user.saveCurrStats(user.statArr.filter { event in event != "SAT"  })
                }
            }
        case "ACT":
            if value.text != "" && value.text != "-"{
                user.act = Int(value.text!) ?? 0
            } else {
                user.act = 0
                if user.statArr.contains("ACT") {
                    user.saveCurrStats(user.statArr.filter { event in event != "ACT"  })
                }
            }
        case "100M":
            if value.text != "" && value.text != "-"{
                user.onehundredm = User.stringToDouble(value.text!)
            } else {
                user.onehundredm = 0
                user.saveDoubleEvent(valKeyDict["100M"]!, 0)
                if user.statArr.contains("100M") {
                    user.saveCurrStats(user.statArr.filter { event in event != "100M"  })
                }
            }
        case "200M":
            if value.text != "" && value.text != "-"{
                user.twohundredm = User.stringToDouble(value.text!)
            } else {
                user.twohundredm = 0
                user.saveDoubleEvent(valKeyDict["200M"]!, 0)
                if user.statArr.contains("200M") {
                    user.saveCurrStats(user.statArr.filter { event in event != "200M"  })
                }
            }
        case "400M":
            if value.text != "" && value.text != "-"{
                user.fourhundredm = User.stringToDouble(value.text!)
            } else {
                user.fourhundredm = 0
                user.saveDoubleEvent(valKeyDict["400M"]!, 0)
                if user.statArr.contains("400M") {
                    user.saveCurrStats(user.statArr.filter { event in event != "400M"  })
                }
            }
        case "800M":
            if value.text != "" && value.text != "-"{
                user.eighthundredm = User.stringToDouble(value.text!)
            } else {
                user.eighthundredm = 0
                user.saveDoubleEvent(valKeyDict["800M"]!, 0)
                if user.statArr.contains("800M") {
                    user.saveCurrStats(user.statArr.filter { event in event != "800M"  })
                }
            }
        case "1600M":
            if value.text != "" && value.text != "-"{
                user.mile = User.stringToSecs(value.text!)
            } else {
                user.mile = 0
                user.saveIntEvent(valKeyDict["1600M"]!, 0)
                if user.statArr.contains("1600M") {
                    user.saveCurrStats(user.statArr.filter { event in event != "1600M"  })
                }
            }
        case "3200M":
            if value.text != "" && value.text != "-"{
                user.twoMile = User.stringToSecs(value.text!)
            } else {
                user.twoMile = 0
                user.saveIntEvent(valKeyDict["3200M"]!, 0)
                if user.statArr.contains("3200M") {
                    user.saveCurrStats(user.statArr.filter { event in event != "3200M"  })
                }
            }
        case "Shotput":
            if value.text != "" && value.text != "-"{
                user.shotput = User.stringToFt(value.text!)
            } else {
                user.shotput = 0
                user.saveDoubleEvent(valKeyDict["Shotput"]!, 0)
                if user.statArr.contains("Shotput") {
                    user.saveCurrStats(user.statArr.filter { event in event != "Shotput"  })
                }
            }
        case "Discus":
            if value.text != "" && value.text != "-"{
                user.discus = User.stringToFt(value.text!)
            } else {
                user.discus = 0
                user.saveDoubleEvent(valKeyDict["Discus"]!, 0)
                if user.statArr.contains("Discus") {
                    user.saveCurrStats(user.statArr.filter { event in event != "Discus"  })
                }
            }
        case "High Jump":
            if value.text != "" && value.text != "-"{
                user.highJump = User.stringToFt(value.text!)
            } else {
                user.highJump = 0
                user.saveDoubleEvent(valKeyDict["High Jump"]!, 0)
                if user.statArr.contains("High Jump") {
                    user.saveCurrStats(user.statArr.filter { event in event != "High Jump"  })
                }
            }
        case "Long Jump":
            if value.text != "" && value.text != "-"{
                user.longJump = User.stringToFt(value.text!)
            } else {
                user.longJump = 0
                user.saveDoubleEvent(valKeyDict["Long Jump"]!, 0)
                if user.statArr.contains("Long Jump") {
                    user.saveCurrStats(user.statArr.filter { event in event != "Long Jump"  })
                }
            }
        case "Triple Jump":
            if value.text != "" && value.text != "-"{
                user.tripleJump = User.stringToFt(value.text!)
            } else {
                user.tripleJump = 0
                user.saveDoubleEvent(valKeyDict["Triple Jump"]!, 0)
                if user.statArr.contains("Triple Jump") {
                    user.saveCurrStats(user.statArr.filter { event in event != "Triple Jump"  })
                }
            }
        case "Pole Vault":
            if value.text != "" && value.text != "-"{
                user.poleVault = User.stringToFt(value.text!)
            } else {
                user.poleVault = 0
                user.saveDoubleEvent(valKeyDict["Pole Vault"]!, 0)
                if user.statArr.contains("Pole Vault") {
                    user.saveCurrStats(user.statArr.filter { event in event != "Pole Vault"  })
                }
            }
        case "110M Hurdles":
            if value.text != "" && value.text != "-"{
                user.onetenHurdles = User.stringToDouble(value.text!)
            } else {
                user.onetenHurdles = 0
                user.saveDoubleEvent(valKeyDict["110M Hurdles"]!, 0)
                if user.statArr.contains("110M Hurdles") {
                    user.saveCurrStats(user.statArr.filter { event in event != "110M Hurdles"  })
                }
            }
        case "300M Hurdles":
            if value.text != "" && value.text != "-"{
                user.threehundredHurdles = User.stringToDouble(value.text!)
            } else {
                user.threehundredHurdles = 0
                user.saveDoubleEvent(valKeyDict["300M Hurdles"]!, 0)
                if user.statArr.contains("300M Hurdles") {
                    user.saveCurrStats(user.statArr.filter { event in event != "300M Hurdles"  })
                }
            }
        default:
            print("whoops")
        }
        user.saveCurrStats(user.statArr)
        let athleteEvents = user.statArr.filter {event in
            event != "GPA" && event != "SAT" && event != "ACT"
        }
        user.saveCurrEvents(athleteEvents)
        
        user.saveUser()
        user.populateUserAtLaunch()
        switch(user.gender) {
        case "Male":
            University.loadMatchesMale()
        case "Female":
            University.loadMatchesFemale()
        default:
            return
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
