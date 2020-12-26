//
//  editProfileViewController.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/23/20.
//

import UIKit

class editProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsCell", for: indexPath) as? settingsCollectionViewCell {
            switch indexPath.row {
            case 0:
                cell.type = .you
                cell.title.text = "YOU"
            case 1:
                cell.type = .academics
                cell.title.text = "ACADEMICS"
            case 2:
                cell.type = .marks
                cell.title.text = "MARKS"
            default:
                cell.type = .more
                cell.title.text = "MORE"
            }
            cell.tableView.reloadData()
            cell.tableView.layer.cornerRadius = 10
            cell.tableView.layer.masksToBounds = true
            return cell
        }
        return UICollectionViewCell()
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dismissButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        dismissButton.layer.cornerRadius = 20
        self.hideKeyboardWhenTappedAround()


        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3 {
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 224)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 764)
        }
    }
    
    
    @IBAction func close(_ sender: Any) {
        profileViewController.buttonPress(dismissButton) {
            self.dismiss(animated: true, completion: nil)
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
