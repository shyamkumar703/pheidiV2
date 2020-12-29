//
//  questionsViewController.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/25/20.
//

import UIKit
import CoreData


var firstAnswers: [String] = []
var marksAnswers: [String] = []

class questionsViewController: UIViewController {
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var textFieldAnswer: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var frontViewWidth: NSLayoutConstraint!
    @IBOutlet weak var skipButton: UIButton!
    
    var questionsArr = ["What is your first name?", "What is your last name?", "What is your GPA?", "What is your SAT?", "What is your ACT?"]
    var eventsArr = ["", "", "GPA", "SAT", "ACT"]
    var index = 0
    var marks = false
    var lastPerson: NSManagedObject? = nil
    
    let gpaChars: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
    let testScoreChars: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    let intEventChars: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ":", "0"]
    let doubleEventChars: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ".", "0"]
    let fieldEventChars: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "-", "0"]
    
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
        
        skipButton.alpha = 0
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            lastPerson = (try context.fetch(request) as! [NSManagedObject]).last!
        } catch {
            print("Failed")
        }

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
//        saveCurrentAnswer()
        self.index -= 1
        changeView()
        calculateProgressViewWidth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if question.text == "What is your ACT?" || question.text == "What is your SAT?" {
            skipButton.alpha = 1
        }
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
        checkChangeValidity()
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
        saveCurrentAnswer()
        self.index += 1
        profileViewController.buttonPress(nextButton, completion: nil)
        changeView()
        calculateProgressViewWidth()
    }
    
    @IBAction func skipPressed(_ sender: Any) {
        self.index += 1
        profileViewController.buttonPress(nextButton, completion: nil)
        changeView()
        calculateProgressViewWidth()
    }
    
    
    func saveCurrentAnswer() {
        let currEvent: Event? = fullEventDict[eventsArr[index]]
        if currEvent != nil {
            if !user.statArr.contains(currEvent!.questionName) {
                user.statArr.append(currEvent!.questionName)
            }
        }
        
        if marks {
            if index > marksAnswers.count - 1 {
                marksAnswers.append(textFieldAnswer.text ?? "")
            } else {
                marksAnswers[index] = textFieldAnswer.text ?? ""
            }
        } else {
            if index > firstAnswers.count - 1 {
                firstAnswers.append(textFieldAnswer.text ?? "")
            } else {
                firstAnswers[index] = textFieldAnswer.text ?? ""
            }
        }
        
        if !marks && self.index == 1 {
            let name = firstAnswers[0] + " " + firstAnswers[1]
            user.saveName(name)
        }
        
        
        switch currEvent?.eventType {
        case .double:
            let currentDouble = User.stringToDouble(textFieldAnswer.text ?? "0")
            if currentDouble != 0 {
                user.currEvents.append(currEvent!.questionName)
            }
            currEvent?.saveValueDouble(currEvent!.coreDataKey, currentDouble)
        case .int:
            let currentInt = Int(User.stringToDouble(textFieldAnswer.text ?? "0"))
            if currentInt != 0 {
                user.currEvents.append(currEvent!.questionName)
            }
            currEvent?.saveValueInt(currEvent!.coreDataKey, currentInt)
        case .feet:
            let currentDouble = User.stringToFt(textFieldAnswer.text ?? "0")
            if currentDouble != 0 {
                user.currEvents.append(currEvent!.questionName)
            }
            currEvent?.saveValueDouble(currEvent!.coreDataKey, currentDouble)
        default:
            return
        }

        do {
            try context.save()
        } catch {
            print("Failed")
        }
    }
    
    func changeView() {
        if marks == true && self.index == -1 {
            
            marksAnswers = []
            user.statArr = user.statArr.filter { stat in
                stat == "GPA" || stat == "SAT" || stat == "ACT"
            }
            
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
//                self.navigationController?.navigationBar.alpha = 0
            }, completion: {fin in
//                self.dismiss(animated: false, completion: nil)
                self.navigationController?.popToRootViewController(animated: false)
                firstAnswers = []
                user.statArr = []
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
                        user.saveCurrStats(user.statArr)
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
                if self.question.text == "What is your SAT?" || self.question.text == "What is your ACT?" {
                    self.skipButton.alpha = 1
                } else {
                    self.skipButton.alpha = 0
                }
                
                if self.eventsArr[self.index] != "" && fullEventDict[self.eventsArr[self.index]]?.eventType == .feet {
                    self.textFieldAnswer.placeholder = "Feet-Inches"
                } else {
                    self.textFieldAnswer.placeholder = ""
                }
                
                self.question.alpha = 1
                
                var answersArr = firstAnswers
                if self.marks {
                    answersArr = marksAnswers
                }
                if self.index < answersArr.count {
                    self.textFieldAnswer.text = answersArr[self.index]
                } else {
                    self.textFieldAnswer.text = ""
                }

                
                if self.textFieldAnswer.text != "" {
                    self.nextButton.alpha = 1
                }
                
                self.textFieldAnswer.alpha = 1
                
            }, completion: nil)
        })
    }
    
    func checkChangeValidity() {
        
        let eventType: String
        if fullEventDict[self.eventsArr[self.index]]?.questionName != nil {
            eventType = fullEventDict[self.eventsArr[self.index]]!.questionName
        } else {
            eventType = ""
        }
        
        
        switch eventType {
                case "GPA":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 4)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: gpaChars)
                case "SAT":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 4)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: testScoreChars)
                case "ACT":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 2)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: testScoreChars)
                case "3200M":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 5)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: intEventChars)
                    checkLongTrackFormat(textField: textFieldAnswer)
                case "1600M":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 5)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: intEventChars)
                    checkLongTrackFormat(textField: textFieldAnswer)
                case "100M":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 5)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: doubleEventChars)
                    checkShortTrackFormat(textField: textFieldAnswer)
                case "200M":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 5)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: doubleEventChars)
                    checkShortTrackFormat(textField: textFieldAnswer)
                case "400M":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 6)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: doubleEventChars)
                    checkLongTrackFormat(textField: textFieldAnswer)
                case "800M":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 7)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: doubleEventChars)
                    checkLongTrackFormat(textField: textFieldAnswer)
                case "110M Hurdles":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 5)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: doubleEventChars)
                    checkShortTrackFormat(textField: textFieldAnswer)
                case "300M Hurdles":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 6)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: doubleEventChars)
                    checkLongTrackFormat(textField: textFieldAnswer)
                case "Shotput":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 8)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: fieldEventChars)
                    checkFieldFormat(textField: textFieldAnswer)
                case "Discus":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 9)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: fieldEventChars)
                    checkFieldFormat(textField: textFieldAnswer)
                case "High Jump":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 7)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: fieldEventChars)
                    checkFieldFormat(textField: textFieldAnswer)
                case "Long Jump":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 8)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: fieldEventChars)
                    checkFieldFormat(textField: textFieldAnswer)
                case "Triple Jump":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 8)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: fieldEventChars)
                    checkFieldFormat(textField: textFieldAnswer)
                case "Pole Vault":
                    checkMaxLength(textField: textFieldAnswer, maxLength: 8)
                    checkAllowedChars(textField: textFieldAnswer, allowedChars: fieldEventChars)
                    checkFieldFormat(textField: textFieldAnswer)
                default:
                    checkMaxLength(textField: textFieldAnswer, maxLength: 9)
                }
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text!.count > maxLength) {
            textField.deleteBackward()
        }
    }
        
    func checkAllowedChars(textField: UITextField, allowedChars: [Character]) {
        for char in textField.text! {
            if !(allowedChars.contains(char)) {
                    textField.deleteBackward()
            }
        }
    }
    
    func checkShortTrackFormat(textField: UITextField) {
        let text: String = textField.text!
        if !text.contains(".") {
            if text.count > 2 {
                textField.deleteBackward()
            }
        } else {
            let charArr = Array(text)
            let periodCount = charArr.filter{$0 == "."}.count
            if periodCount > 1 {
                textField.deleteBackward()
            } else if charArr[0] == "." {
                textField.deleteBackward()
            }
        }
    }
        
    func checkLongTrackFormat(textField: UITextField) {
        let text: String = textField.text!
        if !text.contains(".") && !text.contains(":") {
            if text.count > 2 {
                textField.deleteBackward()
            }
        } else {
            let charArr = Array(text)
            if charArr.contains(":") {
                let colonCount = charArr.filter{$0 == ":"}.count
                if colonCount > 1 {
                    textField.deleteBackward()
                }
                if charArr.count == 1 {
                    textField.deleteBackward()
                }
                if charArr.count > 3 {
                    if !(charArr[1] == ":" || charArr[2] == ":") {
                        textField.deleteBackward()
                    }
                }
            } else if charArr.contains(".") {
                let periodCount = charArr.filter{$0 == "."}.count
                if periodCount > 1 {
                    textField.deleteBackward()
                } else if charArr.count == 1 {
                    textField.deleteBackward()
                }
            } else {
                let charArr = Array(text)
                if charArr.contains(":") && charArr.contains(".") {
                    if charArr.firstIndex(of: ".")! > charArr.firstIndex(of: ":")! {
                            textField.text = "-"
                    }
                }
            }
        }
    }
        
    func checkFieldFormat(textField: UITextField) {
        let text: String = textField.text!
        if text.count == 1 {
            if text.contains("-") || text.contains(".") {
                textField.deleteBackward()
            }
        } else if text.count == 3 {
            let charArr = Array(text)
            let dashCount = charArr.filter{$0 == "-"}.count
            let periodCount = charArr.filter{$0 == "."}.count
            if dashCount > 1 {
                textField.deleteBackward()
            }
            if periodCount > 1 {
                textField.deleteBackward()
            }
        } else {
            let charArr = Array(text)
            if charArr.contains(":") && charArr.contains("-") {
                if charArr.firstIndex(of: ".")! > charArr.firstIndex(of: "-")! {
                    textField.text = "-"
                }
            }
        }
    }
    
    @IBAction func answerChanged(_ sender: Any) {
        checkChangeValidity()
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
