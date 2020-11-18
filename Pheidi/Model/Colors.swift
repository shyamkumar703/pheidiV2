//
//  Colors.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/11/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import Foundation
import UIKit


var matchesArr: [University] = []
var smallMatchesArr: [University] = []
var distanceRankings: [University] = []
var sprintRankings: [University] = []
var jumpsRankings: [University] = []
var throwsRankings: [University] = []
var academicRankings: [University] = []
var linkUniDict: [String: University] = [:]
var userBestEvent: String = ""
var recDivisionArr: [University] = []
var topFinishersLinksArr: [String] = ["https://tx.milesplit.com/teams/670-texas-tech-university/roster", "https://tx.milesplit.com/teams/689-university-of-houston/roster", "https://ga.milesplit.com/teams/656-university-of-georgia/roster",
"https://ca.milesplit.com/teams/471-stanford-university/roster", "https://tx.milesplit.com/teams/571-texas-aandm-university/roster",
"https://la.milesplit.com/teams/760-louisiana-state-university-lsu/roster", "https://ut.milesplit.com/teams/1251-brigham-young-university/roster",
"https://tx.milesplit.com/teams/1242-university-of-texas/roster", "https://al.milesplit.com/teams/552-university-of-alabama/roster", "https://ar.milesplit.com/teams/484-university-of-arkansas/roster", "https://ca.milesplit.com/teams/15207-university-of-southern-california/roster",
"https://or.milesplit.com/teams/1252-university-of-oregon/roster", "https://nm.milesplit.com/teams/3933-university-of-new-mexico/roster",
"https://co.milesplit.com/teams/1229-university-of-colorado/roster"]
var topFinishersUni: [University] = []






public struct pheidiColors {
    static let pheidiTeal = UIColor(red:0.00, green:1.00, blue:0.80, alpha:1.0)
    static let pheidiGray = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1.0)
    
    static func addGradientToView(view: UIView)
    {
            //gradient layer
            let gradientLayer = CAGradientLayer()
            
            //define colors
        gradientLayer.colors = [pheidiColors.pheidiTeal.cgColor, UIColor.black.cgColor]
            
            //define locations of colors as NSNumbers in range from 0.0 to 1.0
            //if locations not provided the colors will spread evenly
        //gradientLayer.locations = [0.0, 0.4]
            
            //define frame
            gradientLayer.frame = view.bounds
            
            //insert the gradient layer to the view layer
            view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    static func addGradientColorToView(view: UIView, color: UIColor)
    {
            //gradient layer
            let gradientLayer = CAGradientLayer()
            
            //define colors
        gradientLayer.colors = [color.cgColor, UIColor.black.cgColor]
            
            //define locations of colors as NSNumbers in range from 0.0 to 1.0
            //if locations not provided the colors will spread evenly
        //gradientLayer.locations = [0.0, 0.4]
            
            //define frame
            gradientLayer.frame = view.bounds
            
            //insert the gradient layer to the view layer
            view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    static func addHorizontalGradientColorToView(view: UIView, color: UIColor)
    {
            //gradient layer
            let gradientLayer = CAGradientLayer()
            
            //define colors
        //gradientLayer.colors = [color.cgColor, UIColor.black.cgColor]
        //gradientLayer.colors = [color.cgColor, UIColor(red:0.10, green:0.10, blue:0.10, alpha:1.0).cgColor]
        gradientLayer.colors = [color.cgColor, UIColor(red:0.04, green:0.04, blue:0.04, alpha:1.0).cgColor]
            
            //define locations of colors as NSNumbers in range from 0.0 to 1.0
            //if locations not provided the colors will spread evenly
        //gradientLayer.locations = [0.0, 0.4]
            
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)

        // Set end point.
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            //define frame
            gradientLayer.frame = view.bounds
            
            //insert the gradient layer to the view layer
            view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    static func addBlackGradientToView(view: UIView)
    {
            //gradient layer
            let gradientLayer = CAGradientLayer()
            
            //define colors
        //gradientLayer.colors = [UIColor.black.cgColor, pheidiColors.pheidiTeal.cgColor]
//        gradientLayer.colors = [pheidiColors.pheidiTeal.cgColor, UIColor.black.cgColor]
        
        //gradientLayer.colors = [UIColor.black.cgColor, pheidiColors.pheidiTeal.cgColor]
        
            //define locations of colors as NSNumbers in range from 0.0 to 1.0
            //if locations not provided the colors will spread evenly
        gradientLayer.locations = [0.0, 0.2]
            
            //define frame
            gradientLayer.frame = view.bounds
            
            //insert the gradient layer to the view layer
            view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

public class University {
//    var name: String
//    var sat: String
//    var act: String
//    var gpa: String
//    var match: String
//    var focus: String
//    init(name: String, sat: String, act: String, gpa: String, match: String, focus: String) {
//        self.name = name
//        self.sat = sat
//        self.act = act
//        self.gpa = gpa
//        self.match = match
//        self.focus = focus
//    }
        var name: String =  ""
        var city: String =  ""
        var state: String = ""
        var accepRate: Double = 0.0
        var sat: Int = 0
        var act: Int = 0
        var gpa: String = "N/A"
        var gpaVal: Double = 0
        var mens100: Double = 0
        var womens100: Double = 0
        var mens200: Double = 0
        var womens200: Double = 0
        var mens400: Double = 0
        var womens400: Double = 0
        var mens800: Double = 0
        var womens800: Double = 0
        var mens1600: Double = 0
        var womens1600: Double = 0
        var mens3200: Double = 0
        var womens3200: Double = 0
        var mensShotput: Double = 0
        var womensShotput: Double = 0
        var mensDiscus: Double = 0
        var womensDiscus: Double = 0
        var mensHighJump: Double = 0
        var womensHighJump: Double = 0
        var mensLongJump: Double = 0
        var womensLongJump: Double = 0
        var mensTripleJump: Double = 0
        var womensTripleJump: Double = 0
        var mens300Hurdles: Double = 0
        var womens300Hurdles: Double = 0
        var mensPoleVault: Double = 0
        var womensPoleVault: Double = 0
        var match: String = "N/A"
        var focus: String = "Distance"
        var bestEvent: String = ""
        var aheadBy: Double = 0
        var distanceScore: Double = 0
        var sprintScore: Double = 0
        var jumpScore: Double = 0
        var throwsScore: Double = 0
        var academicScore: Double = 0
        var uniMarkBestEvent: Double = 0
        var userMarkBestEvent: Double = 0
        var key: String = ""
        var lowData: Bool = false
        var division: String = ""
        var coach: String = ""
        var email: String = ""
        var onlyWomen: Bool = false
        
        
        
        static func readDataFromFile(file: String) -> String! {
            guard let filepath = Bundle.main.path(forResource: file, ofType: "csv")
                else {
                    return nil
            }
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                print("Contents could not be loaded")
                return nil
            }
        }
    
    static func createDistanceRankings() {
        distanceRankings = []
        for currUni in uniList {
            var distanceArr: [Double]
            if user.gender == "Male" {
                distanceArr = [currUni.mens800, currUni.mens1600, currUni.mens3200]
            } else {
                distanceArr = [currUni.womens800, currUni.womens1600, currUni.womens3200]
            }
            distanceArr = distanceArr.filter {$0 != 0}
            if distanceArr.count == 3 {
                let sum = distanceArr.reduce(0, +)
                currUni.distanceScore = sum
                distanceRankings.append(currUni)
            }
        }
        distanceRankings.sort(by: {
            $0.distanceScore < $1.distanceScore
        })
    }
    
    static func createSprintRankings() {
        sprintRankings = []
        for currUni in uniList {
            var sprintArr: [Double]
            if user.gender == "Male" {
                sprintArr = [currUni.mens100, currUni.mens200, currUni.mens400]
            } else {
                sprintArr = [currUni.womens100, currUni.womens200, currUni.womens400]
            }
            sprintArr = sprintArr.filter {$0 != 0}
            if sprintArr.count == 3 {
                let sum = sprintArr.reduce(0, +)
                currUni.sprintScore = sum
                sprintRankings.append(currUni)
            }
        }
        sprintRankings.sort(by: {
            $0.sprintScore < $1.sprintScore
        })
    }
    
    static func createJumpRankings() {
        jumpsRankings = []
        for currUni in uniList {
            var jumpsArr: [Double]
            if user.gender == "Male" {
                jumpsArr = [currUni.mensHighJump, currUni.mensLongJump, currUni.mensTripleJump]
            } else {
                jumpsArr = [currUni.womensHighJump, currUni.womensLongJump, currUni.womensTripleJump]
            }
            jumpsArr = jumpsArr.filter {$0 != 0}
            if jumpsArr.count == 3 {
                let sum = jumpsArr.reduce(0, +)
                currUni.jumpScore = sum
                jumpsRankings.append(currUni)
            }
        }
        jumpsRankings.sort(by: {
            $0.jumpScore > $1.jumpScore
        })
    }
    
    static func createThrowsRankings() {
        throwsRankings = []
        for currUni in uniList {
            var throwsArr: [Double]
            if user.gender == "Male" {
                throwsArr = [currUni.mensDiscus, currUni.mensShotput]
            } else {
                throwsArr = [currUni.womensDiscus, currUni.womensShotput]
            }
            throwsArr = throwsArr.filter {$0 != 0}
            if throwsArr.count == 2 {
                let sum = throwsArr.reduce(0, +)
                currUni.throwsScore = sum
                throwsRankings.append(currUni)
            }
        }
        throwsRankings.sort(by: {
            $0.throwsScore > $1.throwsScore
        })
    }
    
    static func createAcademicRankings() {
        academicRankings = []
        for currUni in uniList {
            var academicArr: [Double] = [currUni.gpaVal, Double(currUni.sat), Double(currUni.act)]
            academicArr = academicArr.filter {$0 != 0}
            if academicArr.count == 3 {
                let sum = academicArr.reduce(0, +)
                currUni.academicScore = sum
                //academicRankings.append(currUni)
            }
        }
        matchesArr.sort(by: {
            $0.academicScore > $1.academicScore
        })
        academicRankings = matchesArr
    }
    
    func generateUniBestString() -> String {
        if ftEvents.contains(bestEvent) {
            let uniString = User.ftToString(uniMarkBestEvent * 12)
            return uniString
        } else if doubleEvents.contains(valKeyDict[bestEvent] ?? "") {
            let uniString = User.doubleToString(uniMarkBestEvent)
            return uniString
        } else {
            let uniString = User.secsToString(Int(uniMarkBestEvent))
            return uniString
        }
    }
        
        static func createUniversityList() {
            //let contents = University.readDataFromFile(file: "finalPheidiData")!
            //let contents = University.readDataFromFile(file: "finalPheidiDataDivision")!
            let contents = University.readDataFromFile(file: "full_data")!
            let universityList = contents.components(separatedBy: "\n").map{ $0.components(separatedBy: ",") }
            print(universityList[1])
            for index in 1...universityList.count - 1 {
                let currUni = University()
                let currArr = universityList[index]
                if currArr.count <= 1 {
                    return
                }
                if currArr[1].contains("\"") {
                    continue
                }
                currUni.name = currArr[1]
                currUni.city = currArr[2]
                currUni.state = currArr[3]
                let divString = currArr[63]
                let coach = currArr[64]
                let email = currArr[65]
                let onlyWomen = currArr[66]
                if coach != "" && coach != "nan" && coach != "None" && coach != "NaN" {
                    currUni.coach = coach
                    currUni.email = email
                }
                

                if onlyWomen == "Yes" {
                    if user.gender == "Male" {
                        continue
                    }
                }
                
                if divString.contains("Division 1") {
                    currUni.division = "Division 1"
                } else if divString.contains("Division 2"){
                    currUni.division = "Division 2"
                } else if divString.contains("Division 3") {
                    currUni.division = "Division 3"
                } else if divString.contains("NAIA") {
                    currUni.division = "NAIA"
                }
                
                if currArr[4] != "nan" {
                    let accepRateString = currArr[4].replacingOccurrences(of: "%", with: "")
                    currUni.accepRate = Double(accepRateString) ?? 0
                }
                if currArr[5] != "nan" {
                    if index == 3 {
                        print("hello")
                    }
                    currUni.sat = Int(currArr[5]) ?? 0
                }
                if currArr[7] != "nan" {
                    let actMin = Int(currArr[7]) ?? 0
    //                let actMax = Int(currArr[8]) ?? 0
                    currUni.act = actMin
                }
                if currArr[9] != "nan" {
                    currUni.gpa = (currArr[9])
                    currUni.gpaVal = Double(currArr[9]) ?? 0
                }
                if currArr[12] != "nan" {
                    currUni.mens100 = Double(currArr[12]) ?? 0
                }
                if currArr[14] != "nan" {
                    currUni.womens100 = Double(currArr[14]) ?? 0
                }
                if currArr[16] != "nan" {
                    currUni.mens200 = Double(currArr[16]) ?? 0
                }
                if currArr[18] != "nan" {
                    currUni.womens200 = Double(currArr[18]) ?? 0
                }
                if currArr[20] != "nan" {
                    currUni.mens400 = Double(currArr[20]) ?? 0
                }
                if currArr[22] != "nan" {
                    currUni.womens400 = Double(currArr[22]) ?? 0
                }
                if currArr[24] != "nan" {
                    currUni.mens800 = Double(currArr[24]) ?? 0
                }
                if currArr[26] != "nan" {
                    currUni.womens800 = Double(currArr[26]) ?? 0
                }
                if currArr[28] != "nan" {
                    currUni.mens1600 = Double(currArr[28]) ?? 0
                }
                if currArr[30] != "nan" {
                    currUni.womens1600 = Double(currArr[30]) ?? 0
                }
                if currArr[32] != "nan" {
                    currUni.mens3200 = Double(currArr[32]) ?? 0
                }
                if currArr[34] != "nan" {
                    currUni.womens3200 = Double(currArr[34]) ?? 0
                }
                if currArr[35] != "nan" {
                    currUni.mensShotput = Double(currArr[36]) ?? 0
                }
                if currArr[37] != "nan" {
                    currUni.womensShotput = Double(currArr[38]) ?? 0
                }
                if currArr[39] != "nan" {
                    currUni.mensDiscus = Double(currArr[40]) ?? 0
                }
                if currArr[41] != "nan" {
                    currUni.womensDiscus = Double(currArr[42]) ?? 0
                }
                if currArr[43] != "nan" {
                    currUni.mensHighJump = Double(currArr[43]) ?? 0
                }
                if currArr[45] != "nan" {
                    currUni.womensHighJump = Double(currArr[45]) ?? 0
                }
                if currArr[47] != "nan" {
                    currUni.mensLongJump = Double(currArr[47]) ?? 0
                }
                if currArr[49] != "None" {
                    currUni.womensLongJump = Double(currArr[49]) ?? 0
                }
                if currArr[51] != "None" {
                    currUni.mensTripleJump = Double(currArr[51]) ?? 0
                }
                if currArr[53] != "None" {
                    currUni.womensTripleJump = Double(currArr[53]) ?? 0
                }
                if currArr[56] != "None" {
                    currUni.mens300Hurdles = Double(currArr[56]) ?? 0
                }
                if currArr[58] != "None" {
                    currUni.womens300Hurdles = Double(currArr[58]) ?? 0
                }
                if currArr[60] != "None" {
                    currUni.mensPoleVault = Double(currArr[60]) ?? 0
                }
                if currArr[62] != "None" {
                    currUni.womensPoleVault = Double(currArr[62]) ?? 0
                }
                if currUni.name == "San Diego State" {
                    print("in")
                }
                uniList.append(currUni)
                let link = currArr[0]
                currUni.key = link
                linkUniDict[link] = currUni
                
            }
        }
    
    static func createTopFinishersArr() {
        topFinishersUni = []
        for link in topFinishersLinksArr {
            let currUni = linkUniDict[link]
            topFinishersUni.append(currUni!)
        }
    }
    
    static func calculateMatchRate(_ userMark: Double, _ uniMark: Double, _ fieldEvent: Bool) -> Double {
        if !fieldEvent {
            let prop = (userMark - uniMark) / uniMark
            let matchRate = 1 - (prop * 10)
            if matchRate < 0 {
                return 0
            } else if matchRate > 1 {
                return 1
            } else {
                return matchRate
            }
        } else {
            let prop = (uniMark - userMark) / userMark
            let matchRate = 1 - (prop * 10)
            if matchRate < 0 {
                return 0
            } else if matchRate > 1 {
                return 1
            } else {
                return matchRate
            }
        }
    }
    
    static func loadMatchesMale() {
        matchesArr = []
        var bestEventDict: [String: Int] = [:]
        for currUni in uniList {
            if currUni.onlyWomen {
                continue
            }
            var uniMarkBestEvent: Double = 0
            var userMarkBestEvent: Double = 0
            var bestEvent = ""
            var bestMatch: Double = 0
            var aheadBy: Double = 0
            
            for event in user.currEvents {
                switch event {
                case "3200M":
                    if currUni.mens3200 == 0 {
                        continue
                    }
                    if Double(user.twoMile) < currUni.mens3200 {
                        bestEvent = "3200M"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.twoMile), currUni.mens3200, false))
                        uniMarkBestEvent = currUni.mens3200
                        userMarkBestEvent = Double(user.twoMile)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.twoMile), currUni.mens3200, false)
                        if matchRate >= bestMatch {
                            bestEvent = "3200M"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mens3200
                            userMarkBestEvent = Double(user.twoMile)
                        }
                    }
                case "1600M":
                    if currUni.mens1600 == 0 {
                        continue
                    }
                    if Double(user.mile) < currUni.mens1600 {
                        bestEvent = "1600M"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.mile), currUni.mens1600, false))
                        uniMarkBestEvent = currUni.mens1600
                        userMarkBestEvent = Double(user.mile)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.mile), currUni.mens1600, false)
                        if matchRate >= bestMatch {
                            bestEvent = "1600M"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mens1600
                            userMarkBestEvent = Double(user.mile)
                        }
                    }
                case "100M":
                    if currUni.mens100 == 0 {
                        continue
                    }
                    if Double(user.onehundredm) < currUni.mens100 {
                        bestEvent = "100M"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.onehundredm), currUni.mens100, false))
                        uniMarkBestEvent = currUni.mens100
                        userMarkBestEvent = Double(user.onehundredm)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.onehundredm), currUni.mens100, false)
                        if matchRate >= bestMatch {
                            bestEvent = "100M"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mens100
                            userMarkBestEvent = Double(user.onehundredm)
                        }
                    }
                case "200M":
                    if currUni.mens200 == 0 {
                        continue
                    }
                    if Double(user.twohundredm) < currUni.mens200 {
                        bestEvent = "200M"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.twohundredm), currUni.mens200, false))
                        uniMarkBestEvent = currUni.mens200
                        userMarkBestEvent = Double(user.twohundredm)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.twohundredm), currUni.mens200, false)
                        if matchRate >= bestMatch {
                            bestEvent = "200M"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mens200
                            userMarkBestEvent = Double(user.twohundredm)
                        }
                    }
                case "400M":
                    if currUni.mens400 == 0 {
                        continue
                    }
                    if Double(user.fourhundredm) < currUni.mens400 {
                        bestEvent = "400M"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.fourhundredm), currUni.mens400, false))
                        uniMarkBestEvent = currUni.mens400
                        userMarkBestEvent = Double(user.fourhundredm)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.fourhundredm), currUni.mens400, false)
                        if matchRate >= bestMatch {
                            bestEvent = "400M"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mens400
                            userMarkBestEvent = Double(user.fourhundredm)
                        }
                    }
                case "800M":
                    if currUni.mens800 == 0 {
                        continue
                    }
                    if Double(user.eighthundredm) < currUni.mens800 {
                        bestEvent = "800M"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.eighthundredm), currUni.mens800, false))
                        uniMarkBestEvent = currUni.mens800
                        userMarkBestEvent = Double(user.eighthundredm)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.eighthundredm), currUni.mens800, false)
                        if matchRate >= bestMatch {
                            bestEvent = "800M"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mens800
                            userMarkBestEvent = Double(user.eighthundredm)
                        }
                    }
                case "300M Hurdles":
                    if currUni.mens300Hurdles == 0 {
                        continue
                    }
                    if Double(user.threehundredHurdles) < currUni.mens300Hurdles {
                        bestEvent = "300M Hurdles"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.threehundredHurdles), currUni.mens300Hurdles, false))
                        uniMarkBestEvent = currUni.mens300Hurdles
                        userMarkBestEvent = Double(user.threehundredHurdles)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.threehundredHurdles), currUni.mens300Hurdles, false)
                        if matchRate >= bestMatch {
                            bestEvent = "300M Hurdles"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mens300Hurdles
                            userMarkBestEvent = Double(user.threehundredHurdles)
                        }
                    }
                case "Shotput":
                    if currUni.mensShotput == 0 {
                        continue
                    } else if (currUni.mensShotput) < 15 {
                        continue
                    }
                    if Double(user.shotput) > (currUni.mensShotput * 12.0) {
                        bestEvent = "Shotput"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.shotput), currUni.mensShotput, true))
                        uniMarkBestEvent = currUni.mensShotput
                        userMarkBestEvent = Double(user.shotput)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.shotput), currUni.mensShotput * 12.0, true)
                        if matchRate >= bestMatch {
                            bestEvent = "Shotput"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mensShotput
                            userMarkBestEvent = Double(user.shotput)
                        }
                    }
                case "Discus":
                    if currUni.mensDiscus == 0 {
                        continue
                    } else if (currUni.mensDiscus) < 15 {
                        continue
                    }
                    if Double(user.discus) > (currUni.mensDiscus * 12.0) {
                        bestEvent = "Discus"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.discus), currUni.mensDiscus, true))
                        uniMarkBestEvent = currUni.mensDiscus
                        userMarkBestEvent = Double(user.discus)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.discus), currUni.mensDiscus * 12.0, true)
                        if matchRate >= bestMatch {
                            bestEvent = "Discus"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mensDiscus
                            userMarkBestEvent = Double(user.discus)
                        }
                    }
                case "High Jump":
                    if currUni.mensHighJump == 0 {
                        continue
                    }
                    if Double(user.highJump) > (currUni.mensHighJump * 12.0) {
                        bestEvent = "High Jump"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.highJump), currUni.mensHighJump, true))
                        uniMarkBestEvent = currUni.mensHighJump
                        userMarkBestEvent = Double(user.highJump)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.highJump), currUni.mensHighJump * 12.0, true)
                        if matchRate >= bestMatch {
                            bestEvent = "High Jump"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mensHighJump
                            userMarkBestEvent = Double(user.highJump)
                        }
                    }
                case "Long Jump":
                    if currUni.mensLongJump == 0 {
                        continue
                    }
                    if Double(user.longJump) > (currUni.mensLongJump * 12.0) {
                        bestEvent = "Long Jump"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.longJump), currUni.mensLongJump, true))
                        uniMarkBestEvent = currUni.mensLongJump
                        userMarkBestEvent = Double(user.longJump)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.longJump), currUni.mensLongJump * 12.0, true)
                        if matchRate >= bestMatch {
                            bestEvent = "Long Jump"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mensLongJump
                            userMarkBestEvent = Double(user.longJump)
                        }
                    }
                case "Triple Jump":
                    if currUni.mensTripleJump == 0 {
                        continue
                    }
                    if Double(user.tripleJump) > (currUni.mensTripleJump * 12.0) {
                        bestEvent = "Triple Jump"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.tripleJump), currUni.mensTripleJump, true))
                        uniMarkBestEvent = currUni.mensTripleJump
                        userMarkBestEvent = Double(user.tripleJump)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.tripleJump), currUni.mensTripleJump * 12.0, true)
                        if matchRate >= bestMatch {
                            bestEvent = "Triple Jump"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mensTripleJump
                            userMarkBestEvent = Double(user.tripleJump)
                        }
                    }
                case "Pole Vault":
                    if currUni.mensPoleVault == 0 {
                        continue
                    }
                    if Double(user.poleVault) > (currUni.mensPoleVault * 12.0) {
                        bestEvent = "Pole Vault"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.poleVault), currUni.mensPoleVault, true))
                        uniMarkBestEvent = currUni.mensPoleVault
                        userMarkBestEvent = Double(user.poleVault)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.poleVault), currUni.mensPoleVault * 12.0, true)
                        if matchRate >= bestMatch {
                            bestEvent = "Pole Vault"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.mensPoleVault
                            userMarkBestEvent = Double(user.poleVault)
                        }
                    }
                default:
                    continue
                }
            }
            
            if uniMarkBestEvent == 0 {
                currUni.lowData = true
                continue
            } else {
                currUni.lowData = false
            }
            
            currUni.uniMarkBestEvent = uniMarkBestEvent
            currUni.userMarkBestEvent = userMarkBestEvent
            currUni.bestEvent = bestEvent
            if currUni.bestEvent != "" {
                if bestEventDict[currUni.bestEvent] != nil {
                    bestEventDict[currUni.bestEvent]! += 1
                } else {
                    bestEventDict[currUni.bestEvent] = 1
                }
            }
            if currUni.division == "Division 3" && currUni.gpaVal != 0 {
                var academicMatch: Double
                if  user.gpa > currUni.gpaVal {
                    academicMatch = 5
                } else {
                    academicMatch = ((currUni.gpaVal - user.gpa) / currUni.gpaVal) * 5
                }
                bestMatch = (academicMatch + bestMatch) / 6
            }
            
            if bestMatch > 1 {
                bestMatch = 1
            } else if bestMatch < 0 {
                bestMatch = 0
            }
            
            currUni.match = String(Int(bestMatch * 100))
            if bestMatch >= 0.6 {
                matchesArr.append(currUni)
            }
            if aheadBy != 0 {
                currUni.aheadBy = aheadBy
            }
        }
        let numDivOne = uniList.filter({$0.division == "Division 1"})
        let numDivTwo = uniList.filter({$0.division == "Division 2"})
        let numDivThree = uniList.filter({$0.division == "Division 3"})
        let numNAIA = uniList.filter({$0.division == "NAIA"})
        
        let divOneMatches = numDivOne.filter({$0.match != "N/A"}).filter({Int($0.match)! >= 60})
        let divTwoMatches = numDivTwo.filter({$0.match != "N/A"}).filter({Int($0.match)! >= 60})
        let divThreeMatches = numDivThree.filter({$0.match != "N/A"}).filter({Int($0.match)! >= 60})
        let divNAIAMatches = numNAIA.filter({$0.match != "N/A"}).filter({Int($0.match)! >= 60})
        
        if Double(divOneMatches.count) / Double(numDivOne.count) >= 0.6 {
            user.division = "Division 1"
            recDivisionArr = numDivOne
        } else if Double(divTwoMatches.count) / Double(numDivTwo.count) >= 0.6 {
            user.division = "Division 2"
            recDivisionArr = numDivTwo
        } else if Double(divThreeMatches.count) / Double(numDivThree.count) >= 0.6 {
            user.division = "Division 3"
            recDivisionArr = numDivThree
        } else {
            user.division = "NAIA"
            recDivisionArr = numNAIA
        }
        
        if user.currEvents.count == 0 {
            user.bestEventMark = 0
            user.bestEventString = ""
            return
        }
        
        var userBestEvent:[String: [Double]] = [:]
        for uni in divOneMatches + divTwoMatches {
            if userBestEvent[uni.bestEvent] == nil {
                userBestEvent[uni.bestEvent] = [Double(1), uni.userMarkBestEvent]
            } else {
                let currCount = userBestEvent[uni.bestEvent]![0]
                userBestEvent[uni.bestEvent] = [Double(currCount + 1), uni.userMarkBestEvent]
            }
        }
        var bestCount: Double = 0
        var bestEvent: String = ""
        var bestMark: Double = 0
        for (key, value) in userBestEvent {
            if value[0] > bestCount {
                bestCount = value[0]
                bestEvent = key
                bestMark = value[1]
            }
        }
        user.bestEventMark = bestMark
        user.bestEventString = bestEvent
        
        smallMatchesArr = Array(matchesArr.prefix(10))
    }
    
    
    
    
    static func loadMatchesFemale() {
        matchesArr = []
        for currUni in uniList {
            var bestEvent = ""
            var bestMatch: Double = 0
            var aheadBy: Double = 0
            var uniMarkBestEvent: Double = 0
            var userMarkBestEvent: Double = 0
            for event in user.currEvents {
                switch event {
                case "3200M":
                    if currUni.womens3200 == 0 {
                        continue
                    }
                    if Double(user.twoMile) < currUni.womens3200 {
                        bestEvent = "3200M"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.twoMile), currUni.womens3200, false))
                        uniMarkBestEvent = currUni.womens3200
                        userMarkBestEvent = Double(user.twoMile)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.twoMile), currUni.womens3200, false)
                        if matchRate >= bestMatch {
                            bestEvent = "3200M"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womens3200
                            userMarkBestEvent = Double(user.twoMile)
                        }
                    }
                case "1600M":
                    if currUni.womens1600 == 0 {
                        continue
                    }
                    if Double(user.mile) < currUni.womens1600 {
                        bestEvent = "1600M"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.mile), currUni.womens1600, false))
                        uniMarkBestEvent = currUni.womens1600
                        userMarkBestEvent = Double(user.mile)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.mile), currUni.womens1600, false)
                        if matchRate >= bestMatch {
                            bestEvent = "1600M"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womens1600
                            userMarkBestEvent = Double(user.mile)
                        }
                    }
                case "100M":
                    if currUni.womens100 == 0 {
                        continue
                    }
                    if Double(user.onehundredm) < currUni.womens100 {
                        bestEvent = "100M"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.onehundredm), currUni.womens100, false))
                        uniMarkBestEvent = currUni.womens100
                        userMarkBestEvent = Double(user.onehundredm)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.onehundredm), currUni.womens100, false)
                        if matchRate >= bestMatch {
                            bestEvent = "100M"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womens100
                            userMarkBestEvent = Double(user.onehundredm)
                        }
                    }
                case "200M":
                    if currUni.womens200 == 0 {
                        continue
                    }
                    if Double(user.twohundredm) < currUni.womens200 {
                        bestEvent = "200M"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.twohundredm), currUni.womens200, false))
                        uniMarkBestEvent = currUni.womens200
                        userMarkBestEvent = Double(user.twohundredm)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.twohundredm), currUni.womens200, false)
                        if matchRate >= bestMatch {
                            bestEvent = "200M"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womens200
                            userMarkBestEvent = Double(user.twohundredm)
                        }
                    }
                case "400M":
                    if currUni.womens400 == 0 {
                        continue
                    }
                    if Double(user.fourhundredm) < currUni.womens400 {
                        bestEvent = "400M"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.fourhundredm), currUni.womens400, false))
                        uniMarkBestEvent = currUni.womens400
                        userMarkBestEvent = Double(user.fourhundredm)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.fourhundredm), currUni.womens400, false)
                        if matchRate >= bestMatch {
                            bestEvent = "400M"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womens400
                            userMarkBestEvent = Double(user.fourhundredm)
                        }
                    }
                case "800M":
                    if currUni.mens800 == 0 {
                        continue
                    }
                    if Double(user.eighthundredm) < currUni.womens800 {
                        bestEvent = "800M"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.eighthundredm), currUni.womens800, false))
                        uniMarkBestEvent = currUni.womens800
                        userMarkBestEvent = Double(user.eighthundredm)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.eighthundredm), currUni.womens800, false)
                        if matchRate >= bestMatch {
                            bestEvent = "800M"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womens800
                            userMarkBestEvent = Double(user.eighthundredm)
                        }
                    }
                case "300M Hurdles":
                    if currUni.womens300Hurdles == 0 {
                        continue
                    }
                    if Double(user.threehundredHurdles) < currUni.womens300Hurdles {
                        bestEvent = "300M Hurdles"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.threehundredHurdles), currUni.womens300Hurdles, false))
                        uniMarkBestEvent = currUni.womens300Hurdles
                        userMarkBestEvent = Double(user.threehundredHurdles)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.threehundredHurdles), currUni.womens300Hurdles, false)
                        if matchRate >= bestMatch {
                            bestEvent = "300M Hurdles"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womens300Hurdles
                            userMarkBestEvent = Double(user.threehundredHurdles)
                        }
                    }
                case "Shotput":
                    if currUni.womensShotput == 0 {
                        continue
                    } else if (currUni.womensShotput) < 15 {
                        continue
                    }
                    if Double(user.shotput) > (currUni.womensShotput * 12.0) {
                        bestEvent = "Shotput"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.shotput), currUni.womensShotput, true))
                        uniMarkBestEvent = currUni.womensShotput
                        userMarkBestEvent = Double(user.shotput)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.shotput), currUni.womensShotput * 12.0, true)
                        if matchRate >= bestMatch {
                            bestEvent = "Shotput"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womensShotput
                            userMarkBestEvent = Double(user.shotput)
                        }
                    }
                case "Discus":
                    if currUni.womensDiscus == 0 {
                        continue
                    } else if (currUni.womensDiscus) < 15 {
                        continue
                    }
                    if Double(user.discus) > (currUni.womensDiscus * 12.0) {
                        bestEvent = "Discus"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.discus), currUni.womensDiscus, true))
                        uniMarkBestEvent = currUni.womensDiscus
                        userMarkBestEvent = Double(user.discus)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.discus), currUni.womensDiscus * 12.0, true)
                        if matchRate >= bestMatch {
                            if matchRate > 1 {
                                print("whoops")
                            }
                            bestEvent = "Discus"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womensDiscus
                            userMarkBestEvent = Double(user.discus)
                        }
                    }
                case "High Jump":
                    if currUni.womensHighJump == 0 {
                        continue
                    }
                    if Double(user.highJump) > (currUni.womensHighJump * 12.0) {
                        bestEvent = "High Jump"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.highJump), currUni.womensHighJump, true))
                        uniMarkBestEvent = currUni.womensHighJump
                        userMarkBestEvent = Double(user.highJump)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.highJump), currUni.womensHighJump * 12.0, true)
                        if matchRate >= bestMatch {
                            bestEvent = "High Jump"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womensHighJump
                            userMarkBestEvent = Double(user.highJump)
                        }
                    }
                case "Long Jump":
                    if currUni.womensLongJump == 0 {
                        continue
                    }
                    if Double(user.longJump) > (currUni.womensLongJump * 12.0) {
                        bestEvent = "Long Jump"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.longJump), currUni.womensLongJump, true))
                        uniMarkBestEvent = currUni.womensLongJump
                        userMarkBestEvent = Double(user.longJump)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.longJump), currUni.womensLongJump * 12.0, true)
                        if matchRate >= bestMatch {
                            bestEvent = "Long Jump"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womensLongJump
                            userMarkBestEvent = Double(user.longJump)
                        }
                    }
                case "Triple Jump":
                    if currUni.womensTripleJump == 0 {
                        continue
                    }
                    if Double(user.tripleJump) > (currUni.womensTripleJump * 12.0) {
                        bestEvent = "Triple Jump"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.tripleJump), currUni.womensTripleJump, true))
                        uniMarkBestEvent = currUni.womensTripleJump
                        userMarkBestEvent = Double(user.tripleJump)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.tripleJump), currUni.womensTripleJump * 12.0, true)
                        if matchRate >= bestMatch {
                            bestEvent = "Triple Jump"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womensTripleJump
                            userMarkBestEvent = Double(user.tripleJump)
                        }
                    }
                case "Pole Vault":
                    if currUni.womensPoleVault == 0 {
                        continue
                    }
                    if Double(user.poleVault) > (currUni.womensPoleVault * 12.0) {
                        bestEvent = "Pole Vault"
                        bestMatch = 1
                        aheadBy = abs(calculateMatchRate(Double(user.poleVault), currUni.womensPoleVault, true))
                        uniMarkBestEvent = currUni.womensPoleVault
                        userMarkBestEvent = Double(user.poleVault)
                    } else {
                        let matchRate = calculateMatchRate(Double(user.poleVault), currUni.womensPoleVault * 12.0, true)
                        if matchRate >= bestMatch {
                            bestEvent = "Pole Vault"
                            bestMatch = matchRate
                            uniMarkBestEvent = currUni.womensPoleVault
                            userMarkBestEvent = Double(user.poleVault)
                        }
                    }
                default:
                    continue
                }
            }
            if uniMarkBestEvent == 0 {
                currUni.lowData = true
                continue
            } else {
                currUni.lowData = false
            }
            currUni.uniMarkBestEvent = uniMarkBestEvent
            currUni.userMarkBestEvent = userMarkBestEvent
            currUni.bestEvent = bestEvent
            if currUni.division == "Division 3" && currUni.gpaVal != 0 {
                var academicMatch: Double
                if  user.gpa > currUni.gpaVal {
                    academicMatch = 5
                } else {
                    academicMatch = ((currUni.gpaVal - user.gpa) / currUni.gpaVal) * 5
                }
                bestMatch = (academicMatch + bestMatch) / 5
            }
            
            if bestMatch > 1 {
                bestMatch = 1
            } else if bestMatch < 0 {
                bestMatch = 0
            }
            
            currUni.match = String(Int(bestMatch * 100))
            
            if bestMatch >= 0.6 {
                matchesArr.append(currUni)
            }
            if aheadBy != 0 {
                currUni.aheadBy = aheadBy
            }
        }
        
        let numDivOne = uniList.filter({$0.division == "Division 1"})
        let numDivTwo = uniList.filter({$0.division == "Division 2"})
        let numDivThree = uniList.filter({$0.division == "Division 3"})
        let numNAIA = uniList.filter({$0.division == "NAIA"})
        
        let divOneMatches = numDivOne.filter({$0.match != "N/A"}).filter({Int($0.match)! >= 60})
        let divTwoMatches = numDivTwo.filter({$0.match != "N/A"}).filter({Int($0.match)! >= 60})
        let divThreeMatches = numDivThree.filter({$0.match != "N/A"}).filter({Int($0.match)! >= 60})
        let divNAIAMatches = numNAIA.filter({$0.match != "N/A"}).filter({Int($0.match)! >= 60})
        
        if Double(divOneMatches.count) / Double(numDivOne.count) >= 0.6 {
            user.division = "Division 1"
            recDivisionArr = numDivOne
        } else if Double(divTwoMatches.count) / Double(numDivTwo.count) >= 0.6 {
            user.division = "Division 2"
            recDivisionArr = numDivTwo
        } else if Double(divThreeMatches.count) / Double(numDivThree.count) >= 0.6 {
            user.division = "Division 3"
            recDivisionArr = numDivThree
        } else {
            user.division = "NAIA"
            recDivisionArr = numNAIA
        }
        
        if user.currEvents.count == 0 {
            user.bestEventMark = 0
            user.bestEventString = ""
            return
        }
        
        var userBestEvent:[String: [Double]] = [:]
        for uni in divOneMatches + divTwoMatches {
            if userBestEvent[uni.bestEvent] == nil {
                userBestEvent[uni.bestEvent] = [Double(1), uni.userMarkBestEvent]
            } else {
                let currCount = userBestEvent[uni.bestEvent]![0]
                userBestEvent[uni.bestEvent] = [Double(currCount + 1), uni.userMarkBestEvent]
            }
        }
        var bestCount: Double = 0
        var bestEvent: String = ""
        var bestMark: Double = 0
        for (key, value) in userBestEvent {
            if value[0] > bestCount {
                bestCount = value[0]
                bestEvent = key
                bestMark = value[1]
            }
        }
        user.bestEventMark = bestMark
        user.bestEventString = bestEvent
        
        smallMatchesArr = Array(matchesArr.prefix(10))
    }
}
