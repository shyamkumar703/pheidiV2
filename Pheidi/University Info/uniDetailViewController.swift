//
//  uniDetailViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/19/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import StatusAlert
import MessageUI

class uniDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    var currUni: University? = nil
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var testBackView: UIView!
    @IBOutlet weak var mailButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var divisionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cityStateLabel: UILabel!
    
    
    
    
    
    
    let featureView2 = Bundle.main.loadNibNamed("topOverview", owner: self, options: nil)?.first as? topOverview

    override func viewDidLoad() {
        super.viewDidLoad()
        if currUni!.city != "nan" && currUni!.state != "nan" {
            cityStateLabel.text = "\(currUni!.city), \(currUni!.state)"
        } else {
            cityStateLabel.text = ""
        }
        divisionLabel.text = makeDivisionString(currUni!.division).uppercased()
        detailView.addSubview(featureView2!)
        if user.starredUniversities.contains(currUni!.key) {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        featureView2?.progressView.setProgress(0, animated: false)
        if currUni!.sat != 0 {
            featureView2!.sat.text = String(currUni!.sat)
        } else {
            featureView2!.sat.text = "N/A"
        }
        if currUni!.act != 0 {
            featureView2!.act.text = String(currUni!.act)
        } else {
            featureView2!.act.text = "N/A"
        }
        if currUni!.gpaVal != 0 {
            featureView2!.gpa.text = currUni!.gpa
        } else {
            featureView2!.gpa.text = "N/A"
        }
        if currUni!.match != "N/A" {
            featureView2?.matchPercentage.text = currUni!.match + "%"
        } else {
            featureView2?.matchPercentage.text = "N/A"
        }
        featureView2!.setLabels(currUni!.bestEvent, currUni!.uniMarkBestEvent)
//        featureView2!.sat.text = String(currUni!.sat)
//        featureView2!.act.text = String(currUni!.act)
//        featureView2!.gpa.text = currUni!.gpa
        if currUni!.accepRate != 0.0 {
            featureView2!.accepRate.text = String(currUni!.accepRate) + "%"
        } else {
            featureView2!.accepRate.text = "N/A"
        }
        
        name.text! = currUni!.name
        frontImage.image = UIImage(named: currUni!.focus)
        
        
        let color1 = UIColor(red:0.00, green:0.65, blue:0.81, alpha:1.0)
        let color2 = UIColor(red:0.00, green:0.31, blue:0.39, alpha:1.0)
        let color3 = UIColor.systemPink
        
        switch currUni!.division {
        case "Division 1":
            pheidiColors.addGradientColorToView(view: testView, color: color1)
            testBackView.backgroundColor = color1
        case "Division 2":
            pheidiColors.addGradientColorToView(view: testView, color: color2)
            testBackView.backgroundColor = color2
        case "Division 3":
            pheidiColors.addGradientColorToView(view: testView, color: color3)
            testBackView.backgroundColor = color3
        default:
            pheidiColors.addGradientColorToView(view: testView, color: color3)
            testBackView.backgroundColor = color3
            
        }
        
        if currUni!.email == "" {
            mailButton.layer.cornerRadius = 8
            mailButton.layer.borderColor = pheidiColors.pheidiGray.cgColor
            mailButton.layer.borderWidth = 1.0
            mailButton.setTitleColor(pheidiColors.pheidiGray, for: .normal)
            mailButton.setTitle("NO CONTACT INFO", for: .normal)
            mailButton.isEnabled = false
        } else {
            mailButton.layer.cornerRadius = 8
            mailButton.layer.borderColor = pheidiColors.pheidiTeal.cgColor
            mailButton.layer.borderWidth = 1.0
        }
        // Do any additional setup after loading the view.
    }
    
    func makeDivisionString(_ divValue: String) -> String {
        if divValue.contains("Division") {
            return "NCAA " + divValue
        } else {
            return divValue
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        featureView2!.initView()
        featureView2!.animateProgress(currUni!.match)
        featureView2!.animateEventView(currUni!.bestEvent, currUni!.uniMarkBestEvent, currUni!.userMarkBestEvent)
        scrollView.flashScrollIndicators()
        
    }
    
    @IBAction func close(_ sender: Any) {
        //detailView.bringSubviewToFront(rankingsView)
        self.dismiss(animated: true)
    }
    
    @IBAction func starButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("Star Pressed"), object: nil, userInfo: nil)
        
        if !user.starredUniversities.contains(currUni!.key) {
            user.starredUniversities.append(currUni!.key)
            user.saveStarredArr(user.starredUniversities)
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            let statusAlert = StatusAlert()
            statusAlert.title = "Starred"
            statusAlert.message = String(currUni!.name) + " has been starred"
            statusAlert.image = UIImage(named: "checkmark")
            statusAlert.appearance.blurStyle = .dark
            statusAlert.showInKeyWindow()
            
        } else {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
            user.saveStarredArr(user.starredUniversities.filter({$0 != currUni!.key}))
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            let statusAlert = StatusAlert()
            statusAlert.title = "Unstarred"
            statusAlert.message = String(currUni!.name) + " has been unstarred"
            statusAlert.image = UIImage(named: "delete")
            statusAlert.appearance.blurStyle = .dark
            statusAlert.showInKeyWindow()
        }
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([currUni!.email])
            mail.setSubject("\(user.name)- Potential Recruit")
            mail.setMessageBody(user.makeMailString(currUni!.coach), isHTML: false)

            present(mail, animated: true)
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            let statusAlert = StatusAlert()
            statusAlert.title = "Error"
            statusAlert.message = "No mail accounts enabled on this device"
            statusAlert.image = UIImage(named: "delete")
            statusAlert.appearance.blurStyle = .dark
            statusAlert.showInKeyWindow()
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        if error == nil && result == .sent {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            let statusAlert = StatusAlert()
            statusAlert.title = "Success"
            statusAlert.message = "Coach \(currUni!.coach) has been contacted"
            statusAlert.image = UIImage(named: "checkmark")
            statusAlert.appearance.blurStyle = .dark
            statusAlert.showInKeyWindow()
            return
        } else if result == .failed {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            let statusAlert = StatusAlert()
            statusAlert.title = "Error"
            statusAlert.message = "No mail accounts enabled on this device"
            statusAlert.image = UIImage(named: "delete")
            statusAlert.appearance.blurStyle = .dark
            statusAlert.showInKeyWindow()
        }
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        sendEmail()
    }
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    @IBAction func panRecognizer(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)

        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
