//
//  System.swift
//  SBUnits
//
//  Created by Ed Gamble on 11/1/15.
//  Copyright © 2015 Opus Logica Inc. All rights reserved.
//
#if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)
  import Darwin.C.math // M_PI
#else
  import Glibc
#endif

let π = M_PI

// MARK: Base Units

/** The `Mass` (M) dimension */
public class Mass : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.mass, 1) }

public let kilogram = UnitX<Mass>("kilogram", "kg")

public let gram = UnitX<Mass> (kilogram, "gram", "g",
  scale: 1.0e-3, offset: 0.0)

public let milligram = UnitX<Mass> (kilogram, "milligram", "mg",
  scale: 1.0e-6, offset: 0.0)

// Officially: https://en.wikipedia.org/wiki/International_yard_and_pound
public let pound = UnitX<Mass> (kilogram, "pound", "lb",
  scale: 0.45359237, offset: 0.0)

public let ounce = UnitX<Mass>(pound, "ounce", "oz",
  scale: 1/16.0, offset: 0.0)

/** The `Length` (L) dimension */
public class Length : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.length, 1) }

public let meter = UnitX<Length>("meter", "m")

public let millimeter = UnitX<Length> (meter, scale: Scale.milli)
public let centimeter = UnitX<Length> (meter, scale: Scale.centi)
public let kilometer  = UnitX<Length> (meter, scale: Scale.kilo)

// Officially: https://en.wikipedia.org/wiki/Yard
public let yard = UnitX<Length> (meter, "yard", "yd",
  scale: 0.9144, offset: 0.0)

public let foot = UnitX<Length> (yard, "foot", "ft",
  scale: 1/3, offset: 0.0)

public let inch = UnitX<Length> (foot, "inch", "in",
  scale: 1/12, offset: 0.0)

public let mile = UnitX<Length> (yard, "mile", "mile",
  scale: 1760, offset: 0.0)


/** The `Time` (T) dimension */
public class Time : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.time, 1) }

public let second = UnitX<Time>("second", "s")

public let millisecond = UnitX<Time> (second, scale: Scale.milli)
public let microsecond = UnitX<Time> (second, scale: Scale.micro)
public let nanosecond  = UnitX<Time> (second, scale: Scale.nano)

public let minute = UnitX<Time> (second, "minute", "min", scale: 60.0)
public let hour   = UnitX<Time> (second, "hour",   "hr",  scale: 3600.0)

/** The `Current` (I) dimension */
public class Current : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.current, 1) }

public let ampere = UnitX<Current>("ampere", "A")

public let milliampere = UnitX<Current>(ampere, scale: Scale.milli)

/** The `Temperature` (Θ) dimension */
public class Temperature : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.temperature, 1) }

public let kelvin     = UnitX<Temperature> ("kelvin", "K")

public let celsius    = UnitX<Temperature> (kelvin, "celsius",    "C",
  scale: 1.0,       offset: -273.15)

public let fahrenheit = UnitX<Temperature> (kelvin, "fahrenheit", "F",
  scale: (5.0/9.0), offset: -255.37222222222222)

/** The `Intensity` (J) dimension */
public class Intensity : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.intensity, 1) }

public let candela = UnitX<Intensity> ("candela", "cd")

/** The `Amount` (N) dimension */
public class Amount : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.amount, 1) }

public let mole = UnitX<Amount> ("mole", "mol")

/** The (plane) `Angle` (R) dimension */
public class Angle : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.angle, 1) }

public let radian = UnitX<Angle> ("radian", "rad")
public let degree = UnitX<Angle> (radian, "degree", "deg", scale: π/180.0)

// steradian

// MARK: Derived Units

// Absorbed Dose Rate

// Acceleration
public class Acceleration       : Dimension { public static let encoding = DimensionBase.encode(0, 1, -2, 0, 0, 0, 0, 0) }

public let metersPerSecondPerSecond = UnitX<Acceleration>("metersPerSecondPerSecond", "m/s²")

public let feetPerSecondPerSecond = UnitX<Acceleration>(metersPerSecondPerSecond,
  "feetPerSecondPerSecond", "ft/s²", scale: 0.3048)

// Angular Acceleration
public class AngularAcceleration: Dimension { public static let encoding = DimensionBase.encode(0, 0, -2, 0, 0, 0, 0, 1) }
public class AngularSpeed       : Dimension { public static let encoding = DimensionBase.encode(0, 0, -1, 0, 0, 0, 0, 1) }
public class AngularMomentum    : Dimension { public static let encoding = DimensionBase.encode(1, 2, -1, 0, 0, 0, 0, 0) }
public class Area               : Dimension { public static let encoding = DimensionBase.encode(0, 2,  0, 0, 0, 0, 0, 0) }

public let meterSquared = UnitX<Area>("meterSquared", "m²")

public let footSquared = UnitX<Area>(meterSquared, "footSquared", "ft²", scale: 0.092903)

public let acre = UnitX<Area>(meterSquared, "acre", "acre", scale: 4046.86)

// Area Density

// Catalytic Activity Concentration
// katal   (catalytic activity

// Chemical Potential
// Molar Concentration
// Crackle
// Current Density
// Dose Equivalent
// Dynamic Viscosity

// Charge
public class Charge : Dimension { public static let encoding = DimensionBase.encode(0, 0, 1, 1, 0, 0, 0, 0) }

public let coulomb = UnitX<Charge>("coulomb", "C")

// (Electric) Capacitance (I2 T4 M−1 L−2
public class Capacitance : Dimension { public static let encoding = DimensionBase.encode(-1, -1, 4, 2, 0, 0, 0, 0) }

public let farad     = UnitX<Capacitance> ("farad", "F")
public let picofarad = UnitX<Capacitance> (farad, scale: Scale.pico)

// (Electric) Charge Density
// (Electric) Displacement
// (Electric) Field Strength

// (Electric) Conductance (L−2 M−1 T3 I2)
public class Conductance : Dimension { public static let encoding = DimensionBase.encode(-2, -1, 3, 2, 0, 0, 0, 0) }

public let siemens = UnitX<Conductance>("seimens", "S")

// (Electric) Inductance (M L2 T−2 I−2)
public class Inductance : Dimension { public static let encoding = DimensionBase.encode(1, 2, -2, -2, 0, 0, 0, 0) }

public let henry = UnitX<Inductance>("henry", "H")

// (Electric) Potential (L2 M T−3 I−1)
public class ElectricPotential : Dimension { public static let encoding = DimensionBase.encode(1, 2, -3, -1, 0, 0, 0, 0) }

public let volt = UnitX<ElectricPotential>("volt", "V")

public let kiloVolt  = UnitX<ElectricPotential> (volt, scale: Scale.kilo)
public let milliVolt = UnitX<ElectricPotential> (volt, scale: Scale.milli)

// (Electric) Resistance (L2 M T−3 I−2)
public class Resistance : Dimension { public static let encoding = DimensionBase.encode(1, 2, -3, -2, 0, 0, 0, 0) }

public let ohm = UnitX<Resistance>("ohm", "Ω")

public let kiloOhm = UnitX<Resistance>(ohm, scale: Scale.kilo)
public let megaOhm = UnitX<Resistance>(ohm, scale: Scale.mega)
public let gigaoOhm = UnitX<Resistance>(ohm, scale: Scale.giga)

// Energy
public class Energy      : Dimension { public static let encoding = DimensionBase.encode(1, 2, -2, 0, 0, 0, 0, 0) }

public let joule   = UnitX<Energy>("joule", "J")

public let milliJoule = UnitX<Energy>(joule, scale: Scale.milli)
public let kiloJoule  = UnitX<Energy>(joule, scale: Scale.kilo)
public let megaJoule  = UnitX<Energy>(joule, scale: Scale.mega)

public let kcal = UnitX<Energy>(joule, "kilocalorie", "kcal", scale: 4184)


// Energy Density

// Entropy

// Force
public class Force : Dimension { public static let encoding = DimensionBase.encode(1, 1, -2, 0, 0, 0, 0, 0) }

public let newton  = UnitX<Force> ("newton", "N")

public let poundForce = UnitX<Force>(newton, "poundForce", "lbf", scale: 4.44822)

// Fuel Efficiency

// Impulse
public class Impulse : Dimension { public static let encoding = DimensionBase.encode(1, 1, -1, 0, 0, 0, 0, 0) }

// Frequencey
public class Frequency : Dimension { public static let encoding = DimensionBase.encode(0, 0, -1, 0, 0, 0, 0, 0) }

public let hertz = UnitX<Frequency> ("hertz", "Hz")

public let kiloHertz = UnitX<Frequency> (hertz, scale: Scale.kilo)
public let megaHertz = UnitX<Frequency> (hertz, scale: Scale.mega)

// Half-Life
// Heat
// Heat Capacity
// Heat Flux Density

// Illuminance (J L−2)
public class Illuminance : Dimension { public static let encoding = DimensionBase.encode(0, -2, 0, 0, 0, 1, 0, 0) }

public let lux  = UnitX<Illuminance> ("lux", "lx")

// Impedance (Resistance)
// Index of Refraction

// Irradiance
// Intensity
// Jerk
// Jounce
// Linear Density

// Luminous Flux
public class LuminousFlux : Dimension { public static let encoding = DimensionBase.encode(0, 0, 0, 0, 0, 1, 0, 0) }

public let lumen  = UnitX<LuminousFlux> ("lumen", "lm")  // lm = cd sr

// Mach Number

// (Magnetic) Field Strength

// (Magnetic) Flux (M L2 T−2 I−1)
public class MagneticFlux : Dimension { public static let encoding = DimensionBase.encode(1, 2, -2, -1, 0, 0, 0, 0) }

public let weber = UnitX<MagneticFlux>("weber", "Wb")

// (Magnetic) Flux Density (M T−2 I−1)
public class MagneticFluxDensity : Dimension { public static let encoding = DimensionBase.encode(1, 0, -2, -1, 0, 0, 0, 0) }

public let tesla = UnitX<MagneticFluxDensity>("tesla", "T")

// Magnetization
// Mass Fraction

public class Density : Dimension { public static let encoding = DimensionBase.encode(1, -3, 0, 0, 0, 0, 0, 0) }
// Mean Lifetime
// Molar Energy
// Molar Entropy
// Molar Heat Capacity

// MomentOfInertia
public class MomentOfInertia : Dimension { public static let encoding = DimensionBase.encode(1, 2,  0, 0, 0, 0, 0, 0) }

// Momentum
public class Momentum : Dimension { public static let encoding = DimensionBase.encode(1, 1, -1, 0, 0, 0, 0, 0) }

public let kilogramMeterPerSecond = UnitX<Momentum>("kilogram-meter/second", "kg-m/s")

public let newtonSecond = UnitX<Momentum>(kilogramMeterPerSecond, "Newton-second", "N-s", scale: 1.0) // alias

// Permeability
// Permittivity

// Power
public class Power : Dimension { public static let encoding = DimensionBase.encode(1,  2, -3, 0, 0, 0, 0, 0) }

public let watt = UnitX<Power>("watt", "W")

// Pressure
public class Pressure : Dimension { public static let encoding = DimensionBase.encode(1, -1, -2, 0, 0, 0, 0, 0) }

public let pascal = UnitX<Pressure>("pascal", "Pa")

// Pop

// (Radioactive) Activity
// becquerel (radioactivity)

// (Radioactive) Dose
// gray    (absorbed dose)
// sievert (equivalent dose)

// Radiance
// Radiant Intensity
// Reaction Rate

public class Speed       : Dimension { public static let encoding = DimensionBase.encode(0, 1, -1, 0, 0, 0, 0, 0) }

public let metersPerSecond = UnitX<Speed> ("metersPerSecond", "m/s")

public let milesPerHour = UnitX<Speed> (metersPerSecond, "milesPerHour", "miles/hr",
  scale: 5380.0/3600, offset: 0)

public let kilometersPerHour = UnitX<Speed> (metersPerSecond, "kilometersPerHour", "km/hr",
  scale: 1000.0/3600, offset: 0)

// public let feetPerSecond =


// Specific Energy
// Specific Heat Capacity
// Specific Volume
// Spin
// Strain
// Stress
// Surface Tension
// Thermal Conductivity
public class Torque : Dimension { public static let encoding = DimensionBase.encode(1, 2, -2, 0, 0, 0, 0, 0) }
// Velocity
public class Volume : Dimension { public static let encoding = DimensionBase.encode(0, 3, 0, 0, 0, 0, 0, 0) }

public let meterCubed = UnitX<Volume>("meterCubed", "m³")

// Wavelength
// Wavenumber
// Weight -> Force
// Work   -> Energy
// Young's Modulus
