//
//  settingsCollectionViewCell.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/23/20.
//

import UIKit

class settingsCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .you:
            srcArr = youArr
        case .academics:
            srcArr = academicsArr
        case .marks:
            srcArr = athleticsArr
        default:
            srcArr = moreArr
        }
        
        return srcArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if srcArr[row][0] != "Email Template" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as? textTableViewCell {
                cell.title.text = srcArr[row][0]
                cell.value.text = srcArr[row][1]
                
                if row == srcArr.count - 1 {
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
                }
                
                if type == .more {
                    cell.value.alpha = 0
                } else {
                    cell.value.alpha = 1
                    cell.setup()
                }
                
                return cell
            }
            
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as? switchTableViewCell {
                cell.title.text = "Email Template"
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var type: Settings = .you
    var srcArr: [[String]] = []
    
    let youArr = [["First Name", "Shyam"], ["Last Name", "Kumar"], ["Email Template", ""]]
    let academicsArr = [["GPA", "3.90"], ["SAT", "1480"], ["ACT", "-"]]
    let athleticsArr = [["100M", "-"], ["200M", "-"], ["400M", "-"], ["800M", "-"], ["1600M", "4:20"], ["3200M", "9:16"], ["Shotput", "-"], ["Discus", "-"],
    ["High Jump", "-"], ["Long Jump", "-"], ["Triple Jump", "-"], ["Pole Vault", "-"], ["300M Hurdles", "-"]]
    let moreArr = [["Terms of Use", ""], ["Privacy Policy", ""], ["Help", ""]]
    
    
    
    
    override func awakeFromNib() {
        tableView.delegate = self
        tableView.dataSource = self
        
//        switch type {
//        case .you:
//            srcArr = youArr
//        case .academics:
//            srcArr = academicsArr
//        default:
//            srcArr = athleticsArr
//        }
    }
    
}

enum Settings {
    case you
    case academics
    case marks
    case more
}
