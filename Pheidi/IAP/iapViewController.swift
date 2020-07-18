//
//  iapViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 7/18/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import StoreKit
import StatusAlert

class iapViewController: UIViewController {
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let alphaColor = UIColor(red:0.00, green:0.70, blue:0.56, alpha:1.0)
        pheidiColors.addGradientColorToView(view: self.view, color: alphaColor)
        
        joinButton.layer.cornerRadius = 15
        joinButton.layer.borderColor = pheidiColors.pheidiTeal.cgColor
        joinButton.layer.borderWidth = 1
        
        restoreButton.layer.cornerRadius = 10
        restoreButton.layer.borderColor = UIColor.black.cgColor
        restoreButton.layer.borderWidth = 1
        
        SKPaymentQueue.default().add(self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func joinPressed(_ sender: Any) {
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
        let statusAlert = StatusAlert()
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                //if item has been purchased
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                print("Transaction Successful")
                queue.finishTransaction(transaction)
                UserDefaults.standard.set(true, forKey: "pro")
                
                self.dismiss(animated: true, completion: nil)
                statusAlert.title = "Success"
                statusAlert.message = "Welcome to Fivestar!"
                statusAlert.image = UIImage(named: "checkmark")
                statusAlert.appearance.blurStyle = .dark
                statusAlert.showInKeyWindow()
                
            } else if transaction.transactionState == .failed {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
                
                print("Transaction Failed")
                queue.finishTransaction(transaction)
                
                self.dismiss(animated: true, completion: nil)
                statusAlert.title = "Transaction Failed"
                statusAlert.message = String("We were unable to process your transaction.")
                statusAlert.image = UIImage(named: "delete")
                statusAlert.appearance.blurStyle = .dark
                statusAlert.showInKeyWindow()
                
            } else if transaction.transactionState == .restored {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                UserDefaults.standard.set(true, forKey: "pro")
                print("Restored")
                
                self.dismiss(animated: true, completion: nil)
                statusAlert.title = "Restored"
                statusAlert.message = "Fivestar membership restored!"
                statusAlert.image = UIImage(named: "checkmark")
                statusAlert.appearance.blurStyle = .dark
                statusAlert.showInKeyWindow()
            }
        }
    }
    
    func paymentRequested() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = "com.Pheidi.pheidiPro"
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            print("User unable to make payments")
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
            self.dismiss(animated: true, completion: nil)
            let statusAlert = StatusAlert()
            statusAlert.title = "Transaction Failed"
            statusAlert.message = String("You're not allowed to make payments with this account.")
            statusAlert.image = UIImage(named: "delete")
            statusAlert.appearance.blurStyle = .dark
            statusAlert.showInKeyWindow()
        }
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
}
