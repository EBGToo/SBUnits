//
//  ScaleTest.swift
//  SBUnits
//
//  Created by Ed Gamble on 11/2/15.
//  Copyright © 2015 Edward B. Gamble Jr.  All rights reserved.
//
//  See the LICENSE file at the project root for license information.
//  See the CONTRIBUTORS file at the project root for a list of contributors.
//

import XCTest
@testable import SBUnits

class ScaleTest: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }

  func testScaleValue () {
    let s = Scale.value(1.0)
    
    XCTAssertEqual(s.factor, 1.0)
    XCTAssertNil(s.name)
    XCTAssertNil(s.symbol)
  }
  
  func testScalePrefix() {
    let s = Scale.prefix(1.5, "name", "symbol")
    XCTAssertEqual(s.factor, 1.5)
    XCTAssertEqual(s.name, "name")
    XCTAssertEqual(s.symbol, "symbol")
  }

  func testScalePrefixVariables() {
    XCTAssertEqual(Scale.yocto.factor, 1e-24)
    XCTAssertEqual(Scale.yocto.name, "yocto")
    XCTAssertEqual(Scale.yocto.symbol, "y")
    
    XCTAssertEqual(Scale.yotta.factor, 1e+24)
    XCTAssertEqual(Scale.yotta.name, "yotta")
    XCTAssertEqual(Scale.yotta.symbol, "Y")
  }
  
  func testPerformanceExample() {
    self.measure {
    }
  }
}
