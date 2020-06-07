//
//  addEventsViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/23/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class addEventsViewController: UIViewController {
    @IBOutlet weak var addview: UIView!
    var gender: String? = nil
    var eventGroup: String? = nil
    var selectedEvents: [String]? = nil
    var name: String = ""
    var page = 0
    var viewArr: [addEvents] = []
    var eventDict: [String: Float] = [:]
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    var initVal = ""
    @IBOutlet weak var frontButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedEvents! += ["GPA", "SAT", "ACT"]
        let currView = Bundle.main.loadNibNamed("addEvents", owner: self, options: nil)?.first as? addEvents
        pageTitle.text = selectedEvents![0]
        setupView(currView!, selectedEvents![0])
        viewArr.append(currView!)
        
        addview.addSubview(currView!)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        
        let alphaColor = UIColor(red:0.00, green:0.70, blue:0.56, alpha:1.0)
        pheidiColors.addGradientColorToView(view: self.view, color: alphaColor)
        skipButton.layer.cornerRadius = 8
        skipButton.layer.borderWidth = 1.0
        skipButton.layer.borderColor = UIColor.black.cgColor
        skipButton.isHidden = true

        // Do any additional setup after loading the view.
    }
    @IBAction func backButton(_ sender: Any) {
        if page  == 0 {
            performSegue(withIdentifier: "unwind", sender: self)
            return
        }
        addview.isHidden = true
        addview.subviews[page].isHidden = true
        addview.subviews[page - 1].isHidden = false
        addview.isHidden = false
        page -= 1
        pageTitle.text = selectedEvents![page]
    }
    
    
    @IBAction func skipButton(_ sender: Any) {
        page += 1
        if addview.subviews.count - 1 >= page {
            addview.isHidden = true
            addview.subviews[page - 1].isHidden = true
            addview.subviews[page].isHidden = false
            pageTitle.text = selectedEvents![page]
            addview.isHidden = false
            return
        }
        if page == selectedEvents!.count {
            saveToCoreData()
            UserDefaults.standard.set(true, forKey: "finishedReg")
            performSegue(withIdentifier:"showMatches", sender: self)
            return
        }
        
        let currEvent = selectedEvents![page]
        let currView = Bundle.main.loadNibNamed("addEvents", owner: self, options: nil)?.first as? addEvents
        
        addview.isHidden = true
        addview.subviews[page - 1].isHidden = true
        pageTitle.text = currEvent
        setupView(currView!, currEvent)
        viewArr.append(currView!)
        
        
        addview.addSubview(currView!)
        addview.isHidden = false
    }
    
    
    @IBAction func frontButton(_ sender: Any) {
        let subView = addview.subviews[page] as! addEvents
        if subView.markLabel.text == initVal || subView.markLabel.text == "0:00" || subView.markLabel.text == "0.0" {
            return
        }
        subView.labelToSlider()
        page += 1
        if addview.subviews.count - 1 >= page {
            let eventLeaving = selectedEvents![page - 1]
            let viewLeaving = addview.subviews[page - 1] as! addEvents
            let currVal = viewLeaving.slider.value
            eventDict[eventLeaving] = currVal
            print(eventDict)
            
            addview.isHidden = true
            addview.subviews[page - 1].isHidden = true
            addview.subviews[page].isHidden = false
            
            
            pageTitle.text = selectedEvents![page]
            addview.isHidden = false
            return
        }
        
        let eventLeaving = selectedEvents![page - 1]
        let viewLeaving = addview.subviews[page - 1] as! addEvents
        let currVal = viewLeaving.slider.value
        eventDict[eventLeaving] = currVal
        
        if page == selectedEvents!.count {
            saveToCoreData()
            UserDefaults.standard.set(true, forKey: "finishedReg")
            performSegue(withIdentifier:"showMatches", sender: self)
            return
        }

        
        let currEvent = selectedEvents![page]
        let currView = Bundle.main.loadNibNamed("addEvents", owner: self, options: nil)?.first as? addEvents
        
        addview.isHidden = true
        addview.subviews[page - 1].isHidden = true
        pageTitle.text = currEvent
        setupView(currView!, currEvent)
        viewArr.append(currView!)
        
        
        addview.addSubview(currView!)
        addview.isHidden = false
    }
    
    
    func saveToCoreData() {
        var u = user
        user.saveEventGroup(eventGroup!)
        user.saveName(name)
        print(gender!)
        user.saveGender(gender!)
        print(gender!)
        for (topic, val) in eventDict {
            let key = valKeyDict[topic]!
            if doubleEvents.contains(key) {
                user.saveDoubleEvent(key, Double(val).truncate(places: 2))
            } else if intEvents.contains(key) {
                user.saveIntEvent(key, Int(val))
            }
            if !academicArr.contains(topic) {
                if !user.currEvents.contains(topic) {
                    user.currEvents.append(topic)
                    //user.saveCurrEvents(user.currEvents)
                }
            }
            if !user.statArr.contains(topic) {
                user.statArr.append(topic)
                //user.saveCurrStats(user.statArr)
            } else {
                print(user.statArr)
            }
        }
        print(user.statArr)
        user.saveCurrEvents(user.currEvents)
        user.saveCurrStats(user.statArr)
        user.populateUserAtLaunch()
        u = user
        print("hello")
    }
    
    func setupView(_ view: addEvents, _ stat: String) {
        if stat == "SAT" || stat == "ACT" {
            skipButton.isHidden = false
        }
         let minMaxArr = statSettings[stat]
        view.slider.maximumValue = Float(minMaxArr![1])
        view.slider.minimumValue = Float(minMaxArr![0])
        view.stat = stat
        view.markLabel.textColor = .black
        view.markLabel.becomeFirstResponder()
        switch stat {
                case "SAT":
                    initVal = String(user.sat)
                    view.markLabel.text = String(user.sat)
                    view.slider.value = Float(user.sat)
                case "ACT":
                    initVal = String(user.act)
                    view.markLabel.text = String(user.act)
                    view.slider.value = Float(user.act)
                case "3200M":
                    initVal = User.secsToString(user.twoMile)
                    view.markLabel.text = User.secsToString(user.twoMile)
                    view.slider.value = Float(user.twoMile)
                case "GPA":
                    initVal = String(user.gpa)
                    view.markLabel.text = String(user.gpa)
                    view.slider.value = Float(user.gpa)
                case "100M":
                    initVal = User.doubleToString(user.onehundredm)
                    view.markLabel.text = User.doubleToString(user.onehundredm)
                    view.slider.value = Float(user.onehundredm)
                case "200M":
                    initVal = User.doubleToString(user.twohundredm)
                    view.markLabel.text = User.doubleToString(user.twohundredm)
                    view.slider.value = Float(user.twohundredm)
                case "400M":
                    initVal = User.doubleToString(user.fourhundredm)
                    view.markLabel.text = User.doubleToString(user.fourhundredm)
                    view.slider.value = Float(user.fourhundredm)
                case "800M":
                    initVal = User.doubleToString(user.eighthundredm)
                    view.markLabel.text = User.doubleToString(user.eighthundredm)
                    view.slider.value = Float(user.eighthundredm)
                case "1600M":
                    initVal = User.secsToString(user.mile)
                    view.markLabel.text = User.secsToString(user.mile)
                    view.slider.value = Float(user.mile)
                case "Shotput":
                    initVal = User.ftToString(user.shotput)
                    view.markLabel.text = User.ftToString(user.shotput)
                    view.slider.value = Float(user.shotput)
                case "Discus":
                    initVal = User.ftToString(user.discus)
                    view.markLabel.text = User.ftToString(user.discus)
                    view.slider.value = Float(user.discus)
                case "Long Jump":
                    initVal = User.ftToString(user.longJump)
                    view.markLabel.text = User.ftToString(user.longJump)
                    view.slider.value = Float(user.longJump)
                case "High Jump":
                    initVal = User.ftToString(user.highJump)
                    view.markLabel.text = User.ftToString(user.highJump)
                    view.slider.value = Float(user.highJump)
                case "Triple Jump":
                    initVal = User.ftToString(user.tripleJump)
                    view.markLabel.text = User.ftToString(user.tripleJump)
                    view.slider.value = Float(user.tripleJump)
                case "110M Hurdles":
                    initVal = User.doubleToString(user.onetenHurdles)
                    view.markLabel.text = User.doubleToString(user.onetenHurdles)
                    view.slider.value = Float(user.onetenHurdles)
                case "300M Hurdles":
                    initVal = User.doubleToString(user.threehundredHurdles)
                    view.markLabel.text = User.doubleToString(user.threehundredHurdles)
                    view.slider.value = Float(user.threehundredHurdles)
                case "Pole Vault":
                    initVal = User.ftToString(user.poleVault)
                    view.markLabel.text = User.ftToString(user.poleVault)
                    view.slider.value = Float(user.poleVault)
                default:
                    print("whoops")
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
