//
//  Event.swift
//  Pheidi
//
//  Created by Shyam Kumar on 12/26/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import Foundation


var fullEventDict: [String: Event] = [:]

class Event {
    var questionName: String = ""
    var coreDataKey: String = ""
    var saveValueDouble: (_ key: String, _ val: Double) -> Void = user.saveDoubleEvent(_:_:)
    var saveValueInt: (_ key: String, _ val: Int) -> Void = user.saveIntEvent(_:_:)
    var eventType: EventType = .double
    
    init(_ name: String, _ key: String, _ eventType: EventType) {
        self.questionName = name
        self.coreDataKey = key
        self.eventType = eventType
    }
    
    
    static func populateFullEventDict() {
        for (val, key) in valKeyDict {
            if doubleEvents.contains(key) {
                fullEventDict[val] = Event(val, key, .double)
            }
            
            if intEvents.contains(key) {
                fullEventDict[val] = Event(val, key, .int)
            }
            
            if ftEvents.contains(key) {
                fullEventDict[val] = Event(val, key, .feet)
            }
        }
        
    }
}

enum EventType {
    case double
    case int
    case feet
}
