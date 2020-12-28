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
    
    var selectedUni: University? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search"
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = ""

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        University.loadMatchesMale()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return uniList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? searchTableViewCell {
            let currSchool = uniList[indexPath.row]
            
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        selectedUni = uniList[indexPath.row]
        cellPress(cell!) {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showInfo", sender: self)
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }
        }
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
