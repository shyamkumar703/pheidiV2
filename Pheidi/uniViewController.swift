//
//  uniViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/12/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import MKRingProgressView
import LinearProgressView
import iOSDropDown

class uniViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        uniList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = rankingCollectionView.dequeueReusableCell(withReuseIdentifier: "uniRanking", for: indexPath) as? rankingCollectionViewCell {
            let currUni = uniList[indexPath.item]
            cell.name.text = currUni.name
            cell.gpa.text = currUni.gpa
            cell.act.text = String(currUni.act)
            cell.sat.text = String(currUni.sat)
            cell.match.text = currUni.match
            cell.focusImage.image = UIImage(named: currUni.focus)
            let currRanking = "#" + String(indexPath.item + 1)
            cell.ranking.text = currRanking
            
            //cell.contentView.layer.cornerRadius = 18
            
            cell.focusImage.layer.cornerRadius = 18
            
            if indexPath.item == 0 {
                pheidiColors.addGradientToView(view: cell.gradientView)
                cell.ranking.textColor = UIColor.black
                cell.contentView.sendSubviewToBack(cell.gradientView)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    var currUni: University?
    @IBOutlet weak var uniName: UILabel!
    @IBOutlet weak var uniMatchLevel: UILabel!
    @IBOutlet weak var progressRing: RingProgressView!
    @IBOutlet weak var focusImage: UIImageView!
    @IBOutlet weak var progressView: LinearProgressView!
    @IBOutlet weak var rankingCollectionView: UICollectionView!
    @IBOutlet weak var regionRankingView: UIView!
    @IBOutlet weak var overviewView: UIView!
    var selected: String?
    @IBOutlet weak var overviewButton: UIButton!
    @IBOutlet weak var regionButton: UIButton!
    @IBOutlet weak var conferenceButton: UIButton!
    @IBOutlet weak var rankingDropdown: DropDown!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        uniName.text = currUni!.name
        uniMatchLevel.text = currUni!.match
        focusImage.image = UIImage(named: currUni!.focus)
        let alphaColor = pheidiColors.pheidiTeal.withAlphaComponent(0.15)
        progressView.barColor = alphaColor
        progressView.trackColor = pheidiColors.pheidiTeal
        rankingCollectionView.delegate = self
        rankingCollectionView.dataSource = self
        rankingDropdown.optionArray = ["Distance", "Sprints", "Throws", "Jumps"]
        selected = "overview"
        regionRankingView.isHidden = true
        overviewView.isHidden = false
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let progress = Double(currUni!.match.replacingOccurrences(of: "%", with: ""))! / 100.0
        progressRing.progress = 0.0
        UIView.animate(withDuration: 1.0) {
            self.progressRing.progress = progress
        }
        self.progressView.setProgress(55.0, animated: true)
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated:true)
    }
    
    @IBAction func regionPressed(_ sender: Any) {
        selected = "region"
        UIView.animate(withDuration: 0.5) {
            self.overviewView.isHidden = true
            self.regionRankingView.isHidden = false
            self.regionButton.setTitleColor(UIColor.white, for: .normal)
            self.overviewButton.setTitleColor(pheidiColors.pheidiGray, for: .normal)
        }
    }
    
    @IBAction func overviewPressed(_ sender: Any) {
        if selected! != "overview" {
            UIView.animate(withDuration: 0.5) {
                self.regionRankingView.isHidden = true
                self.overviewView.isHidden = false
                self.overviewButton.setTitleColor(UIColor.white, for: .normal)
                self.regionButton.setTitleColor(pheidiColors.pheidiGray, for: .normal)
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
