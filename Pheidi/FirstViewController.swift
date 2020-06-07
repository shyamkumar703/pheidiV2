//
//  FirstViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/11/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import iOSDropDown

var uniList: [University] = []

var tappedUni: University?



class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var uniCollectionView: UICollectionView!
    @IBOutlet weak var dropdown: DropDown!
    @IBOutlet weak var secondDropdown: DropDown!
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return uniList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = uniCollectionView.dequeueReusableCell(withReuseIdentifier: "uniCell", for: indexPath) as? universityCollectionViewCell {
            let currUni = uniList[indexPath.item]
            let cellView = Bundle.main.loadNibNamed("View", owner: self, options: nil)?.first as? uniCellView
            cellView?.cornerRad()
            cell.view.addSubview(cellView!)
            cell.contentView.layer.cornerRadius = 18
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currIndex = indexPath.item
        tappedUni = uniList[currIndex]
        performSegue(withIdentifier: "moreInfo", sender: self)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        user.populateUserAtLaunch()
        let u = user
        uniCollectionView.delegate = self
        uniCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        dropdown.optionArray = ["NCAA Division 1", "NCAA Division 2",
        "NCAA Division 3", "NAIA"]
        dropdown.selectedIndex = 0
        //dropdown.borderStyle = .line
        dropdown.borderWidth = 1.0
        
        secondDropdown.optionArray = ["Best Matches", "Best Academic Fit", "Best Athletic Fit"]
        secondDropdown.selectedIndex = 0
        //secondDropdown.borderStyle = .line
        secondDropdown.borderWidth = 1.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreInfo" {
            let controller = segue.destination as! uniDetailViewController
            controller.currUni = tappedUni!
        }
    }


}

