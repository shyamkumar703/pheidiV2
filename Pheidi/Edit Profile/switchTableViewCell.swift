//
//  switchTableViewCell.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/23/20.
//

import UIKit

class switchTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let template = UserDefaults.standard.bool(forKey: "emailTemplate")
        if template {
            switchView.setOn(true, animated: false)
        } else {
            switchView.setOn(false, animated: false)
        }
        // Initialization code
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        if switchView.isOn == true {
            UserDefaults.standard.setValue(true, forKey: "emailTemplate")
        } else {
            UserDefaults.standard.setValue(false, forKey: "emailTemplate")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
