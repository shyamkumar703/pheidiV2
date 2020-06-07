//
//  starredSchoolsViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/21/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import StatusAlert

class starredSchoolsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if srcArr.count == 0 {
            starredCollectionView.isHidden = true
            emptyStateView.isHidden = false
        } else {
            starredCollectionView.isHidden = false
            emptyStateView.isHidden = true
        }
        return srcArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = starredCollectionView.dequeueReusableCell(withReuseIdentifier: "starred", for: indexPath) as? starredUniversityCollectionViewCell {
//            let currUni = uniList[indexPath.item]
//            let cellView = Bundle.main.loadNibNamed("starredSchool", owner: self, options: nil)?.first as? starredSchool
//            cellView!.initView(indexPath.item, currUni.name)
            for subview in cell.view.subviews {
                subview.removeFromSuperview()
            }
            cell.view.addSubview(viewsArr[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var starredCollectionView: UICollectionView!
    var viewsArr: [starredSchool] = []
    var tappedUni: University? = nil
    var srcArr: [University] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        srcArr = user.starredKeyToUni()
        createViewArray()
        starredCollectionView.delegate = self
        starredCollectionView.dataSource = self
        self.tabBarController?.delegate = self
        
        let emptyView = Bundle.main.loadNibNamed("emptyStarred", owner: self, options: nil)?.first as? emptyStarred
        emptyStateView.addSubview(emptyView!)
        emptyStateView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveDeleteRequest(_:)), name: Notification.Name("Cell Removed"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveOverviewRequest(_:)), name: Notification.Name("Overview Requested"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveReloadRequest(_:)), name: Notification.Name("Star Pressed"), object: nil)
    }
    
    @objc func onDidReceiveDeleteRequest(_ notification: NSNotification) {
        if let tagDict = notification.userInfo as? [String: Int] {
            let tag = tagDict["tag"]
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            let statusAlert = StatusAlert()
            statusAlert.title = "Unstarred"
            statusAlert.message = String(srcArr[tag!].name) + " has been unstarred"
            statusAlert.image = UIImage(named: "delete")
            statusAlert.appearance.blurStyle = .dark
            statusAlert.showInKeyWindow()
            
            srcArr.remove(at: tag!)
            
            var newStarred: [String] = []
            for uni in srcArr{
                newStarred.append(uni.key)
            }
            user.saveStarredArr(newStarred)
            
            viewsArr.remove(at: tag!)
            starredCollectionView.deleteItems(at: [IndexPath(item: tag!, section: 0)])
            updateViewTags()
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 3 {
            starredCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
    }
    
    @objc func onDidReceiveOverviewRequest(_ notification: NSNotification) {
        if let tagDict = notification.userInfo as? [String: Int] {
            let tag = tagDict["tag"]
            let currUni = srcArr[tag!]
            tappedUni = currUni
            performSegue(withIdentifier: "showOverview", sender: self)
        }
    }
    
    @objc func onDidReceiveReloadRequest(_ notification: NSNotification) {
        srcArr = user.starredKeyToUni()
        starredCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOverview" {
            let controller = segue.destination as! uniDetailViewController
            controller.currUni = tappedUni!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.delegate = self
        viewsArr = []
        if user.gender == "Male" {
            University.loadMatchesMale()
        } else {
            University.loadMatchesFemale()
        }
        srcArr = user.starredKeyToUni()
        createViewArray()
        starredCollectionView.reloadData()
    }
    
    func createViewArray() {
        var i = 0
        for uni in srcArr {
            let cellView = Bundle.main.loadNibNamed("starredSchool", owner: self, options: nil)?.first as? starredSchool
            cellView!.initView(i, uni)
            viewsArr.append(cellView!)
            i += 1
        }
    }
    
    func updateViewTags() {
        var i = 0
        for view in viewsArr {
            view.initView(i, srcArr[i])
            i += 1
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
