//
//  profileViewController.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/23/20.
//

import UIKit

class profileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "profileList", for: indexPath) as? profileTableViewCell {
            cell.school.text = schools[indexPath.row % 5]
            
            cell.matchLabel.layer.cornerRadius = 5
            cell.matchLabel.layer.masksToBounds = true
            
            cell.view.layer.cornerRadius = 10
            
            let randomInt = Int.random(in: 0..<3)
            
            switch randomInt {
            case 0:
                cell.matchLabel.backgroundColor = Colors.greenOpaq
                cell.matchLabel.textColor = Colors.green
            case 1:
                cell.matchLabel.backgroundColor = Colors.yellowOpaq
                cell.matchLabel.textColor = Colors.yellow
            default:
                cell.matchLabel.backgroundColor = Colors.redOpaq
                cell.matchLabel.textColor = Colors.red
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        profileViewController.buttonPress(cell!) {
            self.performSegue(withIdentifier: "showInfo", sender: self)
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
    }
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var myList: UILabel!
    @IBOutlet weak var contacted: UILabel!
    
    var myListSelected = true
    
    
    
    
    var schools = ["University of California, Berkeley", "Stanford University", "Harvard University", "Princeton University", "University of Oregon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileButton.layer.cornerRadius = 20
        profileButton.backgroundColor = Colors.blueVeryOpaq
        
        editProfileButton.layer.cornerRadius = 15
        editProfileButton.backgroundColor = Colors.blueVeryOpaq
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        generateTapRecognizers()
    }
    
    func generateTapRecognizers() {
        myList.isUserInteractionEnabled = true
        contacted.isUserInteractionEnabled = true
        
        let myListTap = UITapGestureRecognizer(target:self,action:#selector(self.myListTapped))
        
        myList.addGestureRecognizer(myListTap)
        
        let contactTap = UITapGestureRecognizer(target:self,action:#selector(self.contactedTapped))
        
        contacted.addGestureRecognizer(contactTap)
        
        let myListSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.myListSwipeRight))
        myListSwipe.direction = [.right]
        myList.addGestureRecognizer(myListSwipe)
        
        let contactSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.contactSwipeLeft))
        contactSwipe.direction = [.left]
        contacted.addGestureRecognizer(contactSwipe)
    }
    
    
    @objc func myListSwipeRight(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == UISwipeGestureRecognizer.Direction.right {
            contactedTapped()
        }
    }
    
    @objc func contactSwipeLeft(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == UISwipeGestureRecognizer.Direction.left {
            myListTapped()
        }
    }
    
    @objc func myListTapped() {
        if myListSelected != true {
            myListSelected = true
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.tableView.alpha = 0
                self.myList.textColor = .white
                self.contacted.textColor = Colors.lightGrayOpaq
            }, completion: {_ in
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                    self.tableView.alpha = 1
                })
            })
        }
        
    }
    
    @objc func contactedTapped() {
        if myListSelected == true {
            myListSelected = false
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.tableView.alpha = 0
                self.myList.textColor = Colors.lightGrayOpaq
                self.contacted.textColor = .white
            }, completion: {_ in
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                    self.tableView.alpha = 1
                })
            })
        }
    }
    
    @IBAction func profileButtonTapped(_ sender: Any) {
        profileViewController.buttonPress(profileButton) {
            //ADD LOGIC
            self.performSegue(withIdentifier: "editProfile", sender: self)
        }
    }
    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        profileViewController.buttonPress(editProfileButton) {
            //ADD LOGIC
            self.performSegue(withIdentifier: "editProfile", sender: self)
        }
    }
    
    static func buttonPress(_ view: UIView, completion: ( () -> Void)?) {
        UIView.animate(withDuration: 0.1,
            animations: {
                view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    view.transform = CGAffineTransform.identity
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
                    if completion != nil {
                        completion!()
                    }
                }
            })
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