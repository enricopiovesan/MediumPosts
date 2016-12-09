//
//  CarTests.swift
//  UnitTest
//
//  Created by Enrico Piovesan on 09/12/2016.
//  Copyright © 2016 none. All rights reserved.
//

import XCTest
@testable import UnitTest

class CarTests: XCTestCase {
    
    var ferrari:Car!
    var jeep:Car!
    var honda:Car!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        ferrari = Car(type: .Sport, transmissionMode: .Drive)
        jeep = Car(type: .OffRoad, transmissionMode: .Drive)
        honda = Car(type: .Economy, transmissionMode: .Park)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        ferrari = nil
        jeep = nil
        honda = nil
    }
    
    //test that a sport car does more fast to a jeep car
    func testSportFasterThanJeep() {
        
        let minutes = 60
        
        //1 start ferrari
        ferrari.start(minutes: minutes)
        
        //2 start jeep
        jeep.start(minutes: minutes)
        
        //Test it
        XCTAssertTrue(ferrari.miles > jeep.miles)
        
    }
    
}
