//
//  Person+CoreDataProperties.swift
//  Pheidi
//
//  Created by Shyam Kumar on 5/22/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String
    @NSManaged public var sat: Int16
    @NSManaged public var act: Int16
    @NSManaged public var gpa: Double
    @NSManaged public var twoMile: Int16
    @NSManaged public var discus: Double
    @NSManaged public var eighthundredm: Double
    @NSManaged public var fourhundredm: Double
    @NSManaged public var highJump: Double
    @NSManaged public var longJump: Double
    @NSManaged public var tripleJump: Double
    @NSManaged public var mile: Int16
    @NSManaged public var onehundredm: Double
    @NSManaged public var shotput: Double
    @NSManaged public var twohundredm: Double
    @NSManaged public var onetenHurdles: Double
    @NSManaged public var threehundredHurdles: Double
    @NSManaged public var poleVault: Double
    @NSManaged public var currStats: [NSString]
    @NSManaged public var currEvents: [NSString]
    @NSManaged public var starredKeyArr: [NSString]
    @NSManaged public var eventGroup: String
    @NSManaged public var gender: String
}
