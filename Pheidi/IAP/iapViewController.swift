//
//  iapViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 12/29/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class iapViewController: UIViewController {
    @IBOutlet weak var annualView: UIView!
    @IBOutlet weak var monthlyView: UIView!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    
    var annualSelected: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        let image: UIImage = UIImage(named: "pheidiLogoSmall")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 3.5))
        imageView.image = image
        self.navigationItem.titleView = imageView
        
        annualView.layer.cornerRadius = 10
        annualView.layer.borderColor = Colors.blue.cgColor
        annualView.layer.borderWidth = 2
        
        monthlyView.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
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
