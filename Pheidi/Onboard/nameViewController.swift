//
//  nameViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/24/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class nameViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nameField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 10
        nextButton.layer.borderWidth = 1.0
        nextButton.layer.borderColor = pheidiColors.pheidiTeal.cgColor
        nameField.becomeFirstResponder()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        nextButton.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelect" {
            let controller = segue.destination as! onboardSelectViewController
            controller.name = nameField.text!
        }
        
    }
    
    @IBAction func editingChanged(_ sender: Any) {
        if nameField.text != nil && nameField.text != "" {
            nextButton.isHidden = false
        } else {
            nextButton.isHidden = true
        }
    }
    
    @IBAction func editingEnd(_ sender: Any) {
        if nameField.text != nil && nameField.text != "" {
            nextButton.isHidden = false
        } else {
            nextButton.isHidden = true
        }
    }
    
    @IBAction func editingBegin(_ sender: Any) {
        if nameField.text != nil {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        performSegue(withIdentifier: "toSelect", sender: self)
    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        print("Unwind to Root View Controller")
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
