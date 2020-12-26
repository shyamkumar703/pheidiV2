//
//  eventTableViewCell.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/25/20.
//

import UIKit

class eventTableViewCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var event: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 20
    }
    
    override func prepareForReuse() -> Void {
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.clear.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
