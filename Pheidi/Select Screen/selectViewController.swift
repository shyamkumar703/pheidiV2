//
//  selectViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/18/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class selectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let eventGroups = ["Distances", "Sprints", "Jumps", "Throws"]
    
    let distanceEvents = ["800M", "1600M", "3200M"]
    
    let sprintEvents = ["100M", "200M", "400M", "110M Hurdles", "300M Hurdles"]
    
    let jumpEvents = ["High Jump", "Long Jump", "Triple Jump"]
    
    let throwEvents = ["Shotput", "Discus"]
    
    var buttons: [RadioButton] = []
    
    var count = 0
    
    var page = 0
    
    var collectionData: [String] = []
    
    var selectedGroup: String = ""
    var selectedEvents: [String] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = selectCollectionView.dequeueReusableCell(withReuseIdentifier: "select", for: indexPath) as? selectCollectionViewCell {
            cell.group.setTitle(collectionData[indexPath.item], for: .normal)
            cell.group.tag = count
            count += 1
//            cell.group.alternateButton = buttons
//            for b in buttons {
//                b.alternateButton?.append(cell.group)
//            }
            cell.group.isSelected = false
            if page == 0 && selectedGroup != "" {
                if collectionData[indexPath.item] == selectedGroup {
                    cell.group.isSelected = true
                }
            } else {
                cell.group.isSelected = false
            }
            buttons.append(cell.group)
            return cell
        }
        return UICollectionViewCell()
    }
    
    @IBOutlet weak var selectCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var frontButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCollectionView.delegate = self
        selectCollectionView.dataSource = self
        collectionData = eventGroups
        backButton.isHidden = true
        frontButton.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectedGroup(_ sender: Any) {
        if page == 0 {
            if let but = sender as? RadioButton {
                let group = collectionData[but.tag]
                oneToTwo(group)
            }
        } else {
            if let but = sender as? RadioButton {
                let event = collectionData[but.tag]
                if !(selectedEvents.contains(event)) {
                    selectedEvents.append(event)
                } else {
                    selectedEvents = selectedEvents.filter{$0 != event}
                }
                if selectedEvents.count != 0 {
                    frontButton.isEnabled = true
                } else {
                    frontButton.isEnabled = false
                }
            }
        }
    }
    

    
    func oneToTwo(_ group: String) {
        
        switch group {
        case "Distances":
            collectionData = distanceEvents
            selectedGroup = "Distances"
        case "Sprints":
            collectionData = sprintEvents
            selectedGroup = "Sprints"
        case "Jumps":
            collectionData = jumpEvents
            selectedGroup = "Jumps"
        case "Throws":
            collectionData = throwEvents
            selectedGroup = "Throws"
        default:
            print("whoops")
        }
        
        count = 0
        page = 1
        buttons = []
        
        UIView.animate(withDuration: 0.5, animations: {
            self.titleLabel.isHidden = true
            self.selectCollectionView.isHidden = true
            self.selectCollectionView.layoutSubviews()
            self.titleLabel.text = "Select your events"
        }, completion: { fin in
            UIView.animate(withDuration: 0.5, animations: {
                self.titleLabel.isHidden = false
                self.selectCollectionView.isHidden = false
                self.selectCollectionView.reloadData()
                self.selectCollectionView.layoutSubviews()
                self.backButton.isHidden = false
                self.frontButton.isHidden = false
                self.frontButton.isEnabled = false
            })
        })
    }
    
    func twoToOne() {
        collectionData = eventGroups
        count = 0
        page = 0
        buttons = []
        UIView.animate(withDuration: 0.5, animations: {
            self.titleLabel.isHidden = true
            self.selectCollectionView.isHidden = true
            self.selectCollectionView.layoutSubviews()
            self.titleLabel.text = "Select event group"
        }, completion: { fin in
            UIView.animate(withDuration: 0.5, animations: {
                self.titleLabel.isHidden = false
                self.selectCollectionView.isHidden = false
                self.selectCollectionView.reloadData()
                self.selectCollectionView.layoutSubviews()
                self.backButton.isHidden = true
            })
        })
    }
    
    @IBAction func backPressed(_ sender: Any) {
        twoToOne()
    }
    
    @IBAction func frontButtonPressed(_ sender: Any) {
//        UIView.animate(withDuration: 0.5, animations: {
//            self.titleLabel.isHidden = true
//            self.selectCollectionView.isHidden = true
//            self.selectCollectionView.layoutSubviews()
//        }, completion: { fin in
//            //self.performSegue(withIdentifier: "inputTimes", sender: self)
//        })
        self.performSegue(withIdentifier: "inputTimes", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "inputTimes" {
//            let controller = segue.destination as! inputViewController
//            controller.events = selectedEvents
//        }
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
