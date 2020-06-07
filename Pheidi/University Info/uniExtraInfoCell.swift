//
//  uniExtraInfoCell.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/20/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class uniExtraInfoCell: UIView {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var ranking: UILabel!
    var currUni: University? = nil
    
    func initView(_ rank: String) {
        let currView = Bundle.main.loadNibNamed("View", owner: self, options: nil)?.first as? uniCellView
        currView!.cornerRad()
        if rank == "#1" {
            pheidiColors.addGradientToView(view: gradientView)
        }
        currView!.match.text = rank
        currView!.matchLabel?.text = "West Region"
//        ranking.text = rank
        cellView.addSubview(currView!)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
