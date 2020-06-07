//
//  addSettingViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/22/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class addSettingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return possibleSettings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = addSettingCollectionView.dequeueReusableCell(withReuseIdentifier: "add", for: indexPath) as? addSettingCollectionViewCell {
            let cellView = Bundle.main.loadNibNamed("addSetting", owner: self, options: nil)?.first as? addSetting
            let currTopic = possibleSettings[indexPath.item]
            cellView!.initView(currTopic)
            cell.view.addSubview(cellView!)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = possibleSettings[indexPath.item]
        selectedStat = "0"
        switch selected {
        case "GPA":
            key = "gpa"
        case "SAT":
            key = "sat"
        case "ACT":
            key = "act"
        case "100M":
            key = "onehundredm"
        case "200M":
            key = "twohundredm"
        case "400M":
            key = "fourhundredm"
        case "800M":
            key = "eighthundredm"
        case "1600M":
            key = "mile"
        case "3200M":
            key = "twoMile"
        case "Shotput":
            key = "shotput"
        case "Discus":
            key = "discus"
        case "High Jump":
            key = "highJump"
        case "Long Jump":
            key = "longJump"
        case "Triple Jump":
            key = "tripleJump"
        case "Pole Vault":
            key = "poleVault"
        case "110M Hurdles":
            key = "onetenHurdles"
        case "300M Hurdles":
            key = "threehundredHurdles"
        default:
            print("whoops")
        }
        
        performSegue(withIdentifier: "addStat", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addStat" {
            let controller = segue.destination as! editStatsViewController
            controller.stat = selected!
            if selectedStat != nil {
                controller.initVal = selectedStat!
            }
            controller.fromAdd = true
            controller.key = key
        }
    }
    
    var possibleSettings = ["GPA", "SAT", "ACT", "100M", "200M", "400M", "800M", "1600M", "3200M", "Shotput", "Discus", "High Jump", "Long Jump", "Triple Jump", "Pole Vault"]
    
    var selected: String? = nil
    var selectedStat: String? = nil
    var key: String = ""

    @IBOutlet weak var addSettingCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        reducePossibleSettings()
        addSettingCollectionView.delegate = self
        addSettingCollectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reducePossibleSettings()
        addSettingCollectionView.reloadData()
    }
    
    func reducePossibleSettings() {
        let currSettings = user.statArr
        var i = 0
        for set in currSettings {
            possibleSettings = possibleSettings.filter { $0 != set }
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
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
