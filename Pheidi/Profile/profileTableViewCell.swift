//
//  profileTableViewCell.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/23/20.
//

import UIKit

class profileTableViewCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var division: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    var uni: University? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
