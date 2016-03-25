//
//  Unit.swift
//  SBUnits
//
//  Created by Ed Gamble on 10/31/15.
//  Copyright © 2015 Opus Logica Inc. All rights reserved.
//

// References:
// https://en.wikipedia.org/wiki/SI_derived_unit
// https://en.wikipedia.org/wiki/Base_unit_(measurement)

// MARK: Unit

/**
 * A `Unit` is a defined amount of a physical quantity.  `Units` fall into two categories, 'base
 * units' and 'derived units'.  Base Units are defined amounts of Base Quantities; there are 
 * Base Units for each Base Dimension (M, L, T, I, Θ, J, N, R).  Derived Units are powers of
 * Base Units (L/T, M/L³).
 *
 * Every `Unit`, base or dervied, measures a quantity in a specified Dimension.  Units with the
 * same Dimension are related by scale+offset values.  For example, a base unit 'meter' has 
 * dimension 'L'; the 'scaled unit' of 'kilometer' is 1000 meters.  A base unit of 'kelvin' has
 * dimension 'T'; the 'scaled unit' of 'celsius' has a scale of 1.0 and an offset of -273.15 from
 * kelvin.
 * 
 * Two units of the same dimension can be in a parent/child relationship.  For example, 'kilometer'
 * has a parent of 'meter' (the base unit); similarly 'millimeter' has a parent of 'meter' as well.
 * (The relationship is not defined by a standard).
 *
 * Two units of the same dimension may not be in a parent/child relationship but will always share
 * a base unit (as the two units are in the same dimension).  For example, 'kilometer' and
 * 'millimeter' are not in a parent/child relationship but they share 'meter'
 *
 * Conversion between units is only possible when units have the same dimension.  The conversion
 * from Y to X proceeds up the parents of Y until X is reached (if Y and X have a parent/child
 * relationshp) or proceeds from Y up to its root and then down to X.
 *
 */
public final class Unit<D:Dimension> {
  
  /** The `Unit` optional parent. */
  public let parent : Unit<D>!
  
  /** The `Unit` scale. */
  public let scale  : Scale
  
  /** The `Unit` offset. */
  public let offset : Double

  /** The `Unit` name. */
  public let name   : String
  
  /** The `Unit` symbol. */
  public let symbol : String
  
  /** The `Unit` root unit; can be a 'base unit' or a 'derived unit'  */
  public var root : Unit<D> {
    return nil == parent ? self : parent.root
  }
  
  /** Check if `unit` is a root unit */
  var isRoot : Bool {
    return nil == parent
  }
  
  /** Check if `unit` is the `parent` of `self` */
  func isParent (unit: Unit<D>) -> Bool {
    return parent === unit
  }

  /** Check if `unit` is an ancestor (including `self`) of `self` */
  func isAncestor (unit: Unit<D>) -> Bool {
    return unit === self || (parent?.isAncestor(unit) ?? false)
  }
  
  /** Check if `unit` is a 'scale unit' (has no `offset`) */
  var isScaleUnit : Bool {
    return 0 == offset
  }
  
  // MARK: Initializer

  /* Create an instance as a base unit (of the provided Dimension) */
  internal init (_ name: String, _ symbol: String) {
    self.parent = nil
    self.scale  = Scale.Value(1.0)
    self.offset = 0.0

    self.name   = name
    self.symbol = symbol
  }

  /** Create an instance of a 'scaled unit' */
  public init (_ parent: Unit<D>, _ name: String, _ symbol: String, scale: Scale, offset: Double = 0.0) {
    self.parent = parent
    self.scale  = scale
    self.offset = offset
    
    self.name   = name
    self.symbol = symbol

  }
  
  /** Create an instance.  The `name` and `symbol` are derived from the `parent` and `scale. */
  public convenience init (_ parent: Unit<D>, scale: Scale) {
    self.init (parent, (scale.name ?? "") + parent.name, (scale.symbol ?? "") + parent.symbol,
      scale: scale)
  }

  /** Create an instance */
  public convenience init (_ parent: Unit<D>, _ name: String, _ symbol: String, scale: Double, offset: Double = 0.0) {
    self.init (parent, name, symbol,
      scale: Scale.Value(scale),
      offset: offset)
  }
  
  // MARK: Convert
  
  /**
   * Convert `value` (in `self`) to the equivalent value represented in `parent`.  If `self` has
   * no parent (as a `base`), then `value` itself is returned; otherwise the `scale` and `offset`
   * are applied.
   *
   * - parameter value: The value to convert.
   *
   * - returns: The converted value
   */
  public func convertToParent (value: Double) -> Double {
    return nil == parent
      ? value
      : scale.factor * value - offset
  }
  
  /**
   * Convert `value` (in `parent`) to the equivalent value represented in `self`.  If `self` has
   * no parent (as a `base`), then `value` itself is returned; otherwise the `scale` and `offset`
   * are applied.
   *
   * - parameter value: The value to convert.
   *
   * - returns: The converted value
   */
  public func convertFromParent (value: Double) -> Double {
    return nil == parent
      ? value
      : (value + offset) / scale.factor
  }
  
  /**
   * Convert `value` (in `self`) to the equivalent value represented in `root`.  If `self` is
   * already the root, then `value` itself is returned; otherwise the `scale` and `offset` are
   * applied through to `root`.
   *
   * - parameter value: The value to convert.
   *
   * - returns: The converted value
   */
  public func convertToRoot (value: Double) -> Double {
    return nil == parent
      ? value
      : parent.convertToRoot (convertToParent(value))
  }
  
  /**
   * Convert `value` (in `root`) to the equivalent value represented in `self`.  If `self` is 
   * already `root`, then `value` itself is returned; otherwise the `scale` and `offset` are applied
   * through to `self`.
   *
   * - parameter value: The value to convert.
   *
   * - returns: The converted value
   */
  public func convertFromRoot (value: Double) -> Double {
    return nil == parent
      ? value
      : convertFromParent (parent.convertFromRoot (value))
  }
  
  /**
   * Convert `value` in `unit` to `self`.  If `self` is already `unit`, then `value` itself is
   * returned; otherwise the `value` is converted from `unit` to `self`.
   *
   * - parameter value: The value to convert.
   * - parameter unit: The unit for value
   *
   * - return: the convert value in `self`.
   */
  public func convert (value: Double, unit: Unit<D>) -> Double {
    // It is important that if unit is a descendent of self.unit then the conversions only
    // progress up to self.unit.  This allows users to set their own 'effective base' unit, 
    // particularly important for a time epoch (J2000, Unix, etc).
    
    // This only moves up from unit, parent by parent.  If self is below unit then we go all the
    // way up to root adn then down to self.
    
    if self === unit {
      return value
    }
    else if unit.isRoot {
      precondition(self.root === unit.root)
      return convertFromRoot(value)
    }
    else {
      return convert(unit.convertToParent(value), unit: unit.parent!)
    }
  }
}

