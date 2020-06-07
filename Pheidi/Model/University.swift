//
//  University.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/25/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import Foundation

//var dataUniversityList: [dataUniversity] = []
//public class dataUniversity {
//    var name: String =  ""
//    var city: String =  ""
//    var state: String = ""
//    var accepRate: Double = 0.0
//    var sat: Int = 0
//    var act: Int = 0
//    var gpa: Double = 0
//    var mens100: Double = 0
//    var womens100: Double = 0
//    var mens200: Double = 0
//    var womens200: Double = 0
//    var mens400: Double = 0
//    var womens400: Double = 0
//    var mens800: Double = 0
//    var womens800: Double = 0
//    var mens1600: Double = 0
//    var womens1600: Double = 0
//    var mens3200: Double = 0
//    var womens3200: Double = 0
//    var mensShotput: Double = 0
//    var womensShotput: Double = 0
//    var mensDiscus: Double = 0
//    var womensDiscus: Double = 0
//    var mensHighJump: Double = 0
//    var womensHighJump: Double = 0
//    var mensLongJump: Double = 0
//    var womensLongJump: Double = 0
//    var mensTripleJump: Double = 0
//    var womensTripleJump: Double = 0
//    var mens300Hurdles: Double = 0
//    var womens300Hurdles: Double = 0
//    var mensPoleVault: Double = 0
//    var womensPoleVault: Double = 0
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    static func readDataFromFile(file: String) -> String! {
//        guard let filepath = Bundle.main.path(forResource: file, ofType: "csv")
//            else {
//                return nil
//        }
//        do {
//            let contents = try String(contentsOfFile: filepath)
//            return contents
//        } catch {
//            print("Contents could not be loaded")
//            return nil
//        }
//    }
//    
//    static func createUniversityList() {
//        let contents = dataUniversity.readDataFromFile(file: "finalPheidiData")!
//        let universityList = contents.components(separatedBy: "\r\n").map{ $0.components(separatedBy: ",") }
//        print(universityList[1])
//        for index in 1...universityList.count - 1 {
//            let currUni = dataUniversity()
//            let currArr = universityList[index]
//            if currArr[1].contains("\"") {
//                continue
//            }
//            currUni.name = currArr[1]
//            currUni.city = currArr[2]
//            currUni.state = currArr[3]
//            if currArr[4] != "nan" {
//                let accepRateString = currArr[4].replacingOccurrences(of: "%", with: "")
//                currUni.accepRate = Double(accepRateString) ?? 0
//            }
//            if currArr[5] != "nan" {
//                if index == 3 {
//                    print("hello")
//                }
//                currUni.sat = Int(currArr[5]) ?? 0
//            }
//            if currArr[7] != "nan" {
//                let actMin = Int(currArr[7]) ?? 0
////                let actMax = Int(currArr[8]) ?? 0
//                currUni.act = actMin
//            }
//            if currArr[9] != "nan" {
//                currUni.gpa = Double(currArr[9]) ?? 0
//            }
//            if currArr[12] != "nan" {
//                currUni.mens100 = Double(currArr[12]) ?? 0
//            }
//            if currArr[14] != "nan" {
//                currUni.womens100 = Double(currArr[14]) ?? 0
//            }
//            if currArr[16] != "nan" {
//                currUni.mens200 = Double(currArr[16]) ?? 0
//            }
//            if currArr[18] != "nan" {
//                currUni.womens200 = Double(currArr[18]) ?? 0
//            }
//            if currArr[20] != "nan" {
//                currUni.mens400 = Double(currArr[20]) ?? 0
//            }
//            if currArr[22] != "nan" {
//                currUni.womens400 = Double(currArr[22]) ?? 0
//            }
//            if currArr[24] != "nan" {
//                currUni.mens800 = Double(currArr[24]) ?? 0
//            }
//            if currArr[26] != "nan" {
//                currUni.womens800 = Double(currArr[26]) ?? 0
//            }
//            if currArr[28] != "nan" {
//                currUni.mens1600 = Double(currArr[28]) ?? 0
//            }
//            if currArr[30] != "nan" {
//                currUni.womens1600 = Double(currArr[30]) ?? 0
//            }
//            if currArr[32] != "nan" {
//                currUni.mens3200 = Double(currArr[32]) ?? 0
//            }
//            if currArr[34] != "nan" {
//                currUni.womens3200 = Double(currArr[34]) ?? 0
//            }
//            if currArr[35] != "nan" {
//                currUni.mensShotput = Double(currArr[36]) ?? 0
//            }
//            if currArr[37] != "nan" {
//                currUni.womensShotput = Double(currArr[38]) ?? 0
//            }
//            if currArr[39] != "nan" {
//                currUni.mensDiscus = Double(currArr[40]) ?? 0
//            }
//            if currArr[41] != "nan" {
//                currUni.womensDiscus = Double(currArr[42]) ?? 0
//            }
//            if currArr[43] != "nan" {
//                currUni.mensHighJump = Double(currArr[43]) ?? 0
//            }
//            if currArr[45] != "nan" {
//                currUni.womensHighJump = Double(currArr[45]) ?? 0
//            }
//            if currArr[47] != "nan" {
//                currUni.mensLongJump = Double(currArr[47]) ?? 0
//            }
//            if currArr[49] != "None" {
//                currUni.womensLongJump = Double(currArr[49]) ?? 0
//            }
//            if currArr[51] != "None" {
//                currUni.mensTripleJump = Double(currArr[51]) ?? 0
//            }
//            if currArr[53] != "None" {
//                currUni.womensTripleJump = Double(currArr[53]) ?? 0
//            }
//            if currArr[56] != "None" {
//                currUni.mens300Hurdles = Double(currArr[56]) ?? 0
//            }
//            if currArr[58] != "None" {
//                currUni.womens300Hurdles = Double(currArr[58]) ?? 0
//            }
//            if currArr[60] != "None" {
//                currUni.mensPoleVault = Double(currArr[60]) ?? 0
//            }
//            if currArr[62] != "None" {
//                currUni.womensPoleVault = Double(currArr[62]) ?? 0
//            }
//            dataUniversityList.append(currUni)
//        }
//        let u1 = dataUniversityList[2]
//    }
//    
//}



