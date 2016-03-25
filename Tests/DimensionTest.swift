//
//  DimensionTest.swift
//  SBUnits
//
//  Created by Ed Gamble on 10/31/15.
//  Copyright © 2015 Opus Logica Inc. All rights reserved.
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
    XCTAssertEqual(DimensionBase.Mass.rawValue, 0)
    XCTAssertEqual(DimensionBase.Mass.name, "Mass")
    XCTAssertEqual(DimensionBase.Mass.symbol, "M")
    XCTAssertEqual(DimensionBase.Mass.description, DimensionBase.Mass.name)
    
    // ...

    XCTAssertEqual(DimensionBase.Angle.rawValue, 7)
    XCTAssertEqual(DimensionBase.Angle.name, "Angle")
    XCTAssertEqual(DimensionBase.Angle.symbol, "R")
    
    
    XCTAssertEqual(DimensionBase.DIMENSION_BASE_COUNT, 8)
  }
  
  func testDimensionBaseEncode() {
    for power in Array<Int8>(arrayLiteral: 1, 2, 3, 4) {
      XCTAssertEqual(DimensionBase.encode(DimensionBase.Mass, power),
        DimensionBase.encode(power, 0, 0, 0, 0, 0, 0, 0))
      
      // ...
      
      XCTAssertEqual(DimensionBase.encode(DimensionBase.Angle, power),
        DimensionBase.encode(0, 0, 0, 0, 0, 0, 0, power))
    }
  }
  
  func testDimensionBaseDecode() {
    for power in Array<Int8>(arrayLiteral: 1, 2, 3, 4) {
      XCTAssertEqual(DimensionBase.decode(DimensionBase.Mass,
        DimensionBase.encode(DimensionBase.Mass, power)), power)
    
      XCTAssertEqual(DimensionBase.decode(DimensionBase.Angle,
        DimensionBase.encode(DimensionBase.Angle, power)), power)
    }
  }
  
  func testDimensionBaseCompatibleProduct () {
    XCTAssertTrue(DimensionBase.compatibleAsProduct(
      DimensionBase.encode(1, -1, 0, 0, 0, 0, 0, 0),
      p1: DimensionBase.encode(1, 0, 0, 0, 0, 0, 0, 0),
      p2: DimensionBase.encode(0, -1, 0, 0, 0, 0, 0, 0)))

  
    XCTAssertTrue(DimensionBase.compatibleAsProduct(
      DimensionBase.encode(2, 0, 0, 0, 0, 0, 0, 0),
      p1: DimensionBase.encode(1,  1, 0, 0, 0, 0, 0, 0),
      p2: DimensionBase.encode(1, -1, 0, 0, 0, 0, 0, 0)))
  }
  
  func testDimensionBaseCompatibleQuotient () {
    XCTAssertTrue(DimensionBase.compatibleAsQuotient(
      DimensionBase.encode(1, 1, 0, 0, 0, 0, 0, 0),
      p1: DimensionBase.encode(1, 0, 0, 0, 0, 0, 0, 0),
      p2: DimensionBase.encode(0, -1, 0, 0, 0, 0, 0, 0)))
    
    
    XCTAssertTrue(DimensionBase.compatibleAsQuotient(
      DimensionBase.encode(0, 2, 0, 0, 0, 0, 0, 0),
      p1: DimensionBase.encode(1,  1, 0, 0, 0, 0, 0, 0),
      p2: DimensionBase.encode(1, -1, 0, 0, 0, 0, 0, 0)))
  }
  
  func testExample() {
    DimensionBase.encode(.Mass, 1)
    DimensionBase.encode(.Mass, 127)
    
    DimensionBase.encode(.Length, 1)
    DimensionBase.encode(.Time, 1)
    
    DimensionBase.decode(.Time, DimensionBase.encode(.Time, 10))
    
    Length.encoding
    Time.encoding
    Speed.encoding
    
    DimensionBase.compatibleAsProduct(Length.encoding, p1: Speed.encoding, p2: Time.encoding)
    
  }
  
  func testPerformanceExample() {
    self.measureBlock {
    }
  }
}
