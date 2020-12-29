//
//  searchTableViewController.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/19/20.
//

import UIKit

class searchTableViewController: UITableViewController {
    
    var schools = ["University of California, Berkeley", "Stanford University", "Harvard University", "Princeton University", "University of Oregon"]
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
    
    var selectedUni: University? = nil
    var filteredMatches: [University] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Universities"
        searchController.obscuresBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        navigationItem.searchController = searchController
        
        searchController.searchBar.tintColor = Colors.blue
                
        searchController.searchBar.searchTextField.textColor = .white
                
        searchController.searchBar.setScopeBarButtonTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.scopeButtonTitles = scopeArray
        navigationItem.hidesSearchBarWhenScrolling = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        var isSearchBarEmpty: Bool {
            return searchController.searchBar.text?.isEmpty ?? true
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        switch(user.gender) {
        case "Male":
            University.loadMatchesMale()
        case "Female":
            University.loadMatchesFemale()
        default:
            return
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering {
            return filteredMatches.count
        } else {
            return uniList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? searchTableViewCell {
            let currSchool: University
            if isFiltering {
                currSchool = filteredMatches[indexPath.row]
            } else {
                currSchool = uniList[indexPath.row]
            }
            
            cell.school.text = currSchool.name
            cell.school.adjustsFontSizeToFitWidth = true
            
            cell.matchLabel.layer.cornerRadius = 5
            cell.matchLabel.layer.masksToBounds = true
            
            if currSchool.division != "" {
                cell.division.text = currSchool.division.uppercased()
            } else {
                cell.division.text = "-"
            }
            
            cell.view.layer.cornerRadius = 10
            
//            let randomInt = Int.random(in: 0..<3)
            
            if currSchool.match == "N/A" {
                cell.matchLabel.text = "-"
                cell.matchLabel.backgroundColor = Colors.redOpaq
                cell.matchLabel.textColor = Colors.red
                return cell
            } else {
                cell.matchLabel.text = currSchool.match + "%"
            }
            
            if Int(currSchool.match)! > 75 {
                cell.matchLabel.backgroundColor = Colors.greenOpaq
                cell.matchLabel.textColor = Colors.green
            } else if Int(currSchool.match)! > 50 {
                cell.matchLabel.backgroundColor = Colors.yellowOpaq
                cell.matchLabel.textColor = Colors.yellow
            } else {
                cell.matchLabel.backgroundColor = Colors.redOpaq
                cell.matchLabel.textColor = Colors.red
            }
            
//            switch randomInt {
//            case 0:
//                cell.matchLabel.backgroundColor = Colors.greenOpaq
//                cell.matchLabel.textColor = Colors.green
//            case 1:
//                cell.matchLabel.backgroundColor = Colors.yellowOpaq
//                cell.matchLabel.textColor = Colors.yellow
//            default:
//                cell.matchLabel.backgroundColor = Colors.redOpaq
//                cell.matchLabel.textColor = Colors.red
//            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func filterContentForSearchText(_ text: String, category: String) {
        filteredMatches = []
        filteredMatches = uniList.filter { (uni: University) -> Bool in
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
            return categoryMatch && (substringMatch || charMatch)
            }
        }
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if isFiltering {
            selectedUni = filteredMatches[indexPath.row]
        } else {
            selectedUni = uniList[indexPath.row]
        }
        cellPress(cell!) {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showInfo", sender: self)
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }
        }
    }
    
    func characterMatch(_ searchString: String, _ name: String) -> Bool {
        for i in searchString {
            if !name.contains(i) {
                return false
            }
        }
        return true
    }
    
    
    
    func cellPress(_ view: UIView, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.1,
            animations: {
                view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    view.transform = CGAffineTransform.identity
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
                    completion()
                }
            })
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let dest = segue.destination as? uniInfoViewController else {
            return
        }
        dest.uni = selectedUni!
    }

}

extension searchTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
    let searchBar = searchController.searchBar
    let category = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchBar.text!, category: category)
  }
}

extension searchTableViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
    let category = searchBar.scopeButtonTitles![selectedScope]
    filterContentForSearchText(searchBar.text!, category: category)
  }
}
