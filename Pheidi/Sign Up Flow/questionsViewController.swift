//
//  questionsViewController.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/25/20.
//

import UIKit

class questionsViewController: UIViewController {
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var textFieldAnswer: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var frontViewWidth: NSLayoutConstraint!
    
    var questionsArr = ["What is your first name?", "What is your last name?", "What is your GPA?", "What is your SAT?", "What is your ACT?"]
    var index = 0
    var marks = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        question.alpha = 1
        textFieldAnswer.alpha = 1
        
        
        nextButton.layer.cornerRadius = 20
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(popToPrevious))
        
        let image: UIImage = UIImage(named: "pheidiLogoSmall")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 3.5))
        imageView.image = image
        self.navigationItem.titleView = imageView
        
        question.text = questionsArr[index]
        
        nextButton.alpha = 0
        
        frontView.layer.cornerRadius = 3
        backView.layer.cornerRadius = 3
        
        frontViewWidth.constant = 0

        // Do any additional setup after loading the view.
    }
    
    func calculateProgressViewWidth() {
        let prop = Double(index) / Double(questionsArr.count)
        let newWidth = (UIScreen.main.bounds.width - 40) * CGFloat(prop)
        frontViewWidth.constant = newWidth
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func popToPrevious() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        self.index -= 1
        changeView()
        calculateProgressViewWidth()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textFieldAnswer.becomeFirstResponder()
        calculateProgressViewWidth()
    }
    
    @IBAction func textFieldEditingBegin(_ sender: Any) {
        if textFieldAnswer.text != "" {
            UIView.animate(withDuration: 0.3, animations: {
                self.nextButton.alpha = 1
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.nextButton.alpha = 0
            })
        }
    }
    
    @IBAction func textFieldEditingEnd(_ sender: Any) {
        if textFieldAnswer.text != "" {
            UIView.animate(withDuration: 0.3, animations: {
                self.nextButton.alpha = 1
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.nextButton.alpha = 0
            })
        }
    }
    
    @IBAction func editingChanged(_ sender: Any) {
        if textFieldAnswer.text != "" {
            UIView.animate(withDuration: 0.3, animations: {
                self.nextButton.alpha = 1
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.nextButton.alpha = 0
            })
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
    @IBAction func nextPressed(_ sender: Any) {
        self.index += 1
        profileViewController.buttonPress(nextButton, completion: nil)
        changeView()
        calculateProgressViewWidth()
    }
    
    func changeView() {
        if marks == true && self.index == -1 {
            UIView.animate(withDuration: 0.3, animations: {
                self.question.alpha = 0
                self.textFieldAnswer.alpha = 0
                self.nextButton.alpha = 0
                self.frontView.alpha = 0
                self.backView.alpha = 0
            }, completion: {fin in
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let prevViewController = storyBoard.instantiateViewController(withIdentifier: "selectEvents") as! selectEventsViewController
                self.navigationController?.pushViewController(prevViewController, animated: false)
            })
            return
        }
        
        if self.index == -1 {
            UIView.animate(withDuration: 0.3, animations: {
                self.question.alpha = 0
                self.textFieldAnswer.alpha = 0
                self.nextButton.alpha = 0
                self.frontView.alpha = 0
                self.backView.alpha = 0
                self.navigationController?.navigationBar.alpha = 0
            }, completion: {fin in
                self.dismiss(animated: false, completion: nil)
            })
            return
        }
        
        if self.index == questionsArr.count {
            UIView.animate(withDuration: 0.5, animations: {
                self.question.alpha = 0
                self.textFieldAnswer.alpha = 0
                self.nextButton.alpha = 0
                self.frontView.alpha = 0
                self.backView.alpha = 0
                if self.marks == true {
                    self.navigationController?.navigationBar.alpha = 0
                }
            }, completion: {fin in
                if self.marks == true {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    self.modalPresentationStyle = .overCurrentContext
                    if let tabViewController = storyboard.instantiateViewController(withIdentifier: "tabBar") as? UITabBarController {
                        tabViewController.modalPresentationStyle = .overCurrentContext
                        self.present(tabViewController, animated: false, completion: nil)
                        UserDefaults.standard.setValue(true, forKey: "finishedReg")
                    }
                    return
                }
                self.performSegue(withIdentifier: "selectEvents", sender: self)
            })
            return
        }
        UIView.animate(withDuration: 0.3, delay:0 , options: .curveLinear,  animations: {
            self.question.alpha = 0
            self.textFieldAnswer.alpha = 0
            self.nextButton.alpha = 0
        }, completion: {fin in
            UIView.animate(withDuration: 0.3, delay:0, options: .curveLinear, animations: {
                self.textFieldAnswer.text = ""
                self.question.text  = self.questionsArr[self.index]
                self.question.alpha = 1
                self.nextButton.alpha = 1
                self.textFieldAnswer.alpha = 1
            }, completion: nil)
        })
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
