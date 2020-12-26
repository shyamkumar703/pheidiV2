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
    
    func setup() {
        matchLabel.layer.cornerRadius = 5
        matchLabel.layer.masksToBounds = true
        
        let randomInt = Int.random(in: 0..<3)
        
        switch randomInt {
        case 0:
            matchLabel.backgroundColor = Colors.greenOpaq
            matchLabel.textColor = Colors.green
            markLabel.textColor = Colors.green
        case 1:
            matchLabel.backgroundColor = Colors.yellowOpaq
            matchLabel.textColor = Colors.yellow
            markLabel.textColor = Colors.yellow
        default:
            matchLabel.backgroundColor = Colors.redOpaq
            matchLabel.textColor = Colors.red
            markLabel.textColor = Colors.red
        }
        
        
        let font1 = UIFont(name: "Proxima Nova Regular", size: 15)
        let font2 = UIFont(name: "Proxima Nova Bold", size: 35)
        
        
        let attrs1 = [NSAttributedString.Key.font : font1]
        
        let attrs2 = [NSAttributedString.Key.font : font2]

        let attributedString1 = NSMutableAttributedString(string:"9:06", attributes:attrs2 as [NSAttributedString.Key : Any])

        let attributedString2 = NSMutableAttributedString(string:" 3200M", attributes:attrs1 as [NSAttributedString.Key : Any])

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
}
