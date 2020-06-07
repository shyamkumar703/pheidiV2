//
//  firstScreenViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/29/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class firstScreenViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 15
        startButton.layer.borderColor = pheidiColors.pheidiTeal.cgColor
        startButton.layer.borderWidth = 1
        let alphaColor = UIColor(red:0.00, green:0.70, blue:0.56, alpha:1.0)
        pheidiColors.addGradientColorToView(view: self.view, color: alphaColor)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButton(_ sender: Any) {
        performSegue(withIdentifier: "toName", sender: self)
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
