//
//  legalViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 7/21/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class legalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableRows = ["Terms and Conditions", "Privacy Policy"]
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableRows.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        switch(row) {
        case 0:
            guard let url = URL(string: "https://pheidi-privacy-policy-51.webself.net/terms-of-service") else { return }
            UIApplication.shared.open(url)
        case 1:
            guard let url = URL(string: "https://pheidi-privacy-policy-51.webself.net/blog") else { return }
            UIApplication.shared.open(url)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "legal", for: indexPath) as? legalTableViewCell {
            cell.title.text = tableRows[indexPath.item]
            
            let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(weight: .medium)))
            chevronImageView.tintColor = pheidiColors.pheidiTeal
            cell.accessoryView = chevronImageView
            
            cell.selectionStyle = .none
            
            return cell
        }
        return UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Legal"
        tableView.delegate = self
        tableView.dataSource = self
        
        let barButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
        barButton.tintColor = pheidiColors.pheidiTeal
        navigationItem.rightBarButtonItem = barButton
        

        // Do any additional setup after loading the view.
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
