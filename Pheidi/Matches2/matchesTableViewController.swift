//
//  matchesTableViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/24/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding
import BLTNBoard

class matchesTableViewController: UITableViewController, UITabBarControllerDelegate {
    var filteredMatches: [University] = []
    var currUni: University? = nil
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      let searchBarScopeIsFiltering =
        searchController.searchBar.selectedScopeButtonIndex != 0
        if searchBarScopeIsFiltering {
            return true
        }
      return searchController.isActive &&
        (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    lazy var bulletinManager: BLTNItemManager = {
        let rootItem: BLTNPageItem = generateMatchTut()
        return BLTNItemManager(rootItem: rootItem)
    }()
    
    let scopeArray = ["All", "D1", "D2", "D3", "NAIA"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveReloadRequest(_:)), name: Notification.Name("Reload Requested"), object: nil)
        
        self.navigationItem.title = "Matches"
        user.populateUserAtLaunch()
        University.createUniversityList()
        if user.gender == "Female" {
            University.loadMatchesFemale()
        } else {
            University.loadMatchesMale()
        }
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Matches"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = scopeArray

        searchController.searchBar.tintColor = pheidiColors.pheidiTeal
        
        searchController.searchBar.searchTextField.textColor = .white
        
        searchController.searchBar.setScopeBarButtonTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        
        searchController.searchBar.showsScopeBar = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        var isSearchBarEmpty: Bool {
          return searchController.searchBar.text?.isEmpty ?? true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        matchesArr = matchesArr.sorted(by: {
            if Int($0.match) != Int($1.match) {
                return Int($0.match)! < Int($1.match)!
            } else if Int($0.match) == Int($1.match) && Int($0.match) == 100 {
                return Double($0.aheadBy) < Double($1.aheadBy)
            } else {
                return false
            }
        })
        tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func generateMatchTut()  -> BLTNPageItem {
        let page = BLTNPageItem(title: "Match Scores")
        page.appearance.titleTextColor = pheidiColors.pheidiTeal
        page.appearance.titleFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "ProximaNovaA-Bold"])
        page.appearance.descriptionFontDescriptor = UIFontDescriptor(fontAttributes: [.name : "ProximaNovaA-Light"])
        //page.image = UIImage(named: "schoolImage")
        page.descriptionText = "Match scores reflect the probability you will make the team at a specific school."
        page.actionButtonTitle = "NEXT"
        page.alternativeButtonTitle = "SKIP TUTORIAL"
        page.appearance.descriptionTextColor = .white
        page.appearance.actionButtonBorderColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonTitleColor = .black
        
        page.appearance.alternativeButtonTitleColor = pheidiColors.pheidiTeal
        page.next = generateD3Tut()
        
        page.actionHandler = {(item: BLTNActionItem) in
            item.manager?.displayNextItem()
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        
        page.alternativeHandler = {(item: BLTNActionItem) in
            item.manager?.dismissBulletin()
            UserDefaults.standard.set(true, forKey: "tutorial")
        }
        
        return page
    }
    
    func generateD3Tut() -> BLTNPageItem {
        let page = BLTNPageItem(title: "D3 Schools")
        page.descriptionText = "Your match scores at D3 schools is heavily influenced by your academic marks."
        page.appearance.titleTextColor = pheidiColors.pheidiTeal
        page.appearance.titleFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "ProximaNovaA-Bold"])
        page.appearance.descriptionFontDescriptor = UIFontDescriptor(fontAttributes: [.name : "ProximaNovaA-Light"])
        page.actionButtonTitle = "NEXT"
        page.alternativeButtonTitle = "SKIP TUTORIAL"
        page.appearance.descriptionTextColor = .white
        page.appearance.actionButtonBorderColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonTitleColor = .black
        
        page.appearance.alternativeButtonTitleColor = pheidiColors.pheidiTeal
        page.next = generateRecruitLevelTut()
        page.actionHandler = {(item: BLTNActionItem) in
            item.manager?.displayNextItem()
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        page.alternativeHandler = {(item: BLTNActionItem) in
            item.manager?.dismissBulletin()
            UserDefaults.standard.set(true, forKey: "tutorial")
        }
        return page
    }
    
    func generateRecruitLevelTut() -> BLTNPageItem {
        let page = BLTNPageItem(title: "Recruit Level")
        page.descriptionText = "Your recruit level is an estimation of the division you would be the most competitive in."
        page.appearance.titleTextColor = pheidiColors.pheidiTeal
        page.appearance.titleFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "ProximaNovaA-Bold"])
        page.appearance.descriptionFontDescriptor = UIFontDescriptor(fontAttributes: [.name : "ProximaNovaA-Light"])
        page.actionButtonTitle = "NEXT"
        page.alternativeButtonTitle = "SKIP TUTORIAL"
        page.appearance.descriptionTextColor = .white
        page.appearance.actionButtonBorderColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonTitleColor = .black
        
        page.appearance.alternativeButtonTitleColor = pheidiColors.pheidiTeal
        page.next = generateAddStatsTut()
        
        page.actionHandler = {(item: BLTNActionItem) in
            item.manager?.displayNextItem()
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        
        page.alternativeHandler = {(item: BLTNActionItem) in
            item.manager?.dismissBulletin()
            UserDefaults.standard.set(true, forKey: "tutorial")
        }
        
        return page
    }
    
    func generateAddStatsTut() -> BLTNPageItem {
        let page = BLTNPageItem(title: "Add Events")
        page.descriptionText = """
        Use the "+" button in the Edit tab to add events
        """
        page.appearance.titleTextColor = pheidiColors.pheidiTeal
        page.appearance.titleFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "ProximaNovaA-Bold"])
        page.appearance.descriptionFontDescriptor = UIFontDescriptor(fontAttributes: [.name : "ProximaNovaA-Light"])
        page.actionButtonTitle = "GOT IT"
        //page.alternativeButtonTitle = "SKIP TUTORIAL"
        page.appearance.descriptionTextColor = .white
        page.appearance.actionButtonBorderColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonTitleColor = .black
        
        //page.appearance.alternativeButtonTitleColor = pheidiColors.pheidiTeal
        page.actionHandler = {(item: BLTNActionItem) in
            item.manager?.dismissBulletin()
            UserDefaults.standard.set(true, forKey: "tutorial")
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        return page
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "tutorial") == false {
            bulletinManager.backgroundColor = .black
            bulletinManager.backgroundViewStyle = .blurredLight
            bulletinManager.showBulletin(above: self)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
    }
    
    @objc func onDidReceiveReloadRequest(_ notification: NSNotification) {
        matchesArr = []
        if user.gender == "Female" {
            University.loadMatchesFemale()
        } else {
            University.loadMatchesMale()
        }
        matchesArr = matchesArr.sorted(by: {
            if Int($0.match) != Int($1.match) {
                return Int($0.match)! < Int($1.match)!
            } else if Int($0.match) == Int($1.match) && Int($0.match) == 100 {
                return Double($0.aheadBy) < Double($1.aheadBy)
            } else {
                return false
            }
        })
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering {
            return filteredMatches.count
        } else {
            //return uniList.count
            return matchesArr.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "uni", for: indexPath) as? matchTableViewCell {
            //var currUni: University? = nil
            var currUni: University? = nil
            if isFiltering {
                currUni = filteredMatches[indexPath.item]
            } else {
                //currUni = uniList[indexPath.item]
                currUni = matchesArr[indexPath.item]
            }
            for subview in cell.view.subviews {
                subview.removeFromSuperview()
            }
            let cellView = Bundle.main.loadNibNamed("View", owner: self, options: nil)?.first as? uniCellView
            cellView?.cornerRad()
            cellView!.name.text = currUni!.name
            if currUni!.lowData {
                cellView!.focusLabel.text = "Low Data"
                cellView?.focusString.text = "N/A"
            } else {
                cellView!.focusLabel.text = currUni!.bestEvent
                cellView!.focusString.text = currUni!.generateUniBestString()
            }
            if currUni!.sat != 0 {
                cellView!.sat.text = String(currUni!.sat)
            } else {
                cellView!.sat.text = "N/A"
            }
            if currUni!.act != 0 {
                cellView!.act.text = String(currUni!.act)
            } else {
                cellView!.act.text = "N/A"
            }
            if currUni!.gpaVal != 0 {
                cellView!.gpa.text = String(currUni!.gpa)
            } else {
                cellView!.gpa.text = "N/A"
            }
            cellView!.match.text = currUni!.match + "%"
            
            cell.view.addSubview(cellView!)
            
            return cell
        }

        return UITableViewCell()
    }
    
    func filterContentForSearchText(_ text: String, category: String) {
//        filteredMatches = []
//        for uni in matchesArr {
//            if uni.name.contains(text) {
//                filteredMatches.append(uni)
//            }
//        }
//        tableView.reloadData()
        filteredMatches = []
        filteredMatches = matchesArr.filter { (uni: University) -> Bool in
          //let doesCategoryMatch = category == .all || candy.category == category
            var categoryMatch: Bool = false
            switch(category) {
            case "D1":
                categoryMatch = uni.division == "Division 1"
            case "D2":
                categoryMatch = uni.division == "Division 2"
            case "D3":
                categoryMatch = uni.division == "Division 3"
            case "NAIA":
                categoryMatch = uni.division == "NAIA"
            default:
                categoryMatch = true
            }
          
          if isSearchBarEmpty {
            return categoryMatch
          } else {
            let substringMatch = uni.name.lowercased()
            .contains(text.lowercased())
            let charMatch = characterMatch(text.uppercased(), uni.name)
            /*return categoryMatch && uni.name.lowercased()
              .contains(text.lowercased())*/
            return categoryMatch && (substringMatch || charMatch)
          }
        }
        tableView.reloadData()
    }
    
    func characterMatch(_ searchString: String, _ name: String) -> Bool {
        for i in searchString {
            if !name.contains(i) {
                return false
            }
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            currUni = filteredMatches[indexPath.item]
        } else {
            currUni = matchesArr[indexPath.item]
        }
        performSegue(withIdentifier: "showUni", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.delegate = self
        matchesArr = matchesArr.sorted(by: {
            if Int($0.match) != Int($1.match) {
                return Int($0.match)! < Int($1.match)!
            } else if Int($0.match) == Int($1.match) && Int($0.match) == 100 {
                return Double($0.aheadBy) < Double($1.aheadBy)
            } else {
                return false
            }
        })
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUni" {
            let controller = segue.destination as! uniDetailViewController
            controller.currUni = currUni!
        }
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        if let keyBoardSize = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardSize.height, right: 0)
            self.tableView.contentInset = contentInsets
        }
    }

    @objc func keyBoardWillHide(notification: NSNotification) {
        self.tableView.contentInset = UIEdgeInsets.zero
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension matchesTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
    let searchBar = searchController.searchBar
    let category = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchBar.text!, category: category)
  }
}

extension matchesTableViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
    let category = searchBar.scopeButtonTitles![selectedScope]
    filterContentForSearchText(searchBar.text!, category: category)
  }
}
