//
//  uniCellView.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/14/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class uniCellView: UICollectionViewCell {
    @IBOutlet weak var focusImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var focusString: UILabel!
    @IBOutlet weak var sat: UILabel!
    @IBOutlet weak var act: UILabel!
    @IBOutlet weak var gpa: UILabel!
    @IBOutlet weak var match: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var focusLabel: UILabel!
    


    
    func cornerRad() {
        let alphaColor = UIColor(red:0.00, green:0.08, blue:0.06, alpha:1.0)
        let alphaColor2 = UIColor(red:0.84, green:0.60, blue:0.64, alpha:1.0)
        pheidiColors.addHorizontalGradientColorToView(view: backView, color: alphaColor)
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
