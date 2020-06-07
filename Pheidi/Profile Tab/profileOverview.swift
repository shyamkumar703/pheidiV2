//
//  profileOverview.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/14/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import MKRingProgressView

class profileOverview: UIView {
    @IBOutlet weak var progressRing: RingProgressView!
    @IBOutlet weak var gpaLabel: UILabel!
    @IBOutlet weak var bestEventMark: UILabel!
    @IBOutlet weak var bestEventLabel: UILabel!
    @IBOutlet weak var divisionLabel: UILabel!
    
    func animateProgress(_ prog: Double, _ gpa: String) {
        if user.statArr.contains("GPA") {
            gpaLabel.text = gpa
            progressRing.progress = 0
            UIView.animate(withDuration: 1.0) {
                self.progressRing.progress = prog
            }
        } else {
            gpaLabel.text = "N/A"
            progressRing.progress = 0
        }
    }
    
    func initView() {
        divisionLabel.text = user.division
        if user.bestEventMark == 0 {
            bestEventLabel.isHidden = true
            bestEventMark.isHidden = true
        }
        bestEventLabel.text = user.bestEventString
        if ftEvents.contains(user.bestEventString) {
            let uniString = User.ftToString(user.bestEventMark)
            bestEventMark.text = uniString
        } else if doubleEvents.contains(valKeyDict[user.bestEventString] ?? "") {
            let uniString = User.doubleToString(user.bestEventMark)
            bestEventMark.text = uniString
        } else {
            let uniString = User.secsToString(Int(user.bestEventMark))
            bestEventMark.text = uniString
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
