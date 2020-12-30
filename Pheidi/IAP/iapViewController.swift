//
//  iapViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 12/29/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import StoreKit

class iapViewController: UIViewController {
    @IBOutlet weak var annualView: UIView!
    @IBOutlet weak var monthlyView: UIView!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var mostPopular: UILabel!
    
    var annualSelected: Bool = true
    var selectedProductIdentifier = "com.pheidi.pheidiProYearly"
    
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
        
        self.navigationController?.navigationItem.rightBarButtonItem?.title = "CLOSE"
        
        monthlyView.layer.cornerRadius = 10
        
        purchaseButton.layer.cornerRadius = 10
        mostPopular.layer.cornerRadius = 5
        mostPopular.layer.masksToBounds = true
        mostPopular.textColor = .black
//        closeButton.layer.cornerRadius = 20
        
        annualView.isUserInteractionEnabled = true
        monthlyView.isUserInteractionEnabled = true
        
        let annualTap = UITapGestureRecognizer(target:self,action:#selector(self.annualTapped))
        
        let monthlyTap = UITapGestureRecognizer(target:self,action:#selector(self.monthlyTapped))
        
        annualView.addGestureRecognizer(annualTap)
        monthlyView.addGestureRecognizer(monthlyTap)
        
        SKPaymentQueue.default().add(self)
        

        // Do any additional setup after loading the view.
    }
    
    @objc func annualTapped() {
        if !annualSelected {
            annualSelected = true
            selectedProductIdentifier = "com.pheidi.pheidiProYearly"
            profileViewController.buttonPress(annualView, completion: nil)
            UIView.animate(withDuration: 0.4, animations: {
                self.mostPopular.backgroundColor = Colors.blue
                self.annualView.layer.borderWidth = 2
                self.annualView.layer.borderColor = Colors.blue.cgColor
                self.monthlyView.layer.borderWidth = 0
                self.monthlyView.layer.borderColor = nil
                
                self.purchaseButton.setTitle("Get 12 Months For $23.99", for: .normal)
            })
        }
    }
    
    @objc func monthlyTapped() {
        if annualSelected {
            selectedProductIdentifier = "com.Pheidi.pheidiPro"
            annualSelected = false
            profileViewController.buttonPress(self.monthlyView, completion: nil)
            UIView.animate(withDuration: 0.4, animations: {
                self.mostPopular.backgroundColor = Colors.lightGray
                self.monthlyView.layer.borderColor = Colors.blue.cgColor
                self.monthlyView.layer.borderWidth = 2
                self.annualView.layer.borderColor = nil
                self.annualView.layer.borderWidth = 0
                
                self.purchaseButton.setTitle("Get 1 Month for $3.00", for: .normal)
            })
        }
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func purchasePressed(_ sender: Any) {
        paymentRequested()
    }
    
    @IBAction func restorePressed(_ sender: Any) {
        paymentRequested()
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

extension iapViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                //if item has been purchased
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                print("Transaction Successful")
                queue.finishTransaction(transaction)
                UserDefaults.standard.set(true, forKey: "pro")
                

                SKStoreReviewController.requestReview()
                
            } else if transaction.transactionState == .failed {
                
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
                
                print("Transaction Failed")
                queue.finishTransaction(transaction)

                
            } else if transaction.transactionState == .restored {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                UserDefaults.standard.set(true, forKey: "pro")
                print("Restored")
                

                SKStoreReviewController.requestReview()
            }
        }
    }
    
    func paymentRequested() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = selectedProductIdentifier
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            print("User unable to make payments")
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
}
