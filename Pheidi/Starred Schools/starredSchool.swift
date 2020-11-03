//
//  starredSchool.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/21/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import LinearProgressView

class starredSchool: UIView {
    @IBOutlet weak var academicProgressView: LinearProgressView!
    @IBOutlet weak var athleticLinearProgressView: LinearProgressView!
    
    @IBOutlet weak var gpaProgressLabel: UILabel!
    @IBOutlet weak var gpaSubtractLabel: UILabel!
    
    @IBOutlet weak var markProgressLabel: UILabel!
    @IBOutlet weak var markSubtractLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var schoolOverview: UIButton!
    @IBOutlet weak var matchStatusLabel: UILabel!
    @IBOutlet weak var paragraphExplanation: UILabel!
    
    let alphaColor2 = pheidiColors.pheidiTeal.withAlphaComponent(0.15)
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func initView(_ buttonTag: Int, _ uni: University) {
        schoolOverview.layer.borderColor = pheidiColors.pheidiTeal.cgColor
        schoolOverview.layer.borderWidth = 1.0
        schoolOverview.layer.cornerRadius = 6
        
        name.text = uni.name
        starButton.tag = buttonTag
        schoolOverview.tag = buttonTag
        
        self.layer.cornerRadius = 18
        self.layer.masksToBounds = true
        //let alphaColor = UIColor(red:0.00, green:0.15, blue:0.12, alpha:1.0)//00271f
        let alphaColor = UIColor(red:0.00, green:0.08, blue:0.06, alpha:1.0)
        //testView.backgroundColor = pheidiColors.pheidiTeal.withAlphaComponent(0.15)
        
        
        pheidiColors.addHorizontalGradientColorToView(view: self, color: alphaColor)
        
        academicProgressView.barColor = alphaColor2
        academicProgressView.trackColor = pheidiColors.pheidiTeal
        
        athleticLinearProgressView.barColor = alphaColor2
        athleticLinearProgressView.trackColor = pheidiColors.pheidiTeal
        
        
        //MARK: GPA
        let font1 = UIFont(name: "ProximaNovaA-Bold", size: 16.0)
        
        let font2 = UIFont(name: "ProximaNovaA-Bold", size: 14.0)
        let hasGPA: Bool = uni.gpaVal != 0
        
        if hasGPA {
            let prog = Float((user.gpa / uni.gpaVal) * 100)
            academicProgressView.setProgress(prog, animated: false)
            let attributedText = NSMutableAttributedString(string: String(user.gpa), attributes: [NSAttributedString.Key.font: font1!])
            let attributedText2 = NSMutableAttributedString(string: "/" + uni.gpa, attributes: [.font: font2!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
            attributedText.append(attributedText2)
            gpaProgressLabel.attributedText = attributedText
            if user.gpa > uni.gpaVal {
                let attributedText3 = NSMutableAttributedString(string: "PERFECT", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                gpaSubtractLabel.attributedText = attributedText3
            } else {
                let attributedText3 = NSMutableAttributedString(string: "\((uni.gpaVal - user.gpa).truncate(places: 2)) points", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                
                let attributedText4 = NSMutableAttributedString(string: " to go", attributes: [NSAttributedString.Key.font: font1!])
                
                attributedText3.append(attributedText4)
                gpaSubtractLabel.attributedText = attributedText3
            }
            if uni.bestEvent == "" {
                athleticLinearProgressView.setProgress(0, animated: false)
                let attributedText7 = NSMutableAttributedString(string: "N/A", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                markSubtractLabel.attributedText = attributedText7
                let explanation = "You need a \(uni.gpa) GPA to be a perfect candidate for \(uni.name)"
                paragraphExplanation.text = explanation
                arrowImage.image = UIImage(named: "question")
                matchStatusLabel.text = "N/A"
                markProgressLabel.text = ""
                return
            }
            
        } else {
            academicProgressView.setProgress(0, animated: false)
            let attributedText = NSMutableAttributedString(string: String(user.gpa), attributes: [NSAttributedString.Key.font: font1!])
            gpaProgressLabel.attributedText = attributedText
            let attributedText3 = NSMutableAttributedString(string: "GPA UNAVAILABLE", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
            gpaSubtractLabel.attributedText = attributedText3
            if uni.bestEvent == "" {
                athleticLinearProgressView.setProgress(0, animated: false)
                let attributedText7 = NSMutableAttributedString(string: "N/A", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                markSubtractLabel.attributedText = attributedText7
                let explanation = "GPA and event data is unavailable for \(uni.name)"
                paragraphExplanation.text = explanation
                arrowImage.image = UIImage(named: "question")
                matchStatusLabel.text = "N/A"
                markProgressLabel.text = ""
                return
            }
        }
        
        //MARK: BEST EVENT
        if ftEvents.contains(uni.bestEvent) {
            let userDouble = uni.userMarkBestEvent
            let uniDouble = uni.uniMarkBestEvent * 12
            let prog = Float((userDouble/uniDouble) * 100)
            athleticLinearProgressView.setProgress(prog, animated: false)
            
            let userMark = User.ftToString(Double(Int(uni.userMarkBestEvent))).dropLast().dropLast()
            let uniMark = User.ftToString(Double(Int(uni.uniMarkBestEvent * 12))).dropLast().dropLast()
            
            if uni.lowData {
                athleticLinearProgressView.setProgress(0, animated: false)
                let attributedText5 = NSMutableAttributedString(string: String(userMark), attributes: [NSAttributedString.Key.font: font1!])
                markProgressLabel.attributedText = attributedText5
                let attributedText7 = NSMutableAttributedString(string: "\(uni.bestEvent) UNAVAILABLE", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                markSubtractLabel.attributedText = attributedText7
                if hasGPA {
                    let explanation = "You need a \(uni.gpa) GPA to be a perfect candidate for \(uni.name)"
                    paragraphExplanation.text = explanation
                } else {
                    let explanation = "GPA and \(uni.bestEvent) data is unavailable for \(uni.name)"
                    paragraphExplanation.text = explanation
                }
                return
            }

            athleticLinearProgressView.setProgress(prog, animated: false)
            
            if hasGPA {
                let explanation = "You need a \(uni.gpa) GPA and a \(uniMark) \(uni.bestEvent.lowercased()) to be a perfect candidate for \(uni.name)"
                paragraphExplanation.text = explanation
            } else {
                let explanation = "You need a \(uniMark) \(uni.bestEvent.lowercased()) to be a perfect candidate for \(uni.name)"
                paragraphExplanation.text = explanation
            }
            
            let attributedText5 = NSMutableAttributedString(string: String(userMark), attributes: [NSAttributedString.Key.font: font1!])
            let attributedText6 = NSMutableAttributedString(string: "/" + String(uniMark), attributes: [.font: font2!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
            attributedText5.append(attributedText6)
            markProgressLabel.attributedText = attributedText5
            
            if userDouble > uniDouble {
                let attributedText7 = NSMutableAttributedString(string: "PERFECT", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                markSubtractLabel.attributedText = attributedText7
            } else {
                let inchesAway = uniDouble - userDouble
                if inchesAway < 12 {
                    let attributedText7 = NSMutableAttributedString(string: String(inchesAway.truncate(places: 2)) + " inches", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                    
                    let attributedText8 = NSMutableAttributedString(string: " to go", attributes: [NSAttributedString.Key.font: font1!])
                    attributedText7.append(attributedText8)
                    markSubtractLabel.attributedText = attributedText7
                } else {
                    let ftAway = Int(inchesAway) / 12
                    let inches = Int(inchesAway) - (ftAway * 12)
                    let attributedText7 = NSMutableAttributedString(string: String(ftAway) + " ft and " + String(inches) + " in", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                    
                    let attributedText8 = NSMutableAttributedString(string: " to go", attributes: [NSAttributedString.Key.font: font1!])
                    attributedText7.append(attributedText8)
                    markSubtractLabel.attributedText = attributedText7
                }
            }
        } else if doubleEvents.contains(valKeyDict[uni.bestEvent]!) {
            let userDouble = uni.userMarkBestEvent
            let uniDouble = uni.uniMarkBestEvent
            let prog = Float((uniDouble/userDouble) * 100)
            
            
            let userMark = User.doubleToString(uni.userMarkBestEvent.truncate(places: 1))
            let uniMark = User.doubleToString(uni.uniMarkBestEvent.truncate(places: 1))
            
            if uni.lowData {
                athleticLinearProgressView.setProgress(0, animated: false)
                let attributedText5 = NSMutableAttributedString(string: String(userMark), attributes: [NSAttributedString.Key.font: font1!])
                markProgressLabel.attributedText = attributedText5
                let attributedText7 = NSMutableAttributedString(string: "\(uni.bestEvent) UNAVAILABLE", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                markSubtractLabel.attributedText = attributedText7
                if hasGPA {
                    let explanation = "You need a \(uni.gpa) GPA to be a perfect candidate for \(uni.name)"
                    paragraphExplanation.text = explanation
                } else {
                    let explanation = "GPA and \(uni.bestEvent) data is unavailable for \(uni.name)"
                    paragraphExplanation.text = explanation
                }
                return
            }
            
            athleticLinearProgressView.setProgress(prog, animated: false)
            
            if hasGPA {
                let explanation = "You need a \(uni.gpa) GPA and a \(uniMark) \(uni.bestEvent.lowercased()) to be a perfect candidate for \(uni.name)"
                paragraphExplanation.text = explanation
            } else {
                let explanation = "You need a \(uniMark) \(uni.bestEvent.lowercased()) to be a perfect candidate for \(uni.name)"
                paragraphExplanation.text = explanation
            }
            
            let attributedText5 = NSMutableAttributedString(string: userMark, attributes: [NSAttributedString.Key.font: font1!])
            let attributedText6 = NSMutableAttributedString(string: "/" + uniMark, attributes: [.font: font2!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
            attributedText5.append(attributedText6)
            markProgressLabel.attributedText = attributedText5
            
            if userDouble < uniDouble {
                let attributedText7 = NSMutableAttributedString(string: "PERFECT", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                markSubtractLabel.attributedText = attributedText7
            } else {
                let secsAway = (userDouble - uniDouble).truncate(places: 2)
                if secsAway < 60 {
                    let attributedText7 = NSMutableAttributedString(string: String(secsAway) + " seconds", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                    
                    let attributedText8 = NSMutableAttributedString(string: " to go", attributes: [NSAttributedString.Key.font: font1!])
                    attributedText7.append(attributedText8)
                    markSubtractLabel.attributedText = attributedText7
                } else {
                    let minsAway = Int(secsAway) / 60
                    let secs = Int(secsAway) - Int(minsAway * 60)
                    let attributedText7 = NSMutableAttributedString(string: String(minsAway) + " mins and " + String(secs) + " secs", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                    
                    let attributedText8 = NSMutableAttributedString(string: " to go", attributes: [NSAttributedString.Key.font: font1!])
                    attributedText7.append(attributedText8)
                    markSubtractLabel.attributedText = attributedText7
                }
            }
        } else {
            let userInt = Int(uni.userMarkBestEvent)
            let uniInt = Int(uni.uniMarkBestEvent)
            let prog = Float((Double(uniInt)/Double(userInt)) * 100)
            
            let userMark = User.secsToString(userInt)
            let uniMark = User.secsToString(uniInt)
            
            if uni.lowData {
                athleticLinearProgressView.setProgress(0, animated: false)
                let attributedText5 = NSMutableAttributedString(string: String(userMark), attributes: [NSAttributedString.Key.font: font1!])
                markProgressLabel.attributedText = attributedText5
                let attributedText7 = NSMutableAttributedString(string: "\(uni.bestEvent) UNAVAILABLE", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                markSubtractLabel.attributedText = attributedText7
                if hasGPA {
                    let explanation = "You need a \(uni.gpa) GPA to be a perfect candidate for \(uni.name)"
                    paragraphExplanation.text = explanation
                } else {
                    let explanation = "GPA and \(uni.bestEvent) data is unavailable for \(uni.name)"
                    paragraphExplanation.text = explanation
                }
                return
            }
            
            athleticLinearProgressView.setProgress(prog, animated: false)
            
            if hasGPA {
                let explanation = "You need a \(uni.gpa) GPA and a \(uniMark) \(uni.bestEvent.lowercased()) to be a perfect candidate for \(uni.name)"
                paragraphExplanation.text = explanation
            } else {
                let explanation = "You need a \(uniMark) \(uni.bestEvent.lowercased()) to be a perfect candidate for \(uni.name)"
                paragraphExplanation.text = explanation
            }
            
            let attributedText5 = NSMutableAttributedString(string: userMark, attributes: [NSAttributedString.Key.font: font1!])
            let attributedText6 = NSMutableAttributedString(string: "/" + uniMark, attributes: [.font: font2!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
            attributedText5.append(attributedText6)
            markProgressLabel.attributedText = attributedText5
            
            if userInt < uniInt {
                let attributedText7 = NSMutableAttributedString(string: "PERFECT", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                markSubtractLabel.attributedText = attributedText7
            } else {
                let secsAway = userInt - uniInt
                if secsAway < 60 {
                    let attributedText7 = NSMutableAttributedString(string: String(secsAway) + " seconds", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                    
                    let attributedText8 = NSMutableAttributedString(string: " to go", attributes: [NSAttributedString.Key.font: font1!])
                    attributedText7.append(attributedText8)
                    markSubtractLabel.attributedText = attributedText7
                } else {
                    let minsAway = Int(secsAway) / 60
                    let secs = (secsAway) - Int(minsAway * 60)
                    let attributedText7 = NSMutableAttributedString(string: String(minsAway) + " mins and " + String(secs) + " secs", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
                    
                    let attributedText8 = NSMutableAttributedString(string: " to go", attributes: [NSAttributedString.Key.font: font1!])
                    attributedText7.append(attributedText8)
                    markSubtractLabel.attributedText = attributedText7
                }
            }
        }
        
        
        
        
//        let attributedText5 = NSMutableAttributedString(string: "9:32", attributes: [NSAttributedString.Key.font: font1!])
//        let attributedText6 = NSMutableAttributedString(string: "/9:08", attributes: [.font: font2!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
//        attributedText5.append(attributedText6)
//        markProgressLabel.attributedText = attributedText5
//
//        let attributedText7 = NSMutableAttributedString(string: "24 seconds", attributes: [.font: font1!, NSAttributedString.Key.foregroundColor: pheidiColors.pheidiTeal])
//
//        let attributedText8 = NSMutableAttributedString(string: " to go", attributes: [NSAttributedString.Key.font: font1!])
//
//        attributedText7.append(attributedText8)
//        markSubtractLabel.attributedText = attributedText7
        
        
        //MARK: MATCH LEVEL
        
        if uni.match == "N/A" {
            arrowImage.image = UIImage(named: "question")
            matchStatusLabel.text = uni.match
        }
        
        
        let number = Int.random(in: 0...2)
        let lowImage = UIImage(named: "downArrow")
        let medImage = UIImage(named: "rightArrow")
        let hiImage = UIImage(named: "upArrow")
        let matchLevel = Int(uni.match)!
        
        if matchLevel >= 0 && matchLevel <= 50 {
            arrowImage.image = lowImage
            matchStatusLabel.text = "LOW"
        } else if matchLevel <= 75 {
            arrowImage.image = medImage
            matchStatusLabel.text = "MEDIUM"
        } else {
           arrowImage.image = hiImage
            matchStatusLabel.text = "HIGH"
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if let sender = sender as? UIButton {
            NotificationCenter.default.post(name: Notification.Name("Cell Removed"), object: nil, userInfo: ["tag": sender.tag])
        }
    }
    
    @IBAction func schoolOverviewTapped(_ sender: Any) {
        if let sender = sender as? UIButton {
            NotificationCenter.default.post(name: Notification.Name("Overview Requested"), object: nil, userInfo: ["tag": sender.tag])
        }
    }
    
}
