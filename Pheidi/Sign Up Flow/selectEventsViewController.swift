//
//  selectEventsViewController.swift
//  newPheidiUI
//
//  Created by Shyam Kumar on 12/25/20.
//

import UIKit

class selectEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var question: UILabel!
    
    var numSelected = 0
    
    let eventsArr = ["100M", "200M", "400M", "800M", "1600M", "3200M", "110M Hurdles", "300M Hurdles", "Shotput", "Discus", "High Jump", "Long Jump", "Triple Jump", "Pole Vault"]
    var selectedArr: [String] = []
    var questionArr: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as? eventTableViewCell {
            cell.event.text = eventsArr[indexPath.row]
            if selectedArr.contains(cell.event.text!) {
                cell.view.layer.borderColor = Colors.blue.cgColor
                cell.view.layer.borderWidth = 3
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! eventTableViewCell
        if selectedArr.contains(selectedCell.event.text!) {
            profileViewController.buttonPress(selectedCell.view, completion: nil)
            selectedCell.view.layer.borderWidth = 0
            selectedCell.view.layer.borderColor = UIColor.clear.cgColor
            selectedArr = selectedArr.filter {$0 != selectedCell.event.text!}
            if selectedArr.count == 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.nextButton.alpha = 0
                }, completion: nil)
            }
        } else {
            profileViewController.buttonPress(selectedCell.view, completion: nil)
            selectedCell.view.layer.borderWidth = 3
            selectedCell.view.layer.borderColor = Colors.blue.cgColor
            selectedArr.append(selectedCell.event.text!)
            if selectedArr.count != 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.nextButton.alpha = 1
                }, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        nextButton.layer.cornerRadius = 20
        nextButton.alpha = 0
        
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(popToPrevious))
        
        let image: UIImage = UIImage(named: "pheidiLogoSmall")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 3.5))
        imageView.image = image
        self.navigationItem.titleView = imageView

        // Do any additional setup after loading the view.
    }
    
    @objc func popToPrevious() {
        UIView.animate(withDuration: 0.3, animations: {
            self.question.alpha = 0
            self.tableView.alpha = 0
            self.nextButton.alpha = 0
        }, completion: {fin in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let prevViewController = storyBoard.instantiateViewController(withIdentifier: "questions") as! questionsViewController
            prevViewController.index = prevViewController.questionsArr.count - 1
            self.navigationController?.pushViewController(prevViewController, animated: false)
        })
    }
    
    func makeQuestionArr() {
        for selected in selectedArr {
            let questionString = "What is your " + selected + " PR?"
            questionArr.append(questionString)
        }
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        makeQuestionArr()
        user.saveCurrEvents(selectedArr)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let prevViewController = storyBoard.instantiateViewController(withIdentifier: "questions") as! questionsViewController
        
        prevViewController.questionsArr = questionArr
        prevViewController.index = 0
        prevViewController.eventsArr = selectedArr
        prevViewController.marks = true
        
        UIView.animate(withDuration: 0.4, animations: {
            self.question.alpha = 0
            self.tableView.alpha = 0
            self.nextButton.alpha = 0
        }, completion: {fin in
            self.navigationController?.pushViewController(prevViewController, animated: false)
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
