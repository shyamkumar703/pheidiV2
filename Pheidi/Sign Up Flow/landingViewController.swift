//
//  landingViewController.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/25/20.
//

import UIKit

class landingViewController: UIViewController {
    @IBOutlet weak var getStartedView: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var tagline: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedView.layer.cornerRadius = 30
        generateTapRecognizer()
        user.createData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.logo.alpha = 1
        self.tagline.alpha = 1
        self.getStartedView.alpha = 1
    }
    
    func generateTapRecognizer() {
        getStartedView.isUserInteractionEnabled = true
        let getStartedTap = UITapGestureRecognizer(target:self,action:#selector(self.getStartedTapped))
        getStartedView.addGestureRecognizer(getStartedTap)
    }
    
    @objc func getStartedTapped() {
        profileViewController.buttonPress(getStartedView, completion: nil)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.logo.alpha = 0
            self.tagline.alpha = 0
            self.getStartedView.alpha = 0
        }, completion: {fin in
            self.performSegue(withIdentifier: "signUp", sender: self)
        })
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
