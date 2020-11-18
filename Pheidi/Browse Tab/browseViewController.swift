//
//  browseViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/14/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class browseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate {
    var currUni: University? = nil
    var currTableTitle: String? = nil
    var srcArray: [University]? = nil
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "browseTableView", for: indexPath) as? browseTableViewCell {
            switch indexPath.item {
            case 0:
                if user.division.contains("Division") {
                    cell.titleLabel.text = "NCAA " + user.division
                } else {
                    cell.titleLabel.text = user.division
                }
                cell.srcArray = recDivisionArr
                cell.collectionView.reloadData()
            case 1:
                cell.titleLabel.text = "Academic Matches"
                cell.srcArray = academicRankings
                cell.collectionView.reloadData()
            case 2:
                if user.eventGroup == "Distance" {
                    cell.titleLabel.text = "Best Distance Schools"
                    cell.srcArray = distanceRankings
                } else if user.eventGroup == "Sprints" {
                    cell.titleLabel.text = "Best Sprints Schools"
                    cell.srcArray = sprintRankings
                } else if user.eventGroup == "Jumps" {
                    cell.titleLabel.text = "Best Jumps Schools"
                    cell.srcArray = jumpsRankings
                } else if user.eventGroup == "Throws" {
                    cell.titleLabel.text = "Best Throws Schools"
                    cell.srcArray = throwsRankings
                }
                cell.collectionView.reloadData()
            case 3:
                cell.titleLabel.text = "Top NCAA Teams"
                cell.srcArray = topFinishersUni
                cell.collectionView.reloadData()
            case 4:
                cell.titleLabel.text = "All Schools"
                cell.srcArray = uniList
                cell.collectionView.reloadData()
            default:
                cell.titleLabel.text = ""
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    @IBOutlet weak var browseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        browseTableView.delegate = self
        browseTableView.dataSource = self
        browseTableView.allowsSelection = false
        University.createDistanceRankings()
        University.createSprintRankings()
        University.createAcademicRankings()
        University.createJumpRankings()
        University.createThrowsRankings()
        University.createTopFinishersArr()
        self.tabBarController?.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveSegueRequest(_:)), name: Notification.Name("See All Pressed"), object: nil)
        //navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), landscapeImagePhone: nil, style: .plain, target: nil, action: nil)

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveProfileRequest(_:)), name: Notification.Name("Profile Requested"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveReloadRequest(_:)), name: Notification.Name("Reload Requested"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func onDidReceiveProfileRequest(_ notification: NSNotification) {
        if let tagDict = notification.userInfo as? [String: University] {
            currUni = tagDict["uni"]
            performSegue(withIdentifier: "toUniProfile", sender: self)
        }
    }
    
    @objc func onDidReceiveSegueRequest(_ notification: NSNotification) {
        if let tagDict = notification.userInfo as? [String: Any] {
            if UserDefaults.standard.bool(forKey: "pro") {
                currTableTitle = tagDict["title"] as? String
                srcArray = tagDict["arr"] as? [University]
                performSegue(withIdentifier: "seeAll", sender: self)
            }
            else {
                //SHOW PHEIDI PRO
                performSegue(withIdentifier: "toFivestar", sender: self)
            }
        }
    }
    
    @objc func onDidReceiveReloadRequest(_ notification: NSNotification) {
        University.createDistanceRankings()
        University.createSprintRankings()
        University.createAcademicRankings()
        University.createTopFinishersArr()
        University.createJumpRankings()
        University.createThrowsRankings()
        browseTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUniProfile" {
            let controller = segue.destination as! uniDetailViewController
            controller.currUni = currUni!
        } else if segue.identifier == "seeAll" {
            let controller = segue.destination as! seeAllTableViewController
            controller.currTableTitle = currTableTitle!
            controller.srcArray = srcArray!
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        browseTableView.flashScrollIndicators()
        self.tabBarController?.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            for row in browseTableView.visibleCells {
                let row = row as! browseTableViewCell
                row.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
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
