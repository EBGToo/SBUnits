//
//  UnitTest.swift
//  SBUnits
//
//  Created by Ed Gamble on 10/22/15.
//  Copyright © 2015 Opus Logica Inc. All rights reserved.
//

import XCTest
@testable import SBUnits

class UnitTest: XCTestCase {
  
  var m1 : Unit<Mass>!
  var m2 : Unit<Mass>!
  var m3 : Unit<Mass>!
  
  override func setUp() {
    super.setUp()
    m1 = Unit<Mass>("m1name", "m1")
    m2 = Unit<Mass>(m1, "m2name", "m2", scale: 2.0, offset: 0.0)
    m3 = Unit<Mass>(m2, "m3name", "m3", scale: 0.5, offset: 0.0)
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testExample() {
    XCTAssertEqual(2.54, centimeter.convert(1.0, unit: inch), "1in = 2.54cm")
    XCTAssertEqual(1000, gram.convert(1, unit: kilogram), "1kg = 1000g")
    
    //    XCTAssertTrue(gram.isCompatible(pound), "gram/pound")
    //    XCTAssertTrue(gram.isCompatible(kilogram), "gram/kilogram")
  }
  
  func testUnitProperties() {
    XCTAssertNil  (m1.parent)
    XCTAssertEqual(m1.scale.factor,  1.0)
    XCTAssertEqual(m1.offset, 0.0)
    XCTAssertEqual(m1.name,   "m1name")
    XCTAssertEqual(m1.symbol, "m1")
    XCTAssertTrue(m1.root === m1)
    
    XCTAssertTrue (m2.parent === m1)
    XCTAssertEqual(m2.scale.factor,  2.0)
    XCTAssertEqual(m2.offset, 0.0)
    XCTAssertEqual(m2.name,   "m2name")
    XCTAssertEqual(m2.symbol, "m2")
    XCTAssertTrue (m2.root === m1)
    
    XCTAssertTrue (m3.parent === m2)
    XCTAssertEqual(m3.scale.factor,  0.5)
    XCTAssertEqual(m3.offset, 0.0)
    XCTAssertEqual(m3.name,   "m3name")
    XCTAssertEqual(m3.symbol, "m3")
    XCTAssertTrue (m3.root === m1)
  }
  
  func testUnitConvertToParent() {
    XCTAssertEqual(m1.convertToParent(1.5), 1.5)
    XCTAssertEqual(m1.convertFromParent(1.5), 1.5)
    
    XCTAssertEqual(m2.convertToParent(10.0), 20.0)
    XCTAssertEqual(m3.convertToParent(6.0), 3.0)
  }
  
  func testUnitConvertToBase() {
    XCTAssertEqual(m1.convertToRoot(2.0), 2.0)
    XCTAssertEqual(m2.convertToRoot(2.0), 4.0)
    XCTAssertEqual(m3.convertToRoot(6.0), 6.0)
  }
  
  func testPerformanceExample() {
    self.measureBlock {
    }
  }
  
}
