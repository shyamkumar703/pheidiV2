//
//  genderViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 12/28/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class genderViewController: UIViewController {
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        maleButton.layer.cornerRadius = 50
        femaleButton.layer.cornerRadius = 50
        
        maleButton.backgroundColor = Colors.blueVeryOpaq
        femaleButton.backgroundColor = Colors.blueVeryOpaq
        
        
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(popToPrevious))
        let image: UIImage = UIImage(named: "pheidiLogoSmall")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 3.5))
        imageView.image = image
        self.navigationItem.titleView = imageView

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        maleButton.alpha = 1
        femaleButton.alpha = 1
        question.alpha = 1
    }
    
    
    @objc func popToPrevious() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        UIView.animate(withDuration: 0.4, animations: {
            self.question.alpha = 0
            self.maleButton.alpha = 0
            self.femaleButton.alpha = 0
            self.navigationController?.navigationBar.alpha = 0
        }, completion: {fin in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    @IBAction func maleButtonPressed(_ sender: Any) {
        profileViewController.buttonPress(maleButton, completion: nil)
        user.gender = "Male"
        user.saveGender("Male")
        UIView.animate(withDuration: 0.4, animations: {
            self.question.alpha = 0
            self.maleButton.alpha = 0
            self.femaleButton.alpha = 0
        }, completion: {fin in
            self.performSegue(withIdentifier: "showQuestions", sender: self)
        })
    }
    
    @IBAction func femaleButtonPressed(_ sender: Any) {
        profileViewController.buttonPress(femaleButton, completion: nil)
        user.gender = "Female"
        user.saveGender("Female")
        UIView.animate(withDuration: 0.4, animations: {
            self.question.alpha = 0
            self.maleButton.alpha = 0
            self.femaleButton.alpha = 0
        }, completion: {fin in
            self.performSegue(withIdentifier: "showQuestions", sender: self)
        })
    }
    
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
