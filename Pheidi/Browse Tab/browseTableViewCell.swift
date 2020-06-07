//
//  browseTableViewCell.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/14/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class browseTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    var currUni: University? = nil
    var srcArray: [University]? = nil
    
    func collectionView(_ collectionView: UICollectionView,
           layout collectionViewLayout: UICollectionViewLayout,
           sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 349, height: 143)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if srcArray!.count > 10 {
            return 10
        } else {
            return srcArray!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "browse", for: indexPath) as? browseCollectionViewCell {
            let currUni = srcArray![indexPath.item]
            cell.name.text = currUni.name
            if currUni.lowData {
                cell.focusLabel.text = "Low Data"
                cell.focusString.text = "N/A"
            } else {
                cell.focusLabel.text = currUni.bestEvent
                cell.focusString.text = currUni.generateUniBestString()
            }
            if currUni.sat != 0 {
                cell.sat.text = String(currUni.sat)
            } else {
                cell.sat.text = "N/A"
            }
            if currUni.act != 0 {
                cell.act.text = String(currUni.act)
            } else {
                cell.act.text = "N/A"
            }
            if currUni.gpaVal != 0 {
                cell.gpa.text = String(currUni.gpa)
            } else {
                cell.gpa.text = "N/A"
            }
            cell.match.text = currUni.match + "%"
            let alphaColor = UIColor(red:0.00, green:0.08, blue:0.06, alpha:1.0)
            pheidiColors.addHorizontalGradientColorToView(view: cell.backView, color: alphaColor)
            
            
            cell.contentView.layer.cornerRadius = 18
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currUni = srcArray![indexPath.item]
        NotificationCenter.default.post(name: Notification.Name("Profile Requested"), object: nil, userInfo: ["uni": currUni!])

    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seeAll: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        
        seeAll.layer.borderColor = pheidiColors.pheidiTeal.cgColor
        seeAll.layer.borderWidth = 1.0
        seeAll.layer.cornerRadius = 8.0
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveReloadRequest(_:)), name: Notification.Name("Reload Requested"), object: nil)
        
    }
    
    @objc func onDidReceiveReloadRequest(_ notification: NSNotification) {
        collectionView.reloadData()
    }
    
    @IBAction func seeAllPressed(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("See All Pressed"), object: nil, userInfo: ["title": titleLabel.text!, "arr": srcArray!])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
