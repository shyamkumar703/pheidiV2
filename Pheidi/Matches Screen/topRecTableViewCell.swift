//
//  topRecTableViewCell.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/19/20.
//

import UIKit

class topRecTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var currCell = 0
    var numCells = 5
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topRec", for: indexPath) as? topRecCollectionViewCell {
            cell.contentView.layer.cornerRadius = 18
            
            cell.contentView.frame.size.width = UIScreen.main.bounds.width * 0.9
            cell.contentView.frame.size.height = 191
            
            cell.view.frame.size.width = UIScreen.main.bounds.width * 0.9
            cell.view.frame.size.height = 191
            
            let cellView = Bundle.main.loadNibNamed("topCollectionViewCell", owner: self, options: nil)?.first as? topCellView
            cellView?.setup(matchesArr[indexPath.row])
            cell.uni = matchesArr[indexPath.row]
            cellView!.frame.size.width = UIScreen.main.bounds.width * 0.9
            cellView!.frame.size.height = 191

            cell.view.addSubview(cellView!)
            
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! topRecCollectionViewCell
        UIView.animate(withDuration: 0.1,
            animations: {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    cell.transform = CGAffineTransform.identity
                }, completion: {_ in
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showInfo"), object: nil, userInfo: ["uni": cell.uni as Any])
                })
            })
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var timer: Timer? = nil
    var interactionTimer: Timer? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = SubclassFlowLayout()
//        collectionView.decelerationRate = .fast //-> this for scrollView speed
//        startTimer()
        matchesArr.sort {Int($0.match)! < Int($1.match)!}
//        collectionView.collectionViewLayout = SnapCenterLayout()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @objc func startTimer() {
        
        interactionTimer?.invalidate()
        timer =  Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer!.invalidate()
        interactionTimer?.invalidate()
        interactionTimer =  Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(self.startTimer), userInfo: nil, repeats: true)
    }


    @objc func scrollAutomatically(_ timer1: Timer) {
        if currCell == numCells - 1 {
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            currCell = 0
        } else {
            collectionView.scrollToItem(at: IndexPath(row: currCell + 1, section: 0), at: .left, animated: true)
            currCell += 1
        }
    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        stopTimer()
//    }

}


class SubclassFlowLayout: UICollectionViewFlowLayout {
    let padding: CGFloat = 0
    var iphone8 = UIScreen.main.bounds.width == 375
    override init() {
        super.init()
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 2
        self.scrollDirection = .horizontal
        
        if iphone8 {
            self.sectionInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0) //right = "should set for footer" (Horizental)
        } else {
            self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //right = "should set for footer" (Horizental)
        }
        self.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.9, height: 191)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: UIScreen.main.bounds.width * 0.9, height: 191)
        }
}
