//
//  uniInfoViewController.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/22/20.
//

import UIKit
import MKRingProgressView

class uniInfoViewController: UIViewController {
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
        
        gpa.textColor = .green
        testScore.textColor = .green
        
        closeButton.layer.cornerRadius = 20
        
        createMarkField()
        
        
        athleticProgressWidthConstraint.constant = 0
        academicProgressWidthConstraint.constant = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {        
        athleticProgressWidthConstraint.constant = 240
        academicProgressWidthConstraint.constant = 150
        
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut, animations: {
            self.matchScoreRing.progress = 0.6
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func createMarkField() {
        let font1 = UIFont(name: "Proxima Nova Regular", size: 12)
        let font2 = UIFont(name: "Proxima Nova Bold", size: 28)
        
        
        let attrs1 = [NSAttributedString.Key.font : font1, NSAttributedString.Key.foregroundColor : UIColor.green]
        
        let attrs2 = [NSAttributedString.Key.font : font2, NSAttributedString.Key.foregroundColor : UIColor.green]

        let attributedString1 = NSMutableAttributedString(string:"9:06", attributes:attrs2 as [NSAttributedString.Key : Any])

        let attributedString2 = NSMutableAttributedString(string:" 3200M", attributes:attrs1 as [NSAttributedString.Key : Any])

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
    }
    
    @IBAction func pressContact(_ sender: Any) {
        buttonPress(contactButton) {
            //ADD LOGIC
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
