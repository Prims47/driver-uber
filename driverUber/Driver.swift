//
//  Driver.swift
//  driverUber
//
//  Created by IlanB on 18/03/2017.
//  Copyright © 2017 IlanB. All rights reserved.
//

import UIKit
import CoreLocation

struct Driver {
    var name:String?
    var car:String?
    var immat:String?
    var status:Int?
    
    var locations:[CLLocation] = []
    
    init(name: String, car: String, immat: String, status: Int) {
        self.name = name
        self.car = car
        self.immat = immat
        self.status = status
    }
    
    func getName() -> String {
        return self.name!
    }
    
    func getCar() -> String {
        return self.car!
    }
    
    func getImmat() -> String {
        return self.immat!
    }
    
    func getStatus() -> Int {
        return self.status!
    }

    mutating func addLocation(location: CLLocation) {
        self.locations.append(location)
    }

    func getLocations() -> Array<CLLocation> {
        return self.locations
    }
    
    func hasLocation() -> Bool {
        return !self.locations.isEmpty
    }

    func getLastLocations() -> CLLocation? {
        if !hasLocation() {
            return nil
        }
        
        return self.locations.last!
    }
    
    func getLocationBeforeLast() -> CLLocation? {
        if !hasLocation() {
            return nil
        }

        if self.locations.count < 2 {
            return self.locations.last!
        }

        return self.locations[self.locations.count - 2]
    }
    
    mutating func removeLocations() {
        if !hasLocation() {
            return
        }

        self.locations.removeAll()
    }
}
