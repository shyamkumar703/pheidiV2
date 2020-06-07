//
//  secondProfileViewController.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/18/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit
import BLTNBoard

class secondProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if srcArray.count < 10 {
            return srcArray.count
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = starredCollectionView.dequeueReusableCell(withReuseIdentifier: "starred", for: indexPath) as? starredUniCollectionViewCell {
            var currUni: University? = srcArray[indexPath.item]
            let cellView = Bundle.main.loadNibNamed("View", owner: self, options: nil)?.first as? uniCellView
            
            cellView?.cornerRad()
            cellView!.name.text = currUni!.name
            if currUni!.lowData {
                cellView!.focusLabel.text = "Low Data"
                cellView?.focusString.text = "N/A"
            } else {
                cellView!.focusLabel.text = currUni!.bestEvent
                cellView!.focusString.text = currUni!.generateUniBestString()
            }
            if currUni!.sat != 0 {
                cellView!.sat.text = String(currUni!.sat)
            } else {
                cellView!.sat.text = "N/A"
            }
            if currUni!.act != 0 {
                cellView!.act.text = String(currUni!.act)
            } else {
                cellView!.act.text = "N/A"
            }
            if currUni!.gpaVal != 0 {
                cellView!.gpa.text = String(currUni!.gpa)
            } else {
                cellView!.gpa.text = "N/A"
            }
            cellView!.match.text = currUni!.match + "%"
            
            cell.view.addSubview(cellView!)
            cell.contentView.layer.cornerRadius = 18
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currUni = srcArray[indexPath.item]
        performSegue(withIdentifier: "uniProf", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "uniProf" {
            let controller = segue.destination as! uniDetailViewController
            controller.currUni = currUni!
        }
    }
    


    @IBOutlet weak var tutorial: UIButton!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var starredCollectionView: UICollectionView!
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var eventGroupLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var overviewButton: UIButton!
    @IBOutlet weak var athleticButton: UIButton!
    @IBOutlet weak var academicButton: UIButton!
    var selectedButton: UIButton? = nil
    var gpa = 0.0
    let mins = 9
    let secs = 32
    var floatSAT = Float(1480)
    var floatACT = Float(21)
    var stringSAT = String(1480)
    var stringACT = String(21)
    var currUni: University? = nil
    var srcArray: [University] = []
    var overviewArray: [University] = []
    lazy var bulletinManager: BLTNItemManager = {
        let rootItem: BLTNPageItem = generateMatchTut()
        return BLTNItemManager(rootItem: rootItem)
    }()
    
    //    let overviewView = Bundle.main.loadNibNamed("profileOverview", owner: self, options: nil)?.first as? profileOverview
    let featureView2 = Bundle.main.loadNibNamed("profileOverview", owner: self, options: nil)?.first as? profileOverview
    
    let academicView = Bundle.main.loadNibNamed("profileAcademic", owner: self, options: nil)?.first as? profileAcademic
    
    let athleticView = Bundle.main.loadNibNamed("marksPageView", owner: self, options: nil)?.first as? marksPageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(onOverviewReload(_:)), name: Notification.Name("Star Pressed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveReloadRequest(_:)), name: Notification.Name("Reload Requested"), object: nil)
        
//        featureView2!.center = CGPoint(x: statsView.frame.size.width  / 2,
//        y: statsView.frame.size.height / 2)
//        academicView!.center = CGPoint(x: statsView.frame.size.width  / 2,
//        y: statsView.frame.size.height / 2)
//        athleticView!.center = CGPoint(x: statsView.frame.size.width  / 2,
//        y: statsView.frame.size.height / 2)
        
        
        
        University.createDistanceRankings()
        University.createAcademicRankings()
        pheidiColors.addGradientToView(view: gradientView)
        let avDict = setupAthleticView()
        athleticView!.setup(avDict)
        nameLabel.text = user.name
        eventGroupLabel.text = " " + user.eventGroup.uppercased()
        featureView2!.initView()
        //athleticView!.setup(["3200":"9:32", "1600":"4:32", "800":"2:00", "400":"55"])
        academicView!.setConstraints()
        statsView.addSubview(athleticView!)
        statsView.addSubview(featureView2!)
        
        overviewArray = user.starredKeyToUni()
        srcArray = overviewArray
        if srcArray.count == 0 {
            collectionTitle.text = "Discover Matches"
            srcArray = matchesArr.shuffled()
        }
        starredCollectionView.delegate = self
        starredCollectionView.dataSource = self
        selectedButton = overviewButton
        editProfile.layer.cornerRadius = 10
        editProfile.layer.borderColor = UIColor.black.cgColor
        editProfile.layer.borderWidth = 1.0
        
        tutorial.layer.cornerRadius = 10
        tutorial.layer.borderColor = UIColor.black.cgColor
        tutorial.layer.borderWidth = 1.0
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 2 {
            starredCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
        }
    }
    
    @objc func onDidReceiveReloadRequest(_ notification: NSNotification) {
        let avDict = setupAthleticView()
        athleticView!.setup(avDict)
        featureView2!.initView()
        academicView!.setConstraints()
        starredCollectionView.reloadData()
    }
    
    @objc func onOverviewReload(_ notification: NSNotification) {
        if selectedButton == overviewButton {
            if user.starredKeyToUni().count == 0 {
                collectionTitle.text = "Discover Matches"
                srcArray = matchesArr.shuffled()
                starredCollectionView.reloadData()
            } else {
                collectionTitle.text = "Starred Schools"
                srcArray = user.starredKeyToUni()
                starredCollectionView.reloadData()
            }
        }
    }
    
    func setupAthleticView() -> [String:String] {
        var retDict: [String: String] = [:]
        for event in user.currEvents {
            switch event {
                case "100M":
                //            label.text = initVal!
                //            slider.value = Float(user.onehundredm)
                            let initVal = User.doubleToString(user.onehundredm)
                            retDict["100M"] = initVal
                        case "200M":
                //            label.text = initVal!
                //            slider.value = Float(user.twohundredm)
                            let initVal = User.doubleToString(user.twohundredm)
                            retDict["200M"] = initVal
                        case "400M":
                //            label.text = initVal!
                //            slider.value = Float(user.fourhundredm)
                            let initVal = User.doubleToString(user.fourhundredm)
                            retDict["400M"] = initVal
                        case "800M":
                //            label.text = initVal!
                //            slider.value = Float(user.eighthundredm)
                            let initVal = User.doubleToString(user.eighthundredm)
                            retDict["800M"] = initVal
                        case "1600M":
                //            label.text = initVal!
                //            slider.value = Float(user.mile)
                            let initVal = User.secsToString(user.mile)
                            retDict["1600M"] = initVal
                        case "3200M":
                            let initVal = User.secsToString(user.twoMile)
                            retDict["3200M"] = initVal
                        case "Shotput":
                //            label.text = initVal!
                //            slider.value = Float(user.shotput)
                            let initVal = User.ftToString(user.shotput)
                            retDict["Shotput"] = initVal
                        case "Discus":
                //            label.text = initVal!
                //            slider.value = Float(user.discus)
                            let initVal = User.ftToString(user.discus)
                            retDict["Discus"] = initVal
                        case "Long Jump":
                //            label.text = initVal!
                //            slider.value = Float(user.longJump)
                            let initVal = User.ftToString(user.longJump)
                            retDict["Long Jump"] = initVal
                        case "High Jump":
                //            label.text = initVal!
                //            slider.value = Float(user.highJump)
                            let initVal = User.ftToString(user.highJump)
                            retDict["High Jump"] = initVal
                        case "Triple Jump":
                //            label.text = initVal!
                //            slider.value = Float(user.tripleJump)
                            let initVal = User.ftToString(user.tripleJump)
                            retDict["Triple Jump"] = initVal
                        case "110M Hurdles":
                //            label.text = initVal!
                //            slider.value = Float(user.onetenHurdles)
                            let initVal = User.doubleToString(user.onetenHurdles)
                            retDict["110M Hurdles"] = initVal
                        case "300M Hurdles":
                //            label.text = initVal!
                //            slider.value = Float(user.threehundredHurdles)
                            let initVal = User.doubleToString(user.threehundredHurdles)
                            retDict["300M Hurdles"] = initVal
                        case "Pole Vault":
                //            label.text = initVal!
                //            slider.value = Float(user.poleVault)
                            let initVal = User.ftToString(user.poleVault)
                            retDict["Pole Vault"] = initVal
                        default:
                            print("whoops")
            }
        }
        return retDict
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.delegate = self
        gpa = user.gpa.truncate(places: 2)
        let prog = user.gpa.truncate(places: 2) / 4.0
        let gpaString = String(user.gpa)
        featureView2!.initView()
        featureView2!.animateProgress(prog, gpaString)
        overviewArray = user.starredKeyToUni()
        scrollView.flashScrollIndicators()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if selectedButton == overviewButton {
//            overviewPressed(secondProfileViewController())
//        } else if selectedButton == academicButton {
//            academicPressed(secondProfileViewController())
//        } else {
//            athleticPressed(secondProfileViewController())
//        }
    }
    
    
    @IBAction func overviewPressed(_ sender: Any) {
        if selectedButton == overviewButton && !(sender is secondProfileViewController) {
            return
        }
        overviewButton.setTitleColor(UIColor.white, for: .normal)
        //selectedButton!.setTitleColor(pheidiColors.pheidiGray, for: .normal)
        academicButton.setTitleColor(UIColor.gray, for: .normal)
        athleticButton.setTitleColor(UIColor.gray, for: .normal)
        selectedButton = overviewButton
        statsView.isHidden = true
        for view in self.statsView.subviews {
            view.removeFromSuperview()
        }
        statsView.addSubview(featureView2!)
        statsView.isHidden = false
        collectionTitle.text = "Starred Schools"
        srcArray = user.starredKeyToUni()
        if srcArray.count == 0 {
            collectionTitle.text = "Discover Matches"
            srcArray = matchesArr.shuffled()
        }
        starredCollectionView.reloadData()
    }
    
    @IBAction func academicPressed(_ sender: Any) {
        if selectedButton == academicButton && !(sender is secondProfileViewController) {
            return
        }
        //academicView?.setConstraints()
        academicButton.setTitleColor(UIColor.white, for: .normal)
        //selectedButton!.setTitleColor(pheidiColors.pheidiGray, for: .normal)
        overviewButton.setTitleColor(UIColor.gray, for: .normal)
        athleticButton.setTitleColor(UIColor.gray, for: .normal)
        selectedButton = academicButton
        var filteredMatches = matchesArr.filter({ $0.academicScore != 0})
        filteredMatches.sort(by: {
            $0.academicScore > $1.academicScore
        })
        srcArray = filteredMatches
        UIView.animate(withDuration: 0.5, animations: {
            self.statsView.isHidden = true
            self.collectionTitle.isHidden = true
            self.starredCollectionView.isHidden = true

            for view in self.statsView.subviews {
                view.removeFromSuperview()
            }

            self.stringSAT = String(user.sat)
            self.stringACT = String(user.act)
            self.floatSAT = Float(user.sat)
            self.floatACT = Float(user.act)

            self.academicView!.initView(self.stringSAT, self.stringACT)
            self.academicView!.gpa.text = String(self.gpa)
            self.statsView.addSubview(self.academicView!)
            self.collectionTitle.text = "Top Academic Matches"
            self.starredCollectionView.reloadData()
            self.statsView.isHidden = false
            self.collectionTitle.isHidden = false
            self.starredCollectionView.isHidden = false

        }, completion: { fin in
            self.academicView!.animateSAT(self.floatSAT)
            self.academicView!.animateACT(self.floatACT)
            let prog = self.gpa / 4.0
            self.academicView!.animateProgress(prog)
        })
    }
    
    @IBAction func athleticPressed(_ sender: Any) {
        if selectedButton == athleticButton && !(sender is secondProfileViewController){
            return
        }
        athleticButton.setTitleColor(UIColor.white, for: .normal)
        //selectedButton!.setTitleColor(pheidiColors.pheidiGray, for: .normal)
        academicButton.setTitleColor(UIColor.gray, for: .normal)
        overviewButton.setTitleColor(UIColor.gray, for: .normal)
        selectedButton = athleticButton
        statsView.isHidden = true
        for view in self.statsView.subviews {
            view.removeFromSuperview()
        }
        //athleticView!.setup(["3200":"9:32", "1600":"4:32", "800":"2:00", "400":"55"])
        let avDict = setupAthleticView()
        athleticView!.setup(avDict)
        statsView.addSubview(athleticView!)
        self.collectionTitle.text = "Top Athletic Matches"
        
        srcArray = matchesArr.sorted(by: {
            Int($0.match)! < Int($1.match)!
        })
        
        
        self.starredCollectionView.reloadData()
        statsView.isHidden = false
    }
    
    @IBAction func editProfilePressed(_ sender: Any) {
        tabBarController?.selectedIndex = 4
    }
    
    
    func generateMatchTut()  -> BLTNPageItem {
        let page = BLTNPageItem(title: "Match Scores")
        page.appearance.titleTextColor = pheidiColors.pheidiTeal
        page.appearance.titleFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "ProximaNovaA-Bold"])
        page.appearance.descriptionFontDescriptor = UIFontDescriptor(fontAttributes: [.name : "ProximaNovaA-Light"])
        //page.image = UIImage(named: "schoolImage")
        page.descriptionText = "Match scores reflect the probability you will make the team at a specific school."
        page.actionButtonTitle = "NEXT"
        page.alternativeButtonTitle = "SKIP TUTORIAL"
        page.appearance.descriptionTextColor = .white
        page.appearance.actionButtonBorderColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonTitleColor = .black
        
        page.appearance.alternativeButtonTitleColor = pheidiColors.pheidiTeal
        page.next = generateD3Tut()
        
        page.actionHandler = {(item: BLTNActionItem) in
            item.manager?.displayNextItem()
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        
        page.alternativeHandler = {(item: BLTNActionItem) in
            item.manager?.dismissBulletin()
            UserDefaults.standard.set(true, forKey: "tutorial")
        }
        
        return page
    }
    
    func generateD3Tut() -> BLTNPageItem {
        let page = BLTNPageItem(title: "D3 Schools")
        page.descriptionText = "Your match scores at D3 schools is heavily influenced by your academic marks."
        page.appearance.titleTextColor = pheidiColors.pheidiTeal
        page.appearance.titleFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "ProximaNovaA-Bold"])
        page.appearance.descriptionFontDescriptor = UIFontDescriptor(fontAttributes: [.name : "ProximaNovaA-Light"])
        page.actionButtonTitle = "NEXT"
        page.alternativeButtonTitle = "SKIP TUTORIAL"
        page.appearance.descriptionTextColor = .white
        page.appearance.actionButtonBorderColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonTitleColor = .black
        
        page.appearance.alternativeButtonTitleColor = pheidiColors.pheidiTeal
        page.next = generateRecruitLevelTut()
        page.actionHandler = {(item: BLTNActionItem) in
            item.manager?.displayNextItem()
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        page.alternativeHandler = {(item: BLTNActionItem) in
            item.manager?.dismissBulletin()
            UserDefaults.standard.set(true, forKey: "tutorial")
        }
        return page
    }
    
    func generateRecruitLevelTut() -> BLTNPageItem {
        let page = BLTNPageItem(title: "Recruit Level")
        page.descriptionText = "Your recruit level is an estimation of the division you would be the most competitive in."
        page.appearance.titleTextColor = pheidiColors.pheidiTeal
        page.appearance.titleFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "ProximaNovaA-Bold"])
        page.appearance.descriptionFontDescriptor = UIFontDescriptor(fontAttributes: [.name : "ProximaNovaA-Light"])
        page.actionButtonTitle = "NEXT"
        page.alternativeButtonTitle = "SKIP TUTORIAL"
        page.appearance.descriptionTextColor = .white
        page.appearance.actionButtonBorderColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonTitleColor = .black
        
        page.appearance.alternativeButtonTitleColor = pheidiColors.pheidiTeal
        page.next = generateAddStatsTut()
        
        page.actionHandler = {(item: BLTNActionItem) in
            item.manager?.displayNextItem()
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        
        page.alternativeHandler = {(item: BLTNActionItem) in
            item.manager?.dismissBulletin()
            UserDefaults.standard.set(true, forKey: "tutorial")
        }
        
        return page
    }
    
    func generateAddStatsTut() -> BLTNPageItem {
        let page = BLTNPageItem(title: "Add Events")
        page.descriptionText = """
        Use the "+" button in the Edit tab to add events
        """
        page.appearance.titleTextColor = pheidiColors.pheidiTeal
        page.appearance.titleFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "ProximaNovaA-Bold"])
        page.appearance.descriptionFontDescriptor = UIFontDescriptor(fontAttributes: [.name : "ProximaNovaA-Light"])
        page.actionButtonTitle = "GOT IT"
        //page.alternativeButtonTitle = "SKIP TUTORIAL"
        page.appearance.descriptionTextColor = .white
        page.appearance.actionButtonBorderColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonColor = pheidiColors.pheidiTeal
        page.appearance.actionButtonTitleColor = .black
        
        //page.appearance.alternativeButtonTitleColor = pheidiColors.pheidiTeal
        page.actionHandler = {(item: BLTNActionItem) in
            item.manager?.dismissBulletin()
            UserDefaults.standard.set(true, forKey: "tutorial")
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
        return page
    }
    
    @IBAction func tutorialTapped(_ sender: Any) {
        bulletinManager.backgroundColor = .black
        bulletinManager.backgroundViewStyle = .blurredLight
        bulletinManager.showBulletin(above: self)
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
