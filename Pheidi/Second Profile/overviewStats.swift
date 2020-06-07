//
//  overviewStats.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/18/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class overviewStats: UIView {
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var divisionLabel: UILabel!
    
    func initView() {
        editButton.layer.cornerRadius = 7
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = pheidiColors.pheidiTeal.cgColor
        divisionLabel.text = user.division
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
