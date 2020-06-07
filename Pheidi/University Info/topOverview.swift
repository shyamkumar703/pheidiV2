//
//  topOverview.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/19/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import LinearProgressView
import MKRingProgressView

class topOverview: UIView {
    @IBOutlet weak var progressView: LinearProgressView!
    @IBOutlet weak var circleProgressView: RingProgressView!
    @IBOutlet weak var matchPercentage: UILabel!
    @IBOutlet weak var topEvent: UILabel!
    @IBOutlet weak var topEventTime: UILabel!
    
    @IBOutlet weak var accepRate: UILabel!
    @IBOutlet weak var sat: UILabel!
    @IBOutlet weak var act: UILabel!
    @IBOutlet weak var gpa: UILabel!
    
    
    
    
    
    let alphaColor = pheidiColors.pheidiTeal.withAlphaComponent(0.15)
    
    func initView() {
        progressView.barColor = alphaColor
        progressView.trackColor = pheidiColors.pheidiTeal
    }
    
    func animateProgress(_ matchString: String) {
        if matchString != "N/A" {
            circleProgressView.progress = 0
            let prog = Double(matchString)! / 100
            UIView.animate(withDuration: 1.0) {
                self.circleProgressView.progress = prog
            }
        }
        
    }
    
    func setLabels(_ bestEvent: String, _ uniMark: Double) {
        if bestEvent == "" {
            topEvent.text = "N/A"
            topEventTime.text = "No Data"
            return
        }
        if ftEvents.contains(bestEvent) {
            let uniString = User.ftToString(uniMark * 12)
            topEvent.text = bestEvent
            topEventTime.text = uniString
        } else if doubleEvents.contains(valKeyDict[bestEvent] ?? "") {
            let uniString = User.doubleToString(uniMark)
            topEvent.text = bestEvent
            topEventTime.text = uniString
        } else {
            let uniString = User.secsToString(Int(uniMark))
            topEvent.text = bestEvent
            topEventTime.text = uniString
        }

    }
    
    func animateEventView(_ bestEvent: String, _ uniMark: Double, _ userMark: Double) {
        if bestEvent == "" {
            progressView.setProgress(Float(0), animated: true)
            return
        }
        if ftEvents.contains(bestEvent) {
            let prog = userMark / (uniMark * 12)
            progressView.setProgress(Float(prog), animated: true)
        } else {
            let prog = uniMark / userMark
            progressView.setProgress(Float(prog), animated: true)
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
