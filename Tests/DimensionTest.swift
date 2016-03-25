//
//  DimensionTest.swift
//  SBUnits
//
//  Created by Ed Gamble on 10/31/15.
//  Copyright © 2015 Edward B. Gamble Jr.  All rights reserved.
//
//  See the LICENSE file at the project root for license information.
//  See the CONTRIBUTORS file at the project root for a list of contributors.
//

import XCTest
@testable import SBUnits

class DimensionTest: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testDimensionBase () {
    XCTAssertEqual(DimensionBase.mass.rawValue, 0)
    XCTAssertEqual(DimensionBase.mass.name, "Mass")
    XCTAssertEqual(DimensionBase.mass.symbol, "M")
    XCTAssertEqual(DimensionBase.mass.description, DimensionBase.mass.name)
    
    // ...

    XCTAssertEqual(DimensionBase.angle.rawValue, 7)
    XCTAssertEqual(DimensionBase.angle.name, "Angle")
    XCTAssertEqual(DimensionBase.angle.symbol, "R")
    
    
    XCTAssertEqual(DimensionBase.DIMENSION_BASE_COUNT, 8)
  }
  
  func testDimensionBaseEncode() {
    for power in Array<Int8>(arrayLiteral: 1, 2, 3, 4) {
      XCTAssertEqual(DimensionBase.encode(DimensionBase.mass, power),
        DimensionBase.encode(power, 0, 0, 0, 0, 0, 0, 0))
      
      // ...
      
      XCTAssertEqual(DimensionBase.encode(DimensionBase.angle, power),
        DimensionBase.encode(0, 0, 0, 0, 0, 0, 0, power))
    }
  }
  
  func testDimensionBaseDecode() {
    for power in Array<Int8>(arrayLiteral: 1, 2, 3, 4) {
      XCTAssertEqual(DimensionBase.decode(DimensionBase.mass,
        DimensionBase.encode(DimensionBase.mass, power)), power)
    
      XCTAssertEqual(DimensionBase.decode(DimensionBase.angle,
        DimensionBase.encode(DimensionBase.angle, power)), power)
    }
  }
  
  func testDimensionBaseCompatibleProduct () {
    XCTAssertTrue(DimensionBase.compatibleAsProduct(
      r:  DimensionBase.encode(1, -1, 0, 0, 0, 0, 0, 0),
      p1: DimensionBase.encode(1, 0, 0, 0, 0, 0, 0, 0),
      p2: DimensionBase.encode(0, -1, 0, 0, 0, 0, 0, 0)))

  
    XCTAssertTrue(DimensionBase.compatibleAsProduct(
      r:  DimensionBase.encode(2, 0, 0, 0, 0, 0, 0, 0),
      p1: DimensionBase.encode(1,  1, 0, 0, 0, 0, 0, 0),
      p2: DimensionBase.encode(1, -1, 0, 0, 0, 0, 0, 0)))
  }
  
  func testDimensionBaseCompatibleQuotient () {
    XCTAssertTrue(DimensionBase.compatibleAsQuotient(
      r:  DimensionBase.encode(1, 1, 0, 0, 0, 0, 0, 0),
      p1: DimensionBase.encode(1, 0, 0, 0, 0, 0, 0, 0),
      p2: DimensionBase.encode(0, -1, 0, 0, 0, 0, 0, 0)))
    
    
    XCTAssertTrue(DimensionBase.compatibleAsQuotient(
      r:  DimensionBase.encode(0, 2, 0, 0, 0, 0, 0, 0),
      p1: DimensionBase.encode(1,  1, 0, 0, 0, 0, 0, 0),
      p2: DimensionBase.encode(1, -1, 0, 0, 0, 0, 0, 0)))
  }
  
  func testExample() {
    _ = DimensionBase.encode(.mass, 1)
    _ = DimensionBase.encode(.mass, 127)
    
    _ = DimensionBase.encode(.length, 1)
    _ = DimensionBase.encode(.time, 1)
    
    _ = DimensionBase.decode(.time, DimensionBase.encode(.time, 10))
    
    _ = Length.encoding
    _ = Time.encoding
    _ = Speed.encoding
    
    _ = DimensionBase.compatibleAsProduct(r: Length.encoding, p1: Speed.encoding, p2: Time.encoding)
    
  }
  
  func testPerformanceExample() {
    self.measure {
    }
  }
}
