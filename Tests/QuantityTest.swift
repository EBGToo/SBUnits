//
//  QuantityTest.swift
//  SBUnits
//
//  Created by Ed Gamble on 11/4/15.
//  Copyright © 2015 Opus Logica Inc. All rights reserved.
//

import XCTest
@testable import SBUnits

class QuantityTest: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func assertNearly<D: Dimension> (q1: Quantity<D>, _ q2: Quantity<D>) {
    XCTAssertTrue(abs((q1 - q2).valueToRoot) < DBL_EPSILON)
  }
  
  func testDescription() {
    let q1 = Quantity<Mass>(value: 1.0, unit: kilogram)
    XCTAssertEqual(q1.description, "1.0 kg")
    debugPrint(q1)
    print (q1)
    
    let q2 = Quantity<Length>(value: 1.0, unit: meter)
    debugPrint(q2)
    print (q2)
    let q3 = Quantity<Length>(value: 0.001, unit: kilometer)
    debugPrint(q3)
    print (q3)

    XCTAssertEqual(q2.valueToRoot, q3.valueToRoot)
  }
  
  func testMass () {
    
    // Metric
    
    XCTAssertEqual(Quantity<Mass>(value: 1.0, unit: kilogram),
      Quantity<Mass>(value: 1000, unit: gram))

    XCTAssertEqual(Quantity<Mass>(value: 1.0, unit: kilogram),
      Quantity<Mass>(value: 1000 * 1000, unit: milligram))
    
    // Imperial
    
    XCTAssertEqual(Quantity<Mass>(value: 1.0, unit: pound),
      Quantity<Mass>(value: 16, unit: ounce))

    // Metric <==> Imperial
    
    XCTAssertEqual(Quantity<Mass>(value: 1.0, unit: pound),
      Quantity<Mass>(value: 0.45359237, unit: kilogram))
    
    XCTAssertEqual(Quantity<Mass>(value: 1.0, unit: ounce),
      Quantity<Mass>(value: 0.45359237 / 16, unit: kilogram))
    
    XCTAssertEqual(Quantity<Mass>(value: 1.0, unit: ounce),
      Quantity<Mass>(value: 1000 * 0.45359237 / 16, unit: gram))
  }
  
  func testLength () {
    
    // Metric
    
    XCTAssertEqual(Quantity<Length>(value: 1.0, unit: meter),
      Quantity<Length>(value: 100, unit: centimeter))
    
    XCTAssertEqual(Quantity<Length>(value: 1.0, unit: meter),
      Quantity<Length>(value: 1000, unit: millimeter))
    
    XCTAssertEqual(Quantity<Length>(value: 1.0, unit: centimeter),
      Quantity<Length>(value: 10, unit: millimeter))

    XCTAssertEqual(Quantity<Length>(value: 1.0, unit: kilometer),
      Quantity<Length>(value: 1000, unit: meter))
    
    XCTAssertEqual(Quantity<Length>(value: 1.0, unit: kilometer),
      Quantity<Length>(value: 1000.0 * 1000.0, unit: millimeter))
    
    // Imperial
    
    XCTAssertEqual(Quantity<Length>(value: 1.0, unit: yard),
      Quantity<Length>(value: 3, unit: foot))
    
    XCTAssertEqual(Quantity<Length>(value: 1.0, unit: yard),
      Quantity<Length>(value: 36, unit: inch))
    
    XCTAssertEqual(Quantity<Length>(value: 1.0, unit: mile),
      Quantity<Length>(value: 1760, unit: yard))
    
    XCTAssertEqual(Quantity<Length>(value: 1.0, unit: mile),
      Quantity<Length>(value: 5280, unit: foot))

    XCTAssertEqual(Quantity<Length>(value: 1.0, unit: mile),
      Quantity<Length>(value: 12 * 5280, unit: inch))

    XCTAssertEqual(Quantity<Length>(value: 1.0, unit: foot),
      Quantity<Length>(value: 12, unit: inch))
    
    // Metric <==> Imperial
    
    assertNearly(Quantity<Length>(value: 1.0, unit: inch),
      Quantity<Length>(value: 2.54, unit: centimeter))
    
    assertNearly(Quantity<Length>(value: 1.0, unit: inch),
      Quantity<Length>(value: 25.4, unit: millimeter))

    assertNearly(Quantity<Length>(value: 1.0, unit: mile),
      Quantity<Length>(value: 1609.344, unit: meter))
    
    assertNearly(Quantity<Length>(value: 1.0, unit: mile),
      Quantity<Length>(value: 1.609344, unit: kilometer))
  }
  
  func testTime () {
    
    XCTAssertEqual(Quantity<Time>(value: 1, unit: minute),
      Quantity<Time>(value: 60, unit: second))
    
    XCTAssertEqual(Quantity<Time>(value: 1, unit: hour),
      Quantity<Time>(value: 60, unit: minute))

    XCTAssertEqual(Quantity<Time>(value: 1, unit: hour),
      Quantity<Time>(value: 60 * 60, unit: second))

    XCTAssertEqual(Quantity<Time>(value: 1, unit: hour),
      Quantity<Time>(value: 60 * 60 * 1e3, unit: millisecond))
  }
  
  
  func testTemperature() {
    
    XCTAssertEqual(Quantity<Temperature>(value: 0, unit: celsius),
      Quantity<Temperature>(value: 32, unit: fahrenheit))

    XCTAssertEqual(Quantity<Temperature>(value: 0, unit: celsius),
      Quantity<Temperature>(value: 273.15, unit: kelvin))

    XCTAssertEqual(Quantity<Temperature>(value: 0, unit: kelvin),
      Quantity<Temperature>(value: -273.15, unit: celsius))
  }
  
  func testAngle () {
    
    XCTAssertEqual(Quantity<Angle>(value: 2 * M_PI, unit: radian),
      Quantity<Angle>(value: 360, unit: degree))
    
    XCTAssertEqual(Quantity<Angle>(value: M_PI, unit: radian),
      Quantity<Angle>(value: 180, unit: degree))

    XCTAssertEqual(Quantity<Angle>(value: M_PI_2, unit: radian),
      Quantity<Angle>(value: 90, unit: degree))

    XCTAssertEqual(Quantity<Angle>(value: M_PI_4, unit: radian),
      Quantity<Angle>(value: 45, unit: degree))
  }
  
  func testPerformanceExample() {
    self.measureBlock {
    }
  }
}
