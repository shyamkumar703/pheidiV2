//
//  profileViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/14/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import MKRingProgressView

class profileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        uniList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = uniCollection.dequeueReusableCell(withReuseIdentifier: "uniCell", for: indexPath) as? uniCollectionViewCell {
            let currUni = uniList[indexPath.item]
            
            cell.name.text = currUni.name
            cell.focusString.text = currUni.focus
            cell.focusImage.image = UIImage(named: currUni.focus)
            cell.sat.text = String(currUni.sat)
            cell.gpa.text = currUni.gpa
            cell.act.text = String(currUni.act)
            cell.match.text = currUni.match
            
            cell.contentView.layer.cornerRadius = 18
            return cell
        }
        return UICollectionViewCell()
    }
    


    @IBOutlet weak var athleticButton: UIButton!
    @IBOutlet weak var academicButton: UIButton!
    @IBOutlet weak var overviewButton: UIButton!
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var gradientBackground: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var uniCollection: UICollectionView!
    let featureView2 = Bundle.main.loadNibNamed("profileOverview", owner: self, options: nil)?.first as? profileOverview
    
    let academicView = Bundle.main.loadNibNamed("profileAcademic", owner: self, options: nil)?.first as? profileAcademic
    
    let athleticView = Bundle.main.loadNibNamed("marksPageView", owner: self, options: nil)?.first as? marksPageView
    
    
    
    
    let gpa = user.gpa.truncate(places: 2)
    let mins = 9
    let secs = 32
    let floatSAT = Float(1480)
    let floatACT = Float(21)
    let stringSAT = String(1480)
    let stringACT = String(21)
    var selectedButton: UIButton? = nil
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pheidiColors.addGradientToView(view: gradientBackground)
        uniCollection.delegate = self
        uniCollection.dataSource = self
        
        profileView.addSubview(featureView2!)
        selectedButton = overviewButton
        
//        academicView!.initView(stringSAT, stringACT)
//
//        profileView.addSubview(academicView!)
        
        
//        if let featureView2 = Bundle.main.loadNibNamed("profileOverview", owner: self, options: nil)?.first as? profileOverview {
//            profileView.addSubview(featureView2)
//        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let prog = gpa / 4.0
//        featureView2?.animateProgress(prog)
//        academicView!.animateSAT(floatSAT)
//        academicView!.animateACT(floatACT)
        
    }
    
    @IBAction func overviewPressed(_ sender: Any) {
        if selectedButton == overviewButton {
            return
        }
        overviewButton.setTitleColor(UIColor.white, for: .normal)
        selectedButton!.setTitleColor(pheidiColors.pheidiGray, for: .normal)
        selectedButton = overviewButton
        profileView.isHidden = true
        for view in self.profileView.subviews {
            view.removeFromSuperview()
        }
        profileView.addSubview(featureView2!)
        profileView.isHidden = false
    }
    
    @IBAction func academicsPressed(_ sender: Any) {
        if selectedButton == academicButton {
            return
        }
        academicButton.setTitleColor(UIColor.white, for: .normal)
        selectedButton!.setTitleColor(pheidiColors.pheidiGray, for: .normal)
        selectedButton = academicButton
        UIView.animate(withDuration: 0.5, animations: {
            self.profileView.isHidden = true
            self.collectionTitle.isHidden = true
            self.uniCollection.isHidden = true
            
            for view in self.profileView.subviews {
                view.removeFromSuperview()
            }
            
            self.academicView!.initView(self.stringSAT, self.stringACT)
            self.academicView!.gpa.text = String(self.gpa)
            self.profileView.addSubview(self.academicView!)
            self.collectionTitle.text = "Academic Matches"
            self.uniCollection.reloadData()
            self.profileView.isHidden = false
            self.collectionTitle.isHidden = false
            self.uniCollection.isHidden = false
            
        }, completion: { fin in
            self.academicView!.animateSAT(self.floatSAT)
            self.academicView!.animateACT(self.floatACT)
            let prog = self.gpa / 4.0
            self.academicView!.animateProgress(prog)
        })
    }
    
    @IBAction func athleticsPressed(_ sender: Any) {
        if selectedButton == athleticButton {
            return
        }
        athleticButton.setTitleColor(UIColor.white, for: .normal)
        selectedButton!.setTitleColor(pheidiColors.pheidiGray, for: .normal)
        selectedButton = athleticButton
        profileView.isHidden = true
        for view in self.profileView.subviews {
            view.removeFromSuperview()
        }
        athleticView!.setup(["3200":"9:32", "1600":"4:32", "800":"2:00", "400":"55"])
        profileView.addSubview(athleticView!)
        self.collectionTitle.text = "Athletic Matches"
        profileView.isHidden = false
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
