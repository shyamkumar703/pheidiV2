//
//  onboardSelectViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/23/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class onboardSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = selectCollectionView.dequeueReusableCell(withReuseIdentifier: "select", for: indexPath) as? onboardSelectCollectionViewCell {
            cell.button.setTitle(dataSource[indexPath.item], for: .normal)
            if page != 2 {
                cell.button.alternateButton = buttonArr
            } else {
                cell.button.alternateButton = nil
            }
            if dataSource[indexPath.item] == gender || dataSource[indexPath.item] == eventGroup || eventsSelected.contains(dataSource[indexPath.item]) {
                cell.button.isSelected = true
            } else {
                cell.button.isSelected = false
            }
            cell.button.tag = indexPath.item
            if page != 2 {
                for button in buttonArr {
                    button.alternateButton!.append(cell.button)
                }
            }
            buttonArr.append(cell.button)
            return cell
        }
        return UICollectionViewCell()
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var frontButton: UIButton!
    @IBOutlet weak var selectCollectionView: UICollectionView!
    var name: String = ""
    
    var buttonArr: [RadioButton] = []
    
    var dataSource: [String] = []
    
    var genderArr = ["Male", "Female"]
    var eventGroupArr = ["Distance", "Sprints", "Throws", "Jumps"]
    var distanceEvents = ["800M", "1600M", "3200M"]
    var sprintEvents = ["100M", "200M", "400M"]
    var jumpEvents = ["Long Jump", "High Jump", "Triple Jump", "Pole Vault"]
    var throwEvents = ["Shotput", "Discus"]
    
    var page = 0
    var gender = ""
    var eventGroup = ""
    var eventsSelected: [String] = []
    var currSelectedTag: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.createData()
        UserDefaults.standard.set(false, forKey: "finishedReg")
        selectCollectionView.delegate = self
        selectCollectionView.dataSource = self
        backButton.isHidden = false
        frontButton.isHidden = true
        titleLabel.text = "Select Gender"
        dataSource = genderArr

        // Do any additional setup after loading the view.
    }
    
    func isButtonSelected() -> Bool {
        for button in buttonArr {
            if button.isSelected {
                return true
            }
        }
        return false
    }
    
    @IBAction func radioButtonPressed(_ sender: Any) {
        if isButtonSelected() {
            frontButton.isHidden = false
            if let sender = sender as? RadioButton {
                if page != 2 {
                    currSelectedTag = sender.tag
                }
            }
        } else {
            frontButton.isHidden = true
        }
        if page == 2 {
            if let sender = sender as? RadioButton {
                if sender.isSelected {
                    eventsSelected.append(dataSource[sender.tag])
                } else {
                    print(dataSource[sender.tag])
                    eventsSelected = eventsSelected.filter { $0 != dataSource[sender.tag] }
                    print(eventsSelected)
                }
            }
        }
    }
    
    
    @IBAction func frontButtonPressed(_ sender: Any) {
        page += 1
        if page == 1 {
            let index = currSelectedTag!
            gender = genderArr[index]
            dataSource = eventGroupArr
            titleLabel.text = "Select Event Group"
            buttonArr = []
            UIView.animate(withDuration: 0.5, animations: {
                self.selectCollectionView.isHidden = true
                self.selectCollectionView.reloadData()
                self.selectCollectionView.layoutSubviews()
                self.selectCollectionView.isHidden = false
            })
            backButton.isHidden = false
            if isButtonSelected() {
                frontButton.isHidden = false
            } else {
                frontButton.isHidden = true
            }
        } else if page == 2 {
            let index = currSelectedTag!
            eventGroup = eventGroupArr[index]
            switch eventGroup {
            case "Distance":
                dataSource = distanceEvents
            case "Sprints":
                dataSource = sprintEvents
            case "Jumps":
                dataSource = jumpEvents
            case "Throws":
                dataSource = throwEvents
            default:
                print("whoops")
            }
            buttonArr = []
            titleLabel.text = "Select Events"
            UIView.animate(withDuration: 0.5, animations: {
                self.selectCollectionView.isHidden = true
                self.selectCollectionView.reloadData()
                self.selectCollectionView.layoutSubviews()
                self.selectCollectionView.isHidden = false
            })
            backButton.isHidden = false
            if isButtonSelected() {
                frontButton.isHidden = false
            } else {
                frontButton.isHidden = true
            }
        } else {
            performSegue(withIdentifier: "addEvents", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addEvents" {
            let controller = segue.destination as! addEventsViewController
            controller.gender = gender
            controller.eventGroup = eventGroup
            controller.selectedEvents = eventsSelected
            controller.name = name
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        page -= 1
        if page == -1 {
            performSegue(withIdentifier: "backToName", sender: self)
            return
        }
        if page == 0 {
            dataSource = genderArr
            titleLabel.text = "Select Gender"
            buttonArr = []
            UIView.animate(withDuration: 0.5, animations: {
                self.selectCollectionView.isHidden = true
                self.selectCollectionView.reloadData()
                self.selectCollectionView.layoutSubviews()
                self.selectCollectionView.isHidden = false
            })
            if isButtonSelected() {
                frontButton.isHidden = false
            } else {
                frontButton.isHidden = true
            }
        } else if page == 1 {
            dataSource = eventGroupArr
            titleLabel.text = "Select Event Group"
            eventsSelected = []
            buttonArr = []
            UIView.animate(withDuration: 0.5, animations: {
                self.selectCollectionView.isHidden = true
                self.selectCollectionView.reloadData()
                self.selectCollectionView.layoutSubviews()
                self.selectCollectionView.isHidden = false
            })
            backButton.isHidden = false
            if isButtonSelected() {
                frontButton.isHidden = false
            } else {
                frontButton.isHidden = true
            }
        }
    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        print("Unwind to Root View Controller")
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
