//
//  settingsCard.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/21/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class settingsCard: UIView {
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var mark: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    
    func initView(_ group: String) {
        minusButton.isHidden = true
        let alphaColor = UIColor(red:0.00, green:0.08, blue:0.06, alpha:1.0)
        topic.textColor = UIColor.black
        pheidiColors.addHorizontalGradientColorToView(view: self, color: pheidiColors.pheidiTeal)
        
        let font1 = UIFont(name: "ProximaNovaA-Bold", size: 30.0)
        let font2 = UIFont(name: "ProximaNovaA-Bold", size: 24.0)
        
        switch group {
        case "GPA":
            let gpaString = String(user.gpa)
            let attributedText1 = NSMutableAttributedString(string: gpaString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            let attributedText2 = NSMutableAttributedString(string: "/4.0", attributes: [.font: font2!, .foregroundColor: pheidiColors.pheidiGray])
            
            attributedText1.append(attributedText2)
            mark.attributedText = attributedText1
        case "SAT":
            let satString = String(user.sat)
            let attributedText1 = NSMutableAttributedString(string: satString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            let attributedText2 = NSMutableAttributedString(string: "/1600", attributes: [.font: font2!, .foregroundColor: pheidiColors.pheidiGray])
            
            attributedText1.append(attributedText2)
            mark.attributedText = attributedText1
        case "ACT":
            let actString = String(user.act)
            let attributedText1 = NSMutableAttributedString(string: actString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            let attributedText2 = NSMutableAttributedString(string: "/36", attributes: [.font: font2!, .foregroundColor: pheidiColors.pheidiGray])
            
            attributedText1.append(attributedText2)
            mark.attributedText = attributedText1
        case "3200M":
            let timeString = User.secsToString(user.twoMile)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "100M":
            let timeString = User.doubleToString(user.onehundredm)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "200M":
            let timeString = User.doubleToString(user.twohundredm)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "400M":
            let timeString = User.doubleToString(user.fourhundredm)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "800M":
            let timeString = User.doubleToString(user.eighthundredm)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "1600M":
            let timeString = User.secsToString(user.mile)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "Shotput":
            let timeString = User.ftToString(user.shotput)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "Discus":
            let timeString = User.ftToString(user.discus)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "Long Jump":
            let timeString = User.ftToString(user.longJump)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "High Jump":
            let timeString = User.ftToString(user.highJump)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "Triple Jump":
            let timeString = User.ftToString(user.tripleJump)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "110M Hurdles":
            let timeString = User.doubleToString(user.onetenHurdles)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "300M Hurdles":
            let timeString = User.doubleToString(user.threehundredHurdles)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
        case "Pole Vault":
            let timeString = User.ftToString(user.poleVault)
            let attributedText1 = NSMutableAttributedString(string: timeString, attributes: [.font: font1!, .foregroundColor: UIColor.white])
            mark.attributedText = attributedText1
            
        default:
            print("whoops")
        }
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 18
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
