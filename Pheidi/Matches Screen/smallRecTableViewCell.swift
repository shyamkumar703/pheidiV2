//
//  smallRecTableViewCell.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/19/20.
//

import UIKit

class smallRecTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smallCell", for: indexPath) as? smallCollectionViewCell {
            cell.contentView.layer.cornerRadius = 12
            let cellView = Bundle.main.loadNibNamed("smallCollectionViewCell", owner: self, options: nil)?.first as? smallCellView
            cellView?.setup()
            cell.view.addSubview(cellView!)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.1,
            animations: {
                cell!.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    cell!.transform = CGAffineTransform.identity
                }, completion: {_ in
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showInfo"), object: nil)
                })
            })
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = SmallFlowLayout()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class SmallFlowLayout: UICollectionViewFlowLayout {
    let padding: CGFloat = 0
    override init() {
        super.init()
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 2
        self.scrollDirection = .horizontal
        self.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0) //right = "should set for footer" (Horizental)
        self.itemSize = CGSize(width: 261, height: 128)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
