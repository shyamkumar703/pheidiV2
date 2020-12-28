//
//  smallCellView.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/19/20.
//

import UIKit

class smallCellView: UIView {
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var division: UILabel!
    @IBOutlet weak var school: UILabel!
    
    func setup(_ uni: University) {
        school.adjustsFontSizeToFitWidth = true
        school.text = uni.name
        
        matchLabel.layer.cornerRadius = 5
        matchLabel.layer.masksToBounds = true
        
        switch uni.division {
        case "Division 2":
            division.textColor = Colors.yellow
        case "Division 3":
            division.textColor = Colors.red
        case "NAIA":
            division.textColor = Colors.blue
        default:
            division.textColor = Colors.green
        }
        
        if uni.division == "" {
            division.text = "-"
        } else {
            division.text = uni.division
        }
        
        var markColor: UIColor? = nil
        
        let matchScore = Int(uni.match)
        
        if matchScore! < 50 {
            markColor = Colors.red
            matchLabel.backgroundColor = Colors.redOpaq
            matchLabel.textColor = Colors.red
            markLabel.textColor = Colors.red
        } else if matchScore! > 75 {
            markColor = Colors.green
            matchLabel.backgroundColor = Colors.greenOpaq
            matchLabel.textColor = Colors.green
            markLabel.textColor = Colors.green
        } else {
            markColor = Colors.yellow
            matchLabel.backgroundColor = Colors.yellowOpaq
            matchLabel.textColor = Colors.yellow
            markLabel.textColor = Colors.yellow
        }
        
        matchLabel.text = uni.match + "%"
        
        
        let font1 = UIFont(name: "Proxima Nova Regular", size: 15)
        let font2 = UIFont(name: "Proxima Nova Bold", size: 35)
        
        let bestEventObject = fullEventDict[uni.bestEvent]
        let bestEvent = fullEventDict[uni.bestEvent]?.questionName ?? ""
        let markString = bestEventObject?.createMarkString(uni.uniMarkBestEvent) ?? "-"
        
        
        let attrs1 = [NSAttributedString.Key.font : font1, NSAttributedString.Key.foregroundColor : markColor]
        
        let attrs2 = [NSAttributedString.Key.font : font2, NSAttributedString.Key.foregroundColor : markColor]

        let attributedString1 = NSMutableAttributedString(string:markString, attributes:attrs2 as [NSAttributedString.Key : Any])

        let attributedString2 = NSMutableAttributedString(string:" " + bestEvent, attributes:attrs1 as [NSAttributedString.Key : Any])

        attributedString1.append(attributedString2)
        markLabel.attributedText = attributedString1
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

public struct Colors {
    static let greenOpaq = UIColor(red:0.33, green:0.84, blue:0.41, alpha:0.2)
    static let green = UIColor(red:0.33, green:0.84, blue:0.41, alpha:1.0)
    
    static let redOpaq = UIColor(red:0.99, green:0.24, blue:0.22, alpha:0.2)
    static let red = UIColor(red:0.99, green:0.24, blue:0.22, alpha:1.0)
    
    static let yellowOpaq = UIColor(red:1.00, green:0.80, blue:0.18, alpha:0.2)
    static let yellow = UIColor(red:1.00, green:0.80, blue:0.18, alpha:1.0)
    
    static let blue = UIColor(red:0.37, green:0.79, blue:0.97, alpha:1.0)
    static let blueOpaq = UIColor(red:0.37, green:0.79, blue:0.97, alpha:0.3)
    static let blueSlightlyOpaq = UIColor(red:0.37, green:0.79, blue:0.97, alpha:0.7)
    static let blueVeryOpaq = UIColor(red:0.37, green:0.79, blue:0.97, alpha:0.15)
    
    static let grayOpaq = UIColor(red:0.20, green:0.20, blue:0.20, alpha:0.7)
    static let gray = UIColor(red:0.20, green:0.20, blue:0.20, alpha:0.7)
    
    static let lightGrayOpaq = UIColor(red:0.50, green:0.50, blue:0.50, alpha:0.5)
    
    static let lightGray = UIColor(red:0.50, green:0.50, blue:0.50, alpha:1.0)
}
