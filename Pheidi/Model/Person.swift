//
//  Person.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/22/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
var user = User()
let statSettings: [String: [Double]] = ["GPA": [0.0, 5.0], "SAT": [400, 1600], "ACT": [1, 36], "100M": [9.0, 25.0], "200M": [18.0, 50.0], "400M": [40.0, 180.0], "800M": [100, 240], "1600M": [220.0, 600], "3200M": [480, 1200], "High Jump": [0, 96], "Long Jump": [0, 360], "Triple Jump": [0, 720], "Shotput": [0, 912], "Discus": [0, 2952], "110M Hurdles": [0, 50], "300M Hurdles": [0, 180], "Pole Vault": [0, 252]]

let doubleEvents: [String] = ["eighthundredm", "fourhundredm", "longJump", "tripleJump", "onehundredm", "twohundredm", "gpa", "shotput", "discus", "highJump", "longJump", "tripleJump", "onetenHurdles", "threehundredHurdles", "poleVault"]
let intEvents: [String] = ["twoMile", "mile", "sat", "act"]

let ftEvents: [String] = ["Shotput", "Discus", "Long Jump", "High Jump", "Triple Jump", "Pole Vault"]

let academicArr: [String] = ["GPA", "SAT", "ACT"]

let valKeyDict: [String: String] = ["SAT": "sat", "ACT": "act", "GPA": "gpa",
                                    "3200M": "twoMile", "Discus": "discus", "800M": "eighthundredm", "400M": "fourhundredm", "High Jump": "highJump", "Long Jump": "longJump", "Triple Jump": "tripleJump", "1600M": "mile", "100M": "onehundredm", "200M": "twohundredm", "Shotput": "shotput", "110M Hurdles": "onetenHurdles", "300M Hurdles": "threehundredHurdles", "Pole Vault": "poleVault"]

public class User {
    var name: String = ""
    var sat : Int = 0
    var act: Int = 0
    var gpa: Double = 0
    var twoMile: Int = 0
    var statArr: [String] = []
    var discus: Double = 0
    var eighthundredm: Double = 0
    var fourhundredm: Double = 0
    var highJump: Double = 0
    var longJump: Double = 0
    var tripleJump: Double = 0
    var mile: Int = 0
    var onehundredm: Double = 0
    var twohundredm: Double = 0
    var shotput: Double = 0
    var onetenHurdles: Double = 0
    var threehundredHurdles: Double = 0
    var poleVault: Double = 0
    var currEvents: [String] = []
    var eventGroup: String = ""
    var gender = ""
    var starredUniversities: [String] = []
    var contactedUniversities: [String] = []
    var division: String = ""
    var bestEventString: String = ""
    var bestEventMark: Double = 0
    
    func getBestEventString() -> String {
        if ftEvents.contains(bestEventString) {
            return User.ftToString(bestEventMark)
        } else if doubleEvents.contains(valKeyDict[bestEventString] ?? "") {
            return User.doubleToString(bestEventMark)
        } else {
            return User.secsToString(Int(bestEventMark))
        }
    }
    
    
    func makeMailString(_ coachName: String) -> String {
        if user.statArr.contains("SAT") && user.statArr.contains("ACT") && user.statArr.contains("GPA") {
            return "Hi Coach \(coachName), \nMy name is \(name) and I'm very interested in your school. I have posted a mark of \(getBestEventString()) for the \(bestEventString). Academically, I have a \(gpa.truncate(places: 2)) GPA, scored \(user.sat) on the SAT, and scored \(user.act) on the ACT. Please let me know if you'd be interested. Thanks!"
        } else if user.statArr.contains("SAT") && user.statArr.contains("GPA")  {
            return "Hi Coach \(coachName), \nMy name is \(name) and I'm very interested in your school. I have posted a mark of \(getBestEventString()) for the \(bestEventString). Academically, I have a \(gpa.truncate(places: 2)) GPA and I scored \(user.sat) on the SAT. Please let me know if you'd be interested. Thanks!"
        } else if user.statArr.contains("ACT") && user.statArr.contains("GPA")  {
            return "Hi Coach \(coachName), \nMy name is \(name) and I'm very interested in your school. I have posted a mark of \(getBestEventString()) for the \(bestEventString). Academically, I have a \(gpa.truncate(places: 2)) GPA and I scored \(user.act) on the ACT. Please let me know if you'd be interested. Thanks!"
        } else if user.statArr.contains("GPA")  {
            return "Hi Coach \(coachName), \nMy name is \(name) and I'm very interested in your school. I have posted a mark of \(getBestEventString()) for the \(bestEventString). Academically, I have a \(gpa.truncate(places: 2)) GPA. Please let me know if you'd be interested. Thanks!"
        } else {
            return "Hi Coach \(coachName), \nMy name is \(name) and I'm very interested in your school. I have posted a mark of \(getBestEventString()) for the \(bestEventString). Please let me know if you'd be interested. Thanks!"
        }
    }
    
    func populateUserAtLaunch() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
                //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            let name = lastPerson.value(forKey: "name") as! String
            let eventGroup = lastPerson.value(forKey: "eventGroup") as! String
            let sat = lastPerson.value(forKey: "sat") as! Int16
            let act = lastPerson.value(forKey: "act") as! Int16
            let gpa = lastPerson.value(forKey: "gpa") as! Double
            let twoMile = lastPerson.value(forKey: "twoMile") as! Int16
            let discus = lastPerson.value(forKey: "discus") as! Double
            let eighthundredm = lastPerson.value(forKey: "eighthundredm") as! Double
            let fourhundredm = lastPerson.value(forKey: "fourhundredm") as! Double
            let highJump = lastPerson.value(forKey: "highJump") as! Double
            let longJump = lastPerson.value(forKey: "longJump") as! Double
            let tripleJump = lastPerson.value(forKey: "tripleJump") as! Double
            let mile = lastPerson.value(forKey: "mile") as! Int16
            let onehundredm = lastPerson.value(forKey: "onehundredm") as! Double
            let twohundredm = lastPerson.value(forKey: "twohundredm") as! Double
            let shotput = lastPerson.value(forKey: "shotput") as! Double
            let onetenHurdles = lastPerson.value(forKey: "onetenHurdles") as! Double
            let threehundredHurdles = lastPerson.value(forKey: "threehundredHurdles") as! Double
            let poleVault = lastPerson.value(forKey: "poleVault") as! Double
            let coreStatArr = lastPerson.value(forKey: "currStats") as! [NSString]
            let currEvents = lastPerson.value(forKey: "currEvents") as! [NSString]
            let starredUniversities = lastPerson.value(forKey: "starredKeyArr") as! [NSString]
            let contactedUniversities = lastPerson.value(forKey: "contactedKeyArr") as? [NSString]
            let gender = lastPerson.value(forKey: "gender") as! String
            
            user.starredUniversities = starredUniversities as [String]
            if contactedUniversities == nil {
                user.contactedUniversities = []
            } else {
                user.contactedUniversities = contactedUniversities! as [String]
            }
            user.name = name
            user.sat = Int(sat)
            user.act = Int(act)
            user.gpa = gpa
            user.twoMile = Int(twoMile)
            user.discus = Double(discus)
            user.eighthundredm = eighthundredm
            user.fourhundredm = fourhundredm
            user.highJump = Double(highJump)
            user.longJump = longJump
            user.tripleJump = tripleJump
            user.mile = Int(mile)
            user.onehundredm = onehundredm
            user.twohundredm = twohundredm
            user.shotput = Double(shotput)
            user.onetenHurdles = onetenHurdles
            user.threehundredHurdles = threehundredHurdles
            user.poleVault = poleVault
            user.statArr = coreStatArr as [String]
            user.currEvents = currEvents as [String]
            user.eventGroup = eventGroup
            user.gender = gender
            

        } catch {

            print("Failed")
        }
    }
    
    func saveUser() {
        saveName(user.name)
        saveGender(user.gender)
        saveSAT(user.sat)
        saveACT(user.act)
        saveGPA(user.gpa)
        saveTwoMile(user.twoMile)
        
        saveDoubleEvent("discus", user.discus)
        saveDoubleEvent("eighthundredm", user.eighthundredm)
        saveDoubleEvent("fourhundredm", user.fourhundredm)
        saveDoubleEvent("highJump", user.highJump)
        saveDoubleEvent("longJump", user.longJump)
        saveDoubleEvent("tripleJump", user.tripleJump)
        saveDoubleEvent("onehundredm", user.onehundredm)
        saveDoubleEvent("shotput", user.shotput)
        saveDoubleEvent("twohundredm", user.twohundredm)
        saveDoubleEvent("onetenHurdles", user.onetenHurdles)
        saveDoubleEvent("threehundredHurdles", user.threehundredHurdles)
        saveDoubleEvent("poleVault", user.poleVault)
        
        saveIntEvent("mile", user.mile)
        
        saveCurrEvents(user.currEvents)
    }
    
    func starredKeyToUni() -> [University] {
        var retArr: [University] = []
        for link in starredUniversities {
            let currUni = linkUniDict[link]
            retArr.append(currUni!)
        }
        return retArr
    }
    
    func saveCurrEvents(_ newArr: [String]) {
        user.currEvents = newArr
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(newArr as [NSString], forKey: "currEvents")
            try context.save()
        } catch {
            print("Failed")
        }
    }
    
    func saveStarredArr(_ newArr: [String]) {
        user.starredUniversities = newArr
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(newArr as [NSString], forKey: "starredKeyArr")
            try context.save()
        } catch {
            print("Failed")
        }
    }
    
    func saveContactedArr(_ newArr: [String]) {
        user.contactedUniversities = newArr
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(newArr as [NSString], forKey: "contactedKeyArr")
            try context.save()
        } catch {
            print("Failed")
        }
    }
    
    func saveCurrStats(_ newArr: [String]) {
        user.statArr = newArr
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(newArr as [NSString], forKey: "currStats")
            try context.save()
        } catch {
            print("Failed")
        }
    }
    
    func saveSAT(_ score: Int) {
        user.sat = score
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(Int16(score), forKey: "sat")
            try context.save()
        } catch {
            print("Failed")
        }
        
    }
    
    func saveACT(_ score: Int) {
        user.act = score
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(Int16(score), forKey: "act")
            try context.save()
        } catch {
            print("Failed")
        }
    }
    
    func saveGPA(_ score: Double) {
        user.gpa = score
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(score, forKey: "gpa")
            try context.save()
        } catch {
            print("Failed")
        }
    }
    
    func saveTwoMile(_ score: Int) {
        user.twoMile = score
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(score, forKey: "twoMile")
            try context.save()
        } catch {
            print("Failed")
        }
    }
    
    func saveName(_ name: String) {
        user.name = name
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(name, forKey: "name")
            try context.save()
        } catch {
            print("Failed")
        }
    }
    
    func saveEventGroup(_ name: String) {
        user.eventGroup = name
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(name, forKey: "eventGroup")
            try context.save()
        } catch {
            print("Failed")
        }
    }
    func saveGender(_ gender: String) {
        user.gender = gender
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(gender, forKey: "gender")
            try context.save()
        } catch {
            print("Failed")
        }
    }
    
    func saveDoubleEvent(_ key: String, _ val: Double) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(val, forKey: key)
            try context.save()
        } catch {
            print("Failed")
        }

    }
    
    func saveIntEvent(_ key: String, _ val: Int) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            let lastPerson = result.last!
            lastPerson.setValue(val, forKey: key)
            try context.save()
        } catch {
            print("Failed")
        }

    }

    
    func createData() {
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue("", forKey: "name")
        newUser.setValue("", forKey: "gender")
        newUser.setValue("", forKey: "eventGroup")
        newUser.setValue(Int16(0), forKey: "sat")
        newUser.setValue(Int16(0), forKey: "act")
        newUser.setValue(Double(0), forKey: "gpa")
        newUser.setValue(Int16(0), forKey: "twoMile")
        newUser.setValue(Int16(0), forKey: "discus")
        newUser.setValue(Double(0), forKey: "eighthundredm")
        newUser.setValue(Double(0), forKey: "fourhundredm")
        newUser.setValue(Int16(0), forKey: "highJump")
        newUser.setValue(Double(0), forKey: "longJump")
        newUser.setValue(Double(0), forKey: "tripleJump")
        newUser.setValue(Int16(0), forKey: "mile")
        newUser.setValue(Double(0), forKey: "onehundredm")
        newUser.setValue(Int16(0), forKey: "shotput")
        newUser.setValue(Double(0), forKey: "twohundredm")
        newUser.setValue(Double(0), forKey: "onetenHurdles")
        newUser.setValue(Double(0), forKey: "threehundredHurdles")
        newUser.setValue(Double(0), forKey: "poleVault")
        
        
        newUser.setValue([] as [NSString], forKey: "starredKeyArr")
        newUser.setValue([] as [NSString], forKey: "contactedKeyArr")
        newUser.setValue([] as [NSString], forKey: "currStats")
        newUser.setValue([] as [NSString], forKey: "currEvents")
        do {
           try context.save()
          } catch {
           print("Failed saving")
        }
        
    }
    
    static func stringToSecs(_ time: String) -> Int {
        let splitString = time.split(separator: ":")
        if splitString.count == 1 {
            return Int(time)!
        } else {
            let mins = Int(String(splitString[0]))
            let secs = Int(String(splitString[1]))
            return mins! * 60 + secs!
        }
    }
    
    static func secsToString(_ time: Int) -> String {
        if time == 0 {
            return "0:00"
        }
        if time < 60 {
            return String(time)
        } else {
            let mins = time / 60
            let secs = time - (mins * 60)
            let minString = String(mins)
            var secsString = String(secs)
            if secs < 10 {
                secsString = "0" + secsString
            }
            return minString + ":" + secsString
        }
    }
    
    static func doubleToString(_ time: Double) -> String {
        let mins = Int(time / 60)
        let minSecs: Double = Double(mins * 60)
        let secs = Double(time - minSecs).truncate(places: 2)
        if mins == 0 {
            return String(secs)
        } else {
            var secsString = String(secs)
            if secs < 10 {
                secsString = "0" + secsString
            }
            return String(mins) + ":" + secsString
        }
    }
    
    static func stringToDouble(_ time: String) -> Double {
        let splitArr = time.split(separator: ":")
        if splitArr.count == 1{
            return Double(splitArr[0])!
        } else {
            return Double(splitArr[0])! * 60 + Double(splitArr[1])!
        }
    }
    
    static func ftToString(_ mark: Double) -> String {
        let feet = Int(mark / 12)
        let ftInches = Double(feet * 12)
        let inches = (mark - ftInches).truncate(places: 2)
        return String(feet) + "-" + String(inches)
    }

    static func stringToFt(_ mark: String) -> Double {
        let splitArr = mark.split(separator: "-")
        if splitArr.count == 1 {
            return Double(splitArr[0])!
        } else {
            let ftInches = Double(splitArr[0])! * 12
            let inches = Double(splitArr[1])!
            return (ftInches + inches)
        }
    }
    
}
