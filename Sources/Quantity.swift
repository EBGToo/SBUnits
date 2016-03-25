//
//  Quantity.swift
//  SBUnits
//
//  Created by Ed Gamble on 10/31/15.
//  Copyright © 2015 Edward B. Gamble Jr.  All rights reserved.
//
//  See the LICENSE file at the project root for license information.
//  See the CONTRIBUTORS file at the project root for a list of contributors.
//

// References:
// https://en.wikipedia.org/wiki/International_System_of_Quantities#Base_quantities

// MARK: Quantity

/**
 * A `Quantity` is a magnitude (or multitude) of a physical property.  A Quantity has a `Dimension`
 * that identifies the type of the physical property; quanities with the same `Dimension` can be
 * compared with one another.  
 *
 * A `Quantity` has a `value` and a `unit`.  Comparisons between quantities is performed based on
 * values with the same unit; unit conversion is implicit.
 *
 * Quanties can be added and subtracted.
 *
 * Quantities can be conditionally multiplied and divided.  It is possible that the target of the 
 * product (or division), is specified with a Dimension that is inconsistent with the product.  For
 * example Volume = Length * Length.  In such cases the result of the product is `nil`.
 */
public struct Quantity<D:Dimension> : Comparable {
  
  /** The `Quantity` value */
  public let value : Double
  
  /** The `Quantity` unit */
  public let unit  : Unit<D>
  
  public init (value: Double, unit: Unit<D>) {
    self.value = value
    self.unit  = unit
  }
  
  /** The `Quantity` value converted to base of `unit` */
  var valueToRoot : Double {
    return self.unit.convertToRoot(self.value)
  }
  
  /** Convert to a different Unit */
  public func convert (_ unit: Unit<D>) -> Quantity<D> {
    return Quantity (value: unit.convert (self.value, unit: self.unit), unit: unit)
  }
  
  /**
   * Add `that` to `self` as `self + that`
   *
   * - parameter that: The addend
   *
   * - returns: A `Quantity` with the added result in the unit of `self`
   */
  public func add (_ that: Quantity<D>) -> Quantity<D> {
    return Quantity<D> (value: self.value + self.unit.convert(that.value, unit: that.unit),
      unit: self.unit)
  }
  
  /**
   * Add `that` to `self` as `self + that`
   *
   * - parameter that: The addend
   * - parameter unit: The unit for the result
   *
   * - returns: A `Quantity` with the added result in `unit`.
   */
  public func add (_ that: Quantity<D>, unit: Unit<D>) -> Quantity<D> {
    return Quantity<D> (value: unit.convert(self.value, unit: self.unit) + unit.convert(that.value, unit: that.unit),
      unit: unit)
  }
  
  /**
   * Subtract `that` from `self` as `self - that`
   *
   * - parameter that: The subend
   *
   * - returns: A `Quantity` with the subtracted result in the unit of `self`.
   */
  public func sub (_ that: Quantity<D>) -> Quantity<D> {
    return Quantity<D> (value: self.value - self.unit.convert(that.value, unit: that.unit),
      unit: self.unit)
  }
  
  /**
   * Subtract `that` from `self` as `self - that`
   *
   * - parameter that: The subend
   * - parameter unit: The unit for the result
   *
   * - returns: A `Quantity` with the subtracted result in `unit`.
   */
  public func sub (_ that: Quantity<D>, unit: Unit<D>) -> Quantity<D> {
    return Quantity<D> (value: unit.convert(self.value, unit: self.unit) - unit.convert(that.value, unit: that.unit),
      unit: unit)
  }
  
  /**
   * Multiply as `self * that` and return a `Quantity` in `unit`.  If domain `R` is incompatible 
   * with the product of domains `D` and `S`, then Optional.None is returned.  If the units for
   * `self', `that` or `unit` include an `offset`, then Optional.None is returned.
   *
   * - parameter that: The multiplicand
   * - parameter unit: The unit for the result
   *
   * - returns: An optional `Quantity` in `unit` with the product result.
   */
  public func mul<R:Dimension, S:Dimension> (_ that: Quantity<S>, unit: Unit<R>) -> Quantity<R>? {
    guard DimensionBase.compatibleAsProduct(r: R.encoding, p1: D.encoding, p2: S.encoding) else { return nil }
    guard self.unit.isScaleUnit && that.unit.isScaleUnit && unit.isScaleUnit else { return nil }
    return Quantity<R>(value: unit.convertFromRoot (self.valueToRoot * that.valueToRoot), unit: unit)
  }
  
  /**
   * Divide as `self / that` and return a `Quantity` in `unit`.  If domain `R` is incompatible
   * with the division of domains `D` and `S`, then Optional.None is returned.  If the units for
   * `self', `that` or `unit` include an `offset`, then Optional.None is returned.
   *
   * - parameter that: The dividand
   * - parameter unit: The unit for the result
   *
   * - returns: An optional `Quantity` in `unit` with the product result.
   */
  public func div<R:Dimension, S:Dimension> (_ that: Quantity<S>, unit: Unit<R>) -> Quantity<R>? {
    guard DimensionBase.compatibleAsQuotient(r: R.encoding, p1: D.encoding, p2: S.encoding) else { return nil }
    guard self.unit.isScaleUnit && that.unit.isScaleUnit && unit.isScaleUnit else { return nil }
    return Quantity<R>(value: unit.convertFromRoot (self.valueToRoot / that.valueToRoot), unit: unit)
  }
}

// MARK: Operators

public func == <D: Dimension> (lhs: Quantity<D>, rhs: Quantity<D>) -> Bool {
  return // lhs === rhs ||
    lhs.unit.convertToRoot(lhs.value) == rhs.unit.convertToRoot(rhs.value)
}

public func != <D: Dimension> (lhs: Quantity<D>, rhs: Quantity<D>) -> Bool {
  return // lhs !== rhs &&
    lhs.unit.convertToRoot(lhs.value) != rhs.unit.convertToRoot(rhs.value)
}

public func < <D: Dimension> (lhs: Quantity<D>, rhs: Quantity<D>) -> Bool {
  return // lhs !== rhs &&
    lhs.unit.convertToRoot(lhs.value) < rhs.unit.convertToRoot(rhs.value)
}

public func <= <D: Dimension> (lhs: Quantity<D>, rhs: Quantity<D>) -> Bool {
  return // lhs === rhs ||
    lhs.unit.convertToRoot(lhs.value) <= rhs.unit.convertToRoot(rhs.value)
}

public func > <D: Dimension> (lhs: Quantity<D>, rhs: Quantity<D>) -> Bool {
  return // lhs !== rhs &&
    lhs.unit.convertToRoot(lhs.value) > rhs.unit.convertToRoot(rhs.value)
}

public func >= <D: Dimension> (lhs: Quantity<D>, rhs: Quantity<D>) -> Bool {
  return // lhs === rhs ||
    lhs.unit.convertToRoot(lhs.value) >= rhs.unit.convertToRoot(rhs.value)
}

public func + <D: Dimension> (lhs: Quantity<D>, rhs: Quantity<D>) -> Quantity<D> {
  return lhs.add(rhs)
}

public func - <D: Dimension> (lhs: Quantity<D>, rhs: Quantity<D>) -> Quantity<D> {
  return lhs.sub(rhs)
}

// MARK: String Convertible

extension Quantity : CustomStringConvertible {
  public var description : String {
    return "\(value) \(unit.symbol)"
  }
}

extension Quantity : CustomDebugStringConvertible {
  public var debugDescription : String {
    return "{Quantity<> value: \(value) unit: \(unit.symbol)}"
  }
}

