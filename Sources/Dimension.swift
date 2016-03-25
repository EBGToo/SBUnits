//
//  Dimension.swift
//  SBUnits
//
//  Created by Ed Gamble on 10/30/15.
//  Copyright © 2015 Opus Logica Inc. All rights reserved.
//

// References:
// https://en.wikipedia.org/wiki/Dimensional_analysis
//
// "The dimension of a physical quantity can be expressed as a product of the basic physical
// dimensions length, mass, time, electric charge, and absolute temperature, represented by
// sans-serif roman symbols L, M, T, Q, and Θ,[16] respectively, each raised to a rational power.
//
// "The term dimension is more abstract than scale unit: mass is a dimension, while kilograms are a
// scale unit (choice of standard) in the mass dimension.
//
// "As examples, the dimension of the physical quantity speed is length/time (L/T or LT−1), and the
// dimension of the physical quantity force is "mass × acceleration" or "mass×(length/time)/time"
// (ML/T2 or MLT−2).
//
// "The unit of a physical quantity and its dimension are related, but not identical concepts. The
// units of a physical quantity are defined by convention and related to some standard; e.g. length
// may have units of metres, feet, inches, miles or micrometres; but any length always has a
// dimension of L, no matter what units of length are chosen to measure it. Two different units of
// the same physical quantity have conversion factors that relate them. For example, 1 in = 2.54 cm;
// in this case (2.54 cm/in) is the conversion factor, and is itself dimensionless. Therefore,
// multiplying by that conversion factor does not change a quantity. Dimensional symbols do not
// have conversion factors.
//
// "The SI standard recommends the usage of the following dimensions and corresponding symbols:
// length (L), mass (M), time (T), electric current (I), absolute temperature (Θ), 
// amount of substance (N) and luminous intensity (J)."

// MARK: Dimension

/**
 * A `DimensionBaseEncoding` is the exponent of a single DimensionBase.  A DimensionBase, such as
 * Length (L), can be positive, zero, or negative.  For example, Area as L², has an exponent of
 * '2'; Time as T, has an L exponent of '0'; Density as M/L³ has an exponent of '3'.  In practice
 * exponents over '3' are rare; the 4th derivaties of Length with respect to Time is called
 * 'Jounce'; the 5th and 6th derivates are known as 'Crackle' and 'Pop' but they are not known
 * to have a physical interpretation.
 */
public typealias DimensionBaseEncoding = Int8

/**
 * A `DimensionEncoding` is the set of `DimensionBaseEncoding` for each `DimensionBase`.  Each 
 * Dimension can be represented as powers of DimensionBases; for example, 'speed' is L/T; 'density'
 * is 'M/L³; 'area' is L².  A `DimensionEncoding` stores the power (a DimensionBaseEncoding) for
 * each of the defined DimensionBases.
 */
public typealias DimensionEncoding = [DimensionBaseEncoding]

/**
 * A `Dimension` identifies commensurate physical quantities.
 */
public protocol Dimension {
  
  /** The encoding */
  static var encoding : DimensionEncoding { get }
}

/**
 * A `DimensionBase` enumerates the SI Standard's recommended base dimensions.  These base
 * dimensions encode their own `Dimension` and are used to compose other compound dimensions based
 * on exponents of each `DimensionBase`.  For example, Length (L) and Time (T) are base dimensions; 
 * Speed can be composed as L/T and Volume as L^3.
 *
 * The base dimensions are:
 * - M: Mass
 * - L: Length
 * - T: Time
 * - I: Current
 * - Θ: Temperature
 * - J: Intensity
 * - N: Amount
 * - R: Angle
 */
enum DimensionBase : Int {
  case Mass = 0
  case Length
  case Time
  case Current
  case Temperature
  case Intensity
  case Amount
  case Angle
  // plane angle
  // solid angle
  
  static let DIMENSION_BASE_COUNT = 1 + Angle.rawValue

  /** The DimensionBase names */
  static var names   = ["Mass", "Length", "Time", "Current", "Temperature", "Intensity", "Amount", "Angle"]
  
  /** The DimensionBase symbols */
  static var symbols = ["M", "L", "T", "I", "Θ", "J", "N", "R"] // R??
  
  /** The DimensionBase name */
  var name   : String { return DimensionBase.names   [self.rawValue] }

  /** The DimensionBase symbol */
  var symbol : String { return DimensionBase.symbols [self.rawValue] }

  /** The DimensionBase description as the DimensionBase name */
  var description : String { return self.name }

  /**
   * Encode a single `DimensionBase`.
   *
   * - argument base: The DimensionBase
   * - argument power: The power of the DimensionBase
   *
   * - returns: The DimensionEncoding
   */
  static func encode (base: DimensionBase, _ power: DimensionBaseEncoding) -> DimensionEncoding {
    var encoding = Array<Int8>(count: DIMENSION_BASE_COUNT, repeatedValue: 0)
    encoding[base.rawValue] = power
    return encoding
  }

  /**
   * Encode every DimensionBase
   *
   * - argument powers: The powers for each `DimensionBase`
   *
   * - precondition: The power array count must be `DIMENSION_BASE_COUNT`
   *
   * - returns: The `DimensionEncoding`
   */
  static func encode (powers: DimensionBaseEncoding...) -> DimensionEncoding {
    precondition(powers.count == DIMENSION_BASE_COUNT)
    return powers
  }
  
  /**
   * Decode a `DimensionEncoding` to extract the `DimensionBaseEncoding` for the `DimensionBase`
   *
   * - argument base: The `DimensionBase` to extract
   * - argument encoding: The `DimensionBase` encoding
   *
   * - returns: The `DimensionBaseEncoding` of the base
   */
  static func decode(base: DimensionBase, _ encoding: DimensionEncoding) -> DimensionBaseEncoding {
    return encoding[base.rawValue]
  }
  
  /**
   * Combine two DimensionBase powers to produce a DimensionEncoding
   *
   * - argument base1:
   * - argument power1:
   * - argument base2:
   * - argument power2:
   *
   * - returns: The `DimensionEncoding`
   */
  static func combine (base1 base1: DimensionBase, power1: DimensionBaseEncoding,
    base2: DimensionBase, power2: DimensionBaseEncoding) -> DimensionEncoding {
      var encoding = encode (base1, power1)
      encoding[base2.rawValue] += power2
      return encoding
  }
  
  /**
   * Check if a `DimensionEncoding` is compatible with the product of two `DimensionEncodings`.
   * Compatibility for the product is defined as r = p1 + p2 for each DimensionBase in the
   * encodings.
   *
   * - parameter: r: The `DimensionEncoding` result to confirm
   * - parameter: p1: One `DimensionEncoding` summand
   * - parameter: p2: The other `DimensionEncoding` summand
   *
   * - returns: `true` if compatible; `false` otherwise.
   */
  static func compatibleAsProduct (r:DimensionEncoding, p1:DimensionEncoding, p2:DimensionEncoding) -> Bool {
    return zip(p1, p2).map(+).elementsEqual(r)
  }
  
  /**
   * Check if a `DimensionEncoding` is compatible with the quotient of two `DimensionEncodings`.
   * Compatibility for the quoteint is defined as r = p1 - p2 for each DimensionBase in the
   * encodings.
   *
   * - parameter: r: The `DimensionEncoding` result to confirm
   * - parameter: p1: One `DimensionEncoding` summand
   * - parameter: p2: The other `DimensionEncoding` summand
   *
   * - returns: `true` if compatible; `false` otherwise.
   */
  static func compatibleAsQuotient (r:DimensionEncoding, p1:DimensionEncoding, p2:DimensionEncoding) -> Bool {
    return zip(p1, p2).map(-).elementsEqual(r)
  }
}

// MARK: Scale

/**
 * A (Unit) Scale is a named factor for scaling a unit.  Common scale are, for example, 'kilo' 
 * (10^3) and 'milli' (10^-3).  Defined scales exist from 10^-24 to 10^24.
 *
 * A Scale can also be a simple value
 *
 */
public enum Scale { // ScaleFactor
  case Prefix (Double, String, String)   // factor, name, symbol
  case Value (Double)
  
  /** The `Scale` factor */
  var factor : Double {
    switch self {
    case let Prefix (factor, _, _): return factor
    case let Value (factor): return factor
    }
  }
  
  /** The `Scale` name */
  var name : String? {
    switch self {
    case let Prefix (_, name, _): return name
    case Value: return nil
    }
  }
  
  /** The `Scale` symbol */
  var symbol : String? {
    switch self {
    case let Prefix (_, _, symbol): return symbol
    case Value: return nil
    }
  }
  
  public static let yocto = Scale.Prefix (1e-24, "yocto", "y")
  public static let zepto = Scale.Prefix (1e-21, "zepto", "z")
  public static let atto  = Scale.Prefix (1e-18, "atto",  "a")
  public static let femto = Scale.Prefix (1e-15, "femto", "f")
  public static let pico  = Scale.Prefix (1e-12, "pico",  "p")
  public static let nano  = Scale.Prefix (1e-09, "nano",  "n")
  public static let micro = Scale.Prefix (1e-06, "micro", "µ")
  public static let milli = Scale.Prefix (1e-03, "milli", "m")
  public static let centi = Scale.Prefix (1e-02, "centi", "c")
  public static let deci  = Scale.Prefix (1e-01, "deci",  "d")
  //
  public static let deca  = Scale.Prefix (1e+01, "deca",  "da")
  public static let hect  = Scale.Prefix (1e+02, "hecto", "h")
  public static let kilo  = Scale.Prefix (1e+03, "kilo",  "k")
  public static let mega  = Scale.Prefix (1e+06, "mega",  "M")
  public static let giga  = Scale.Prefix (1e+09, "giga",  "G")
  public static let tera  = Scale.Prefix (1e+12, "tera",  "T")
  public static let peta  = Scale.Prefix (1e+15, "peta",  "P")
  public static let exa   = Scale.Prefix (1e+18, "exa",   "E")
  public static let zetta = Scale.Prefix (1e+21, "zetta", "Z")
  public static let yotta = Scale.Prefix (1e+24, "yotta", "Y")
}