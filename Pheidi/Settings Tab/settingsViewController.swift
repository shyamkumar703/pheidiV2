//
//  settingsViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/21/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import StatusAlert

class settingsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //settingsArr.count
        user.statArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = settingsCollectionView.dequeueReusableCell(withReuseIdentifier: "setting", for: indexPath) as? settingsCollectionViewCell {
            let cellView = Bundle.main.loadNibNamed("settingsCard", owner: self, options: nil)?.first as? settingsCard
//            cellView!.initView(settingsArr[indexPath.item])
//            cellView!.topic.text = settingsArr[indexPath.item]
            cellView!.initView(user.statArr[indexPath.item])
            cellView!.topic.text = user.statArr[indexPath.item]
            if editMode == true  {
                let x = user.statArr[indexPath.item]
                if user.statArr[indexPath.item] == "GPA" {
                    cellView?.minusButton.isHidden = true
                } else {
                    cellView?.minusButton.isHidden = false
                }
            }
            cell.view.addSubview(cellView!)
            cellViews.append(cellView!)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if editMode == false {
            let setting = settingsArr[indexPath.item]
            selected = setting
//            switch setting {
//            case "GPA":
//                selectedStat = String(user.gpa)
//            case "SAT":
//                selectedStat = String(user.sat)
//            case "ACT":
//                selectedStat = String(user.act)
//            case "3200M":
//                selectedStat = User.secsToString(user.twoMile)
//            default:
//                print("whoops")
//            }
            
            switch selected {
            case "GPA":
                key = "gpa"
                selectedStat = String(user.gpa)
            case "SAT":
                key = "sat"
                selectedStat = String(user.gpa)
            case "ACT":
                key = "act"
                selectedStat = String(user.act)
            case "100M":
                key = "onehundredm"
                selectedStat = User.doubleToString(user.onehundredm)
            case "200M":
                key = "twohundredm"
                selectedStat = User.doubleToString(user.twohundredm)
            case "400M":
                key = "fourhundredm"
                selectedStat = User.doubleToString(user.onehundredm)
            case "800M":
                key = "eighthundredm"
                selectedStat = User.doubleToString(user.eighthundredm)
            case "1600M":
                key = "mile"
                selectedStat = User.secsToString(user.mile)
            case "3200M":
                key = "twoMile"
                selectedStat = User.secsToString(user.twoMile)
            case "Shotput":
                key = "shotput"
                selectedStat = User.ftToString(user.shotput)
            case "Discus":
                key = "discus"
                selectedStat = User.ftToString(user.discus)
            case "High Jump":
                key = "highJump"
                selectedStat = User.ftToString(user.highJump)
            case "Long Jump":
                key = "longJump"
                selectedStat = User.ftToString(user.longJump)
            case "Triple Jump":
                key = "tripleJump"
                selectedStat = User.ftToString(user.tripleJump)
            case "Pole Vault":
                key = "poleVault"
                selectedStat = User.ftToString(user.poleVault)
            case "110M Hurdles":
                key = "onetenHurdles"
                selectedStat = User.doubleToString(user.onetenHurdles)
            case "300M Hurdles":
                key = "threehundredHurdles"
                selectedStat = User.doubleToString(user.threehundredHurdles)
            default:
                print("whoops")
            }
            
            
            performSegue(withIdentifier: "edit", sender: self)
        } else {
            print(user.currEvents)
            let removeSetting = settingsArr[indexPath.item]
            
            if removeSetting == "GPA" {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
                
                let statusAlert = StatusAlert()
                statusAlert.title = "Error"
                statusAlert.message = "GPA cannot be removed"
                statusAlert.image = UIImage(named: "delete")
                statusAlert.appearance.blurStyle = .dark
                statusAlert.showInKeyWindow()
                return
                
            } else if removeSetting != "ACT" && removeSetting != "SAT" && user.currEvents.count <= 1 {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
                
                let statusAlert = StatusAlert()
                statusAlert.title = "Error"
                statusAlert.message = "Your only event cannot be removed"
                statusAlert.image = UIImage(named: "delete")
                statusAlert.appearance.blurStyle = .dark
                statusAlert.showInKeyWindow()
                return
            }
            
            user.currEvents = user.currEvents.filter { $0 != removeSetting }
            user.saveCurrEvents(user.currEvents)
            print(user.currEvents)
            settingsArr.remove(at: indexPath.item)
            user.saveCurrStats(settingsArr)
            settingsCollectionView.deleteItems(at: [indexPath])
            NotificationCenter.default.post(name: Notification.Name("Reload Requested"), object: nil, userInfo: nil)
        }
        
    }
    
    @IBOutlet weak var settingsCollectionView: UICollectionView!
    var settingsArr: [String] = []
    var selected: String? = nil
    var selectedStat: String? = nil
    var cellViews: [settingsCard] = []
    var editMode = false
    var key: String = ""
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsArr = user.statArr
        settingsCollectionView.dataSource = self
        settingsCollectionView.delegate = self
        doneButton.layer.cornerRadius = 8
        doneButton.layer.borderWidth = 1.0
        doneButton.layer.borderColor = pheidiColors.pheidiTeal.cgColor
        doneButton.isHidden = true
        self.tabBarController?.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.delegate = self
        settingsArr = user.statArr
        settingsCollectionView.reloadData()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 4 {
            settingsCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            let controller = segue.destination as! editStatsViewController
            controller.stat = selected!
            if selectedStat != nil {
                controller.initVal = selectedStat!
            }
            controller.key = key
        }
    }
    
    @IBAction func toggleEditMode(_ sender: Any) {
//        editMode = !editMode
//        if editMode == true {
//            for cell in cellViews {
//                cell.minusButton.isHidden = false
//            }
//        } else {
//            for cell in cellViews {
//            cell.minusButton.isHidden = true
//            }
//        }
        editMode = true
        minusButton.isHidden = true
        plusButton.isHidden = true
        doneButton.isHidden = false
        for cell in cellViews {
            if cell.topic.text == "GPA" {
                cell.minusButton.isHidden = true
            } else if user.currEvents.count <= 1 && cell.topic.text != "SAT" && cell.topic.text != "ACT" {
               cell.minusButton.isHidden = true
            } else {
                cell.minusButton.isHidden = false
            }
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        editMode = false
        plusButton.isHidden = false
        minusButton.isHidden = false
        doneButton.isHidden = true
        for cell in cellViews {
            cell.minusButton.isHidden = true
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
