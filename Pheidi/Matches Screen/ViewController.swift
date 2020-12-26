//
//  ViewController.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/19/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var matchesTableView: UITableView!
    let titleArr = ["", "More Recommendations", "Best-Fit Schools", "Best California Schools"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "topRecommendations", for: indexPath) as? topRecTableViewCell {
                cell.collectionView.reloadData()
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "smallTableCell", for: indexPath) as? smallRecTableViewCell {
                cell.title.text = titleArr[indexPath.row]
                cell.collectionView.reloadData()
                return cell
            }
        }
        return UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        matchesTableView.dataSource = self
        matchesTableView.delegate = self
        // Do any additional setup after loading the view.
//        self.navigationController?.navigationBar.barStyle = .black
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.title = "P"
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        let image: UIImage = UIImage(named: "pheidiLogoSmall")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 3.5))
        imageView.image = image
        self.navigationItem.titleView = imageView
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(showInfo), name: NSNotification.Name(rawValue: "showInfo"), object: nil)
    }
    
    override open var shouldAutorotate: Bool {
            return false
    }
    
    @objc func showInfo() {
        performSegue(withIdentifier: "showInfo", sender: self)
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }


}

