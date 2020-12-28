//
//  uniInfoViewController.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/22/20.
//

import UIKit
import MKRingProgressView
import MessageUI

class uniInfoViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var athleticFitView: UIView!
    @IBOutlet weak var academicFitView: UIView!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var backProgressView: UIView!
    @IBOutlet weak var frontProgressView: UIView!
    @IBOutlet weak var secondBackProgressView: UIView!
    @IBOutlet weak var secondFrontProgressView: UIView!
    @IBOutlet weak var gpa: UILabel!
    @IBOutlet weak var testScore: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var matchScoreRing: RingProgressView!
    @IBOutlet weak var athleticProgressWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var academicProgressWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var division: UILabel!
    @IBOutlet weak var academicMatchLabel: UILabel!
    @IBOutlet weak var athleticMatchLabel: UILabel!
    @IBOutlet weak var testScoreDescription: UILabel!
    
    let alert = Bundle.main.loadNibNamed("alertView", owner: self, options: nil)?.first as? alertView
    var heightAnchor: NSLayoutConstraint? = nil
    
    var uni: University? = nil
    
    var academicProp: Double = 0
    var athleticProp: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        athleticFitView.layer.cornerRadius = 10
        academicFitView.layer.cornerRadius = 10
        backProgressView.layer.cornerRadius = 5
        frontProgressView.layer.cornerRadius = 5
        secondBackProgressView.layer.cornerRadius = 5
        secondFrontProgressView.layer.cornerRadius = 5
        
        addButton.layer.cornerRadius = 25
        addButton.backgroundColor = Colors.blueOpaq
        
        contactButton.layer.cornerRadius = 10
        
        gpa.textColor = Colors.green
        testScore.textColor = Colors.green
        
        closeButton.layer.cornerRadius = 20
        
        createMarkField()
        
        
        athleticProgressWidthConstraint.constant = 0
        academicProgressWidthConstraint.constant = 0
        
        customizeOverallMatchProgress()
        customizeTitleView()
        customizeAcademicView()
        customizeAthleticView()
        
        setupAlertView()
        
        if user.starredUniversities.contains(self.uni!.key) {
            addButton.backgroundColor = Colors.redOpaq
            addButton.setImage(UIImage(systemName: "minus"), for: .normal)
            addButton.setTitle("", for: .normal)
            addButton.tintColor = Colors.red
        }
        
        if uni?.email == "" {
            contactButton.alpha = 0
        }
        
    }
    
    func customizeAthleticView() {
        let athleticMatch = uni?.athleticMatch
        
        if athleticMatch == "N/A" {
            athleticMatchLabel.text = "-"
        } else {
            var athleticMatchDouble = Double(athleticMatch!)
            athleticProp = athleticMatchDouble!
            athleticMatchDouble = (athleticMatchDouble?.truncate(places: 2))! * 100
            athleticMatchLabel
                .text = String(Int(athleticMatchDouble!)) + "%"
            
            if athleticMatchDouble! > 75 {
                athleticMatchLabel.textColor = Colors.green
                frontProgressView.backgroundColor = Colors.green
                backProgressView.backgroundColor = Colors.greenOpaq
            } else if athleticMatchDouble! < 50 {
                athleticMatchLabel.textColor = Colors.red
                frontProgressView.backgroundColor = Colors.red
                backProgressView.backgroundColor = Colors.redOpaq
            }
        }
    }
    
    func customizeAcademicView() {
        let gpa = uni!.gpa
        let sat = uni?.sat
        let act = uni?.act
        let academicMatch = uni?.academicMatch
        
        if gpa == "" {
            self.gpa.text = "-"
        } else {
            self.gpa.text = gpa
        }
        
        if user.act != 0 {
            testScoreDescription.text = "Average Admit ACT"
            if act == 0 {
                testScore.text = "-"
            } else {
                testScore.text = String(act!)
            }
        } else {
            if sat == 0 {
                testScore.text = "-"
            } else {
                testScore.text = String(sat!)
            }
        }
        
        if academicMatch == "N/A" {
            academicMatchLabel.text = "-"
        } else {
            var academicMatchDouble = Double(academicMatch!)
            if academicMatchDouble! > 1 {
                academicMatchDouble = 1
            }
            academicProp = academicMatchDouble!
            academicMatchDouble = academicMatchDouble!.truncate(places: 2) * 100
            academicMatchLabel.text = String(Int(academicMatchDouble!)) + "%"
            
            if academicMatchDouble! > 75 {
                academicMatchLabel.textColor = Colors.green
                secondFrontProgressView.backgroundColor = Colors.green
                secondBackProgressView.backgroundColor = Colors.greenOpaq
            } else if academicMatchDouble! > 50 {
                academicMatchLabel.textColor = Colors.yellow
                secondFrontProgressView.backgroundColor = Colors.yellow
                secondBackProgressView.backgroundColor = Colors.yellowOpaq
            }
        }
    }
    
    func customizeTitleView() {
        switch uni!.division {
        case "Division 2":
            division.textColor = Colors.yellow
        case "Division 3":
            division.textColor = Colors.red
        case "NAIA":
            division.textColor = Colors.blue
        default:
            print("hello")
        }
        
        
        school.adjustsFontSizeToFitWidth = true
        school.text = uni!.name
        if uni!.city == "" || uni!.state == "" {
            city.text = "-"
        } else {
            city.text = uni!.city + ", " + uni!.state
        }
        if uni!.division == "" {
            division.text = "-"
        } else {
            division.text = uni?.division
        }
    }
    
    func customizeOverallMatchProgress() {
        matchLabel.text = uni!.match + "%"
        let matchScore = Int(uni!.match)
        
        if matchScore == nil {
            matchLabel.text = "-"
            matchLabel.textColor = Colors.red
            matchScoreRing.backgroundRingColor = Colors.redOpaq
            matchScoreRing.endColor = Colors.red
            matchScoreRing.startColor = Colors.red
            return
        }
        
        
        if matchScore! < 50 {
            matchLabel.textColor = Colors.red
            matchScoreRing.backgroundRingColor = Colors.redOpaq
            matchScoreRing.endColor = Colors.red
            matchScoreRing.startColor = Colors.red
        } else if matchScore! > 75 {
            matchLabel.textColor = Colors.green
            matchScoreRing.backgroundRingColor = Colors.greenOpaq
            matchScoreRing.endColor = Colors.green
            matchScoreRing.startColor = Colors.green
        } else {
            matchLabel.textColor = Colors.yellow
            matchScoreRing.backgroundRingColor = Colors.yellowOpaq
            matchScoreRing.endColor = Colors.yellow
            matchScoreRing.startColor = Colors.yellow
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let backViewWidth = UIScreen.main.bounds.width - 56
        athleticProgressWidthConstraint.constant = backViewWidth * CGFloat(athleticProp)
        academicProgressWidthConstraint.constant = backViewWidth * CGFloat(academicProp)
        
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut, animations: {
            if self.uni!.match != "N/A" {
                self.matchScoreRing.progress = Double(self.uni!.match)! / 100.0
            } else {
                self.matchScoreRing.progress = 0
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func createMarkField() {
        let font1 = UIFont(name: "Proxima Nova Regular", size: 12)
        let font2 = UIFont(name: "Proxima Nova Bold", size: 28)
        
        let bestEventObject = fullEventDict[uni!.bestEvent]
        let bestEvent = fullEventDict[uni!.bestEvent]?.questionName ?? ""
        let markString = bestEventObject?.createMarkString(uni!.uniMarkBestEvent) ?? "-"
        
        let attrs1 = [NSAttributedString.Key.font : font1, NSAttributedString.Key.foregroundColor : Colors.green]
        
        let attrs2 = [NSAttributedString.Key.font : font2, NSAttributedString.Key.foregroundColor : Colors.green]

        let attributedString1 = NSMutableAttributedString(string:markString, attributes:attrs2 as [NSAttributedString.Key : Any])

        let attributedString2 = NSMutableAttributedString(string:" " + bestEvent, attributes:attrs1 as [NSAttributedString.Key : Any])

        attributedString1.append(attributedString2)
        markLabel.attributedText = attributedString1
    }
    
    @IBAction func close(_ sender: Any) {
        UIView.animate(withDuration: 0.1,
            animations: {
                self.closeButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.closeButton.transform = CGAffineTransform.identity
                }, completion: {_ in
                    self.dismiss(animated: true, completion: nil)
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
                })
            })
    }
    
    @IBAction func touchDown(_ sender: Any) {
        UIView.animate(withDuration: 0.3,
            animations: {
                self.closeButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 1.0, delay: 0.3) {
                    self.closeButton.transform = CGAffineTransform.identity
                }
            })
    }
    
    @IBAction func pressAdd(_ sender: Any) {
        buttonPress(addButton) {
            //ADD LOGIC
        }
        if !user.starredUniversities.contains(self.uni!.key) {
            self.showAlertView(true, "Added to My List")
            user.starredUniversities.append(self.uni!.key)
            self.addButton.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.addButton.alpha = 0
            }, completion: {fin in
                self.addButton.backgroundColor = Colors.redOpaq
                self.addButton.setImage(UIImage(systemName: "minus"), for: .normal)
                self.addButton.tintColor = Colors.red
                UIView.animate(withDuration: 0.3, animations: {
                    self.addButton.alpha = 1
                })
            })
        } else {
            self.showAlertView(false, "Removed from My List")
            print(user.starredUniversities)
            user.starredUniversities = user.starredUniversities.filter {key in
                key != self.uni!.key
            }
            print(user.starredUniversities)
            self.addButton.setImage(nil, for: .normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.addButton.alpha = 0
            }, completion: {fin in
                self.addButton.backgroundColor = Colors.blueOpaq
                self.addButton.setTitle("+", for: .normal)
                UIView.animate(withDuration: 0.3, animations: {
                    self.addButton.alpha = 1
                })
            })
        }
        user.saveStarredArr(user.starredUniversities)
    }
    
    func setupAlertView() {
        let margins = view.layoutMarginsGuide
//        alert?.setup(false)
        alert!.alpha = 0
        self.view.addSubview(alert!)
        alert?.translatesAutoresizingMaskIntoConstraints = false
        
        alert!.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true
        alert!.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        alert!.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        
        heightAnchor = alert!.heightAnchor.constraint(equalToConstant: 0)
        heightAnchor!.isActive = true
        
        alert!.layer.shadowColor = UIColor.black.cgColor
        alert!.layer.shadowOpacity = 1
        alert!.layer.shadowOffset = .zero
        alert!.layer.shadowRadius = 10
    }
    
    func showAlertView(_ success: Bool, _ message: String) {
        alert!.setup(success, message)
        heightAnchor?.constant = 53
        UIView.animate(withDuration: 0.3, animations: {
            self.alert!.alpha = 1
            self.alert!.layoutIfNeeded()
        }, completion: {fin in
            UIView.animate(withDuration: 0.3, delay: 1.3, animations: {
                self.alert!.alpha = 0
                self.alert!.layoutIfNeeded()
            }, completion: {fin in
                self.heightAnchor = self.alert!.heightAnchor.constraint(equalToConstant: 0)
                self.heightAnchor!.isActive = true
            })
        })
    }
    
    @IBAction func pressContact(_ sender: Any) {
        buttonPress(contactButton) {
            //ADD LOGIC
            user.name = "Shyam Kumar"
            self.sendEmail()
        }
    }
    
    func buttonPress(_ view: UIView, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.1,
            animations: {
                view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    view.transform = CGAffineTransform.identity
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
                    completion()
                }
            })
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([uni!.email])
            mail.setSubject("\("Shyam Kumar")- Potential Recruit")
            mail.setMessageBody(user.makeMailString(uni!.coach), isHTML: false)

            present(mail, animated: true)
        } else {
//            let generator = UINotificationFeedbackGenerator()
//            generator.notificationOccurred(.error)
            showAlertView(false, "No mail accounts available")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        if error == nil && result == .sent {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            showAlertView(true, "Email sent")
            if !user.contactedUniversities.contains(uni!.key) {
                user.contactedUniversities.append(uni!.key)
                user.saveContactedArr(user.contactedUniversities)
            }
            return
        } else if result == .failed {
//            let generator = UINotificationFeedbackGenerator()
//            generator.notificationOccurred(.error)
//            let statusAlert = StatusAlert()
//            statusAlert.title = "Error"
//            statusAlert.message = "No mail accounts enabled on this device"
//            statusAlert.image = UIImage(named: "delete")
//            statusAlert.appearance.blurStyle = .dark
//            statusAlert.showInKeyWindow()
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
