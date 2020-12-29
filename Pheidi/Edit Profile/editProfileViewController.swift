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
    
    let alert = Bundle.main.loadNibNamed("alertView", owner: self, options: nil)?.first as? alertView
    
    var alertPresenting: Bool = false
    
    var heightAnchor: NSLayoutConstraint? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        dismissButton.layer.cornerRadius = 20
        self.hideKeyboardWhenTappedAround()
        setupAlertView()


        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3 {
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 224)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 824)
        }
    }
    
    func setupAlertView() {
        let margins = view.layoutMarginsGuide
//        alert?.setup(false)
        alert!.alpha = 0
        self.view.addSubview(alert!)
        alert?.translatesAutoresizingMaskIntoConstraints = false
        
        alert!.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true
        alert!.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        alert!.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        
        heightAnchor = alert!.heightAnchor.constraint(equalToConstant: 0)
        heightAnchor!.isActive = true
        
        alert!.layer.shadowColor = UIColor.black.cgColor
        alert!.layer.shadowOpacity = 1
        alert!.layer.shadowOffset = .zero
        alert!.layer.shadowRadius = 10
    }
    
    func showAlertView(_ success: Bool, _ message: String) {
        if alertPresenting {
            return
        }
        alertPresenting = true
        alert!.setup(success, message)
        heightAnchor?.constant = 53
        UIView.animate(withDuration: 0.3, animations: {
            self.alert!.alpha = 1
            self.alert!.layoutIfNeeded()
        }, completion: {fin in
            UIView.animate(withDuration: 0.3, delay: 1.3, animations: {
                self.alert!.alpha = 0
                self.alert!.layoutIfNeeded()
            }, completion: {fin in
                self.heightAnchor = self.alert!.heightAnchor.constraint(equalToConstant: 0)
                self.heightAnchor!.isActive = true
                self.alertPresenting = false
            })
        })
    }
    
    
    @IBAction func close(_ sender: Any) {
        print(user.currEvents)
        let athleteEvents = user.statArr.filter {event in
            event != "GPA" && event != "SAT" && event != "ACT"
        }
        if athleteEvents.count == 0 {
            showAlertView(false, "Please enter a mark")
            return
        }
        
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
