//
//  profileAcademic.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/15/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import MKRingProgressView
import LinearProgressView

class profileAcademic: UIView {
    @IBOutlet weak var gpa: UILabel!
    @IBOutlet weak var actProgress: LinearProgressView!
    @IBOutlet weak var actLabel: UILabel!
    @IBOutlet weak var progressRing: RingProgressView!
    @IBOutlet weak var satProgress: LinearProgressView!
    @IBOutlet weak var satLabel: UILabel!
    let alphaColor = pheidiColors.pheidiTeal.withAlphaComponent(0.15)
    
    func setConstraints() {
        if UIScreen.main.bounds.width == 375 {
            let centerVertically = NSLayoutConstraint(item: progressRing!,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                toItem: self,
                attribute: .centerX,
            multiplier: 1.0,
              constant: -30)
            NSLayoutConstraint.activate([centerVertically])
        } else {
            let centerVertically = NSLayoutConstraint(item: progressRing!,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                toItem: self,
                attribute: .centerX,
            multiplier: 1.0,
              constant: 0)
            NSLayoutConstraint.activate([centerVertically])
        }
    }
    
    func initView(_ sat: String, _ act: String) {
        satProgress.barColor = alphaColor
        satProgress.trackColor = pheidiColors.pheidiTeal
        
        actProgress.barColor = alphaColor
        actProgress.trackColor = pheidiColors.pheidiTeal
        
        if user.statArr.contains("SAT") {
            satLabel.text = sat
        } else {
            satLabel.text = "N/A"
        }
        
        if user.statArr.contains("ACT") {
            actLabel.text = act
        } else {
            actLabel.text = "N/A"
        }
    }
    
    func animateSAT(_ score: Float) {
        if user.statArr.contains("SAT") {
            let progress = score / 1600.0
            satProgress.setProgress(progress, animated: true)
        } else {
            satProgress.setProgress(0.0, animated: false)
        }
    }
    
    func animateACT (_ score: Float) {
        if user.statArr.contains("ACT") {
            let progress = score / 36.0
            actProgress.setProgress(progress, animated: true)
        } else {
            actProgress.setProgress(0.0, animated: true)
        }
    }
    
    func animateProgress(_ prog: Double) {
        progressRing.progress = 0
        if user.statArr.contains("GPA") {
            UIView.animate(withDuration: 1.0) {
                self.progressRing.progress = prog
            }
        } else {
            gpa.text = "N/A"
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

extension String {
  var isBackspace: Bool {
    let char = self.cString(using: String.Encoding.utf8)!
    return strcmp(char, "\\b") == -92
  }
}
