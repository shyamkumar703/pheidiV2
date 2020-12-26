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
    
    func setup() {
        progressBackView.layer.cornerRadius = 5
        progressFrontView.layer.cornerRadius = 5
        
        let font1 = UIFont(name: "Proxima Nova Regular", size: 15)
        let font2 = UIFont(name: "Proxima Nova Bold", size: 50)
        
        
        let attrs1 = [NSAttributedString.Key.font : font1, NSAttributedString.Key.foregroundColor : UIColor.green]
        
        let attrs2 = [NSAttributedString.Key.font : font2, NSAttributedString.Key.foregroundColor : UIColor.green]

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
