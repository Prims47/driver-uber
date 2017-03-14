//
//  DriverTest.swift
//  driverUber
//
//  Created by IlanB on 22/03/2017.
//  Copyright © 2017 IlanB. All rights reserved.
//

import XCTest
import CoreLocation
@testable import driverUber

class DriverTest: XCTestCase {
    var driver:Driver?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.driver = Driver(name: "Pepito", car: "Nissan GTR", immat: "24-EZ-92", status: 10)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDriverInit() {
        let driver = Driver(name: "Pepito", car: "Nissan GTR", immat: "24-EZ-92", status: 10)
        
        XCTAssertEqual("Pepito", driver.getName())
        XCTAssertEqual("Nissan GTR", driver.getCar())
        XCTAssertEqual("24-EZ-92", driver.getImmat())
        XCTAssertEqual(10, driver.getStatus())
    }
    
    func testAddLocation() {
        let latitude = CLLocationDegrees(24)
        let longitude = CLLocationDegrees(47)
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        self.driver?.addLocation(location: location)
        
        XCTAssertEqual(1, self.driver?.getLocations().count)
        XCTAssertEqual(location, self.driver?.getLastLocations())
    }
    
    func testHasLocation() {
        XCTAssertEqual(false, self.driver?.hasLocation())
    }
    
    func testLocations() {
        let latitude = CLLocationDegrees(24)
        let longitude = CLLocationDegrees(47)
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        let latitude2 = CLLocationDegrees(770)
        let longitude2 = CLLocationDegrees(770)
        let location2 = CLLocation(latitude: latitude2, longitude: longitude2)
        
        self.driver?.addLocation(location: location)
        self.driver?.addLocation(location: location2)
        
        XCTAssertEqual(location, self.driver?.getLocationBeforeLast())
        XCTAssertEqual(location2, self.driver?.getLastLocations())
        
        self.driver?.removeLocations()
        self.driver?.addLocation(location: location)
        
        XCTAssertEqual(location, self.driver?.getLocationBeforeLast())
    }
    
    func testRemoveLocations() {
        let latitude = CLLocationDegrees(24)
        let longitude = CLLocationDegrees(47)
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        let latitude2 = CLLocationDegrees(770)
        let longitude2 = CLLocationDegrees(770)
        let location2 = CLLocation(latitude: latitude2, longitude: longitude2)
        
        self.driver?.addLocation(location: location)
        self.driver?.addLocation(location: location2)
        
        self.driver?.removeLocations()
        
        XCTAssertEqual(nil, self.driver?.getLastLocations())
        XCTAssertEqual(nil, self.driver?.getLocationBeforeLast())
    }
}
