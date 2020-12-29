//
//  topCellView.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/19/20.
//

import UIKit

class topCellView: UIView {
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var progressBackView: UIView!
    @IBOutlet weak var progressFrontView: UIView!
    @IBOutlet weak var progressWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var division: UILabel!
    @IBOutlet weak var name: UILabel!
    
    func setup(_ uni: University) {
        name.adjustsFontSizeToFitWidth = true
        name.text = uni.name
        
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
        
        if matchScore ?? 0 < 50 {
            markColor = Colors.red
            progressBackView.backgroundColor = Colors.redOpaq
            progressFrontView.backgroundColor = Colors.red
        } else if matchScore! > 75 {
            markColor = Colors.green
            progressBackView.backgroundColor = Colors.greenOpaq
            progressFrontView.backgroundColor = Colors.green
        } else {
            markColor = Colors.yellow
            progressBackView.backgroundColor = Colors.yellowOpaq
            progressFrontView.backgroundColor = Colors.yellow
        }
        
        progressBackView.layer.cornerRadius = 5
        progressFrontView.layer.cornerRadius = 5
        
        let font1 = UIFont(name: "Proxima Nova Regular", size: 15)
        let font2 = UIFont(name: "Proxima Nova Bold", size: 50)
        
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
