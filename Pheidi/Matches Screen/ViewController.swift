//
//  ViewController.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/19/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var ipodTouch: Bool = UIScreen.main.bounds.width == 320 && UIScreen.main.bounds.height == 568
    
    @IBOutlet weak var matchesTableView: UITableView!
    let titleArr = ["Top Recommendations", "More Recommendations", "Best-Fit Schools", "Best California Schools"]
    var selectedUni: University? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && !ipodTouch {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "topRecommendations", for: indexPath) as? topRecTableViewCell {
                cell.collectionView.reloadData()
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "smallTableCell", for: indexPath) as? smallRecTableViewCell {
                cell.title.text = titleArr[indexPath.row]
                cell.collectionView.reloadData()
                switch indexPath.row {
                case 0:
                    cell.category = .top
                case 1:
                    cell.category = .moreRec
                case 2:
                    cell.category = .bestFit
                case 3:
                    cell.category = .bestState
                default:
                    return cell
                }
                cell.fetchData()
                return cell
            }
        }
        return UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        matchesTableView.dataSource = self
        matchesTableView.delegate = self
        user.populateUserAtLaunch()
        switch(user.gender) {
        case "Male":
            University.loadMatchesMale()
        case "Female":
            University.loadMatchesFemale()
        default:
            return
        }
        
        print(user.statArr)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        matchesTableView.reloadData()
    }
    
    @objc func showInfo(_ notification: NSNotification) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        let dict = notification.userInfo! as NSDictionary
        if let uni = dict["uni"] as? University {
                selectedUni = uni
            performSegue(withIdentifier: "showInfo", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let dest = segue.destination as? uniInfoViewController else {
            return
        }
        dest.uni = selectedUni!
    }


}

extension UILabel {
    func setSizeFont (sizeFont: CGFloat) {
        self.font =  UIFont(name: self.font.fontName, size: sizeFont)!
        self.sizeToFit()
    }
}

