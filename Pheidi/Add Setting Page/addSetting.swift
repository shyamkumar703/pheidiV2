//
//  addSetting.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/22/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class addSetting: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func initView(_ topic: String) {
        titleLabel.text = topic
        titleLabel.textColor = UIColor.black
        pheidiColors.addHorizontalGradientColorToView(view: self, color: pheidiColors.pheidiTeal)
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
