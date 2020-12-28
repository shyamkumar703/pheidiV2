//
//  alertView.swift
//  Pheidi
//
//  Created by Shyam Kumar on 12/27/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class alertView: UIView {
    @IBOutlet weak var icon: UIButton!
    @IBOutlet weak var message: UILabel!
    
    func setup(_ positive: Bool) {
        self.frame.size.width = UIScreen.main.bounds.width - 40
        icon.backgroundColor = UIColor(red:0.39, green:0.39, blue:0.39, alpha:0.3)
        icon.layer.cornerRadius = 20
        self.layer.cornerRadius = 10
        message.adjustsFontSizeToFitWidth = true
        
        if !positive {
            icon.setImage(UIImage(systemName: "xmark"), for: .normal)
            icon.tintColor = Colors.red
            message.text = "Removed from My List"
        } else {
            icon.setImage(UIImage(systemName: "checkmark"), for: .normal)
            icon.tintColor = Colors.green
            message.text = "Added to My List"
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
