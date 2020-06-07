//
//  seeAllTableViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/24/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class seeAllTableViewController: UITableViewController {
    var currUni: University? = nil
    var srcArray: [University]? = nil
    var currTableTitle: String = "NCAA Division 1"
    var filteredMatches: [University] = []
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
    
    let scopeArray = ["All", "D1", "D2", "D3", "NAIA"]
    let regionScopeArray = ["All", "West", "Midwest", "South", "East"]
    
    let westRegion: [String] = ["WA", "OR", "CA", "AZ", "AK"]
    let midwestRegion: [String] = ["ID", "NV", "UT", "CO", "NM", "TX", "LA", "MS", "AR",
    "OK", "KS", "NE", "WY", "SD", "ND", "MT"]
    let southRegion: [String] = ["FL", "AL", "GA", "SC", "NC", "TN", "VA", "WV"]
    let northeastRegion: [String] = ["MN", "IA", "MO", "WI", "IL", "IN", "KY", "OH", "MI", "PA", "MD", "DE",
    "NJ", "CT", "RI", "MA", "NH", "VT", "ME", "NY", "PA"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(popToPrevious))
        self.title = currTableTitle
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search " + currTableTitle
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        if currTableTitle.contains("NCAA") || currTableTitle.contains("NAIA") || currTableTitle.contains("Top") {
            searchController.searchBar.scopeButtonTitles = regionScopeArray
        } else {
            searchController.searchBar.scopeButtonTitles = scopeArray
        }

        searchController.searchBar.tintColor = pheidiColors.pheidiTeal
        
        searchController.searchBar.searchTextField.textColor = .white
        
        searchController.searchBar.setScopeBarButtonTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        
        var isSearchBarEmpty: Bool {
          return searchController.searchBar.text?.isEmpty ?? true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        searchController.searchBar.showsScopeBar = true
        navigationItem.hidesSearchBarWhenScrolling = false
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
            return srcArray!.count
        }

    }
    
    @objc private func popToPrevious() {
        // our custom stuff
        navigationController?.popViewController(animated: true)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "seeAll", for: indexPath) as? seeAllTableViewCell {
            var currUni: University? = nil
            if isFiltering {
                currUni = filteredMatches[indexPath.item]
            } else {
                currUni = srcArray![indexPath.item]
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
            if currUni!.match == "N/A" {
                cellView!.match.text = currUni!.match
            } else {
                cellView!.match.text = currUni!.match + "%"
            }
            
            cell.view.addSubview(cellView!)
            return cell
        }

        return UITableViewCell()
    }
    
    func filterContentForSearchText(_ text: String, category: String) {
        filteredMatches = []
        filteredMatches = srcArray!.filter { (uni: University) -> Bool in
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
            case "West":
                categoryMatch = westRegion.contains(uni.state)
            case "Midwest":
                categoryMatch = midwestRegion.contains(uni.state)
            case "South":
                categoryMatch = southRegion.contains(uni.state)
            case "East":
                categoryMatch = northeastRegion.contains(uni.state)
            default:
                categoryMatch = true
            }
          
          if isSearchBarEmpty {
            return categoryMatch
          } else {
            let substringMatch = uni.name.lowercased()
            .contains(text.lowercased())
            let charMatch = characterMatch(text.uppercased(), uni.name)
            return categoryMatch && (substringMatch || charMatch)
          }
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            currUni = filteredMatches[indexPath.item]
        } else {
            currUni = srcArray![indexPath.item]
        }
        performSegue(withIdentifier: "show", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
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
    
    func characterMatch(_ searchString: String, _ name: String) -> Bool {
        for i in searchString {
            if !name.contains(i) {
                return false
            }
        }
        return true
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

extension seeAllTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
    let searchBar = searchController.searchBar
    let category = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchBar.text!, category: category)
  }
}

extension seeAllTableViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
    let category = searchBar.scopeButtonTitles![selectedScope]
    filterContentForSearchText(searchBar.text!, category: category)
  }
}
