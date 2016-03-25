//
//  System.swift
//  SBUnits
//
//  Created by Ed Gamble on 11/1/15.
//  Copyright © 2015 Edward B. Gamble Jr.  All rights reserved.
//
//  See the LICENSE file at the project root for license information.
//  See the CONTRIBUTORS file at the project root for a list of contributors.
//

let π = Double.pi

// MARK: Base Units

/** The `Mass` (M) dimension */
public class Mass : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.mass, 1) }

public let kilogram = Unit<Mass>("kilogram", "kg")

public let gram = Unit<Mass> (kilogram, "gram", "g",
  scale: 1.0e-3, offset: 0.0)

public let milligram = Unit<Mass> (kilogram, "milligram", "mg",
  scale: 1.0e-6, offset: 0.0)

// Officially: https://en.wikipedia.org/wiki/International_yard_and_pound
public let pound = Unit<Mass> (kilogram, "pound", "lb",
  scale: 0.45359237, offset: 0.0)

public let ounce = Unit<Mass>(pound, "ounce", "oz",
  scale: 1/16.0, offset: 0.0)

/** The `Length` (L) dimension */
public class Length : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.length, 1) }

public let meter = Unit<Length>("meter", "m")

public let millimeter = Unit<Length> (meter, scale: Scale.milli)
public let centimeter = Unit<Length> (meter, scale: Scale.centi)
public let kilometer  = Unit<Length> (meter, scale: Scale.kilo)

// Officially: https://en.wikipedia.org/wiki/Yard
public let yard = Unit<Length> (meter, "yard", "yd",
  scale: 0.9144, offset: 0.0)

public let foot = Unit<Length> (yard, "foot", "ft",
  scale: 1/3, offset: 0.0)

public let inch = Unit<Length> (foot, "inch", "in",
  scale: 1/12, offset: 0.0)

public let mile = Unit<Length> (yard, "mile", "mile",
  scale: 1760, offset: 0.0)


/** The `Time` (T) dimension */
public class Time : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.time, 1) }

public let second = Unit<Time>("second", "s")

public let millisecond = Unit<Time> (second, scale: Scale.milli)
public let microsecond = Unit<Time> (second, scale: Scale.micro)
public let nanosecond  = Unit<Time> (second, scale: Scale.nano)

public let minute = Unit<Time> (second, "minute", "min", scale: 60.0)
public let hour   = Unit<Time> (second, "hour",   "hr",  scale: 3600.0)

/** The `Current` (I) dimension */
public class Current : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.current, 1) }

public let ampere = Unit<Current>("ampere", "A")

public let milliampere = Unit<Current>(ampere, scale: Scale.milli)

/** The `Temperature` (Θ) dimension */
public class Temperature : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.temperature, 1) }

public let kelvin     = Unit<Temperature> ("kelvin", "K")

public let celsius    = Unit<Temperature> (kelvin, "celsius",    "C",
  scale: 1.0,       offset: -273.15)

public let fahrenheit = Unit<Temperature> (kelvin, "fahrenheit", "F",
  scale: (5.0/9.0), offset: -255.37222222222222)

/** The `Intensity` (J) dimension */
public class Intensity : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.intensity, 1) }

public let candela = Unit<Intensity> ("candela", "cd")

/** The `Amount` (N) dimension */
public class Amount : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.amount, 1) }

public let mole = Unit<Amount> ("mole", "mol")

/** The (plane) `Angle` (R) dimension */
public class Angle : Dimension { public static let encoding = DimensionBase.encode(DimensionBase.angle, 1) }

public let radian = Unit<Angle> ("radian", "rad")
public let degree = Unit<Angle> (radian, "degree", "deg", scale: π/180.0)

// steradian

// MARK: Derived Units

// Absorbed Dose Rate

// Acceleration
public class Acceleration       : Dimension { public static let encoding = DimensionBase.encode(0, 1, -2, 0, 0, 0, 0, 0) }

public let metersPerSecondPerSecond = Unit<Acceleration>("metersPerSecondPerSecond", "m/s²")

public let feetPerSecondPerSecond = Unit<Acceleration>(metersPerSecondPerSecond,
  "feetPerSecondPerSecond", "ft/s²", scale: 0.3048)

// Angular Acceleration
public class AngularAcceleration: Dimension { public static let encoding = DimensionBase.encode(0, 0, -2, 0, 0, 0, 0, 1) }
public class AngularSpeed       : Dimension { public static let encoding = DimensionBase.encode(0, 0, -1, 0, 0, 0, 0, 1) }
public class AngularMomentum    : Dimension { public static let encoding = DimensionBase.encode(1, 2, -1, 0, 0, 0, 0, 0) }
public class Area               : Dimension { public static let encoding = DimensionBase.encode(0, 2,  0, 0, 0, 0, 0, 0) }

public let meterSquared = Unit<Area>("meterSquared", "m²")

public let footSquared = Unit<Area>(meterSquared, "footSquared", "ft²", scale: 0.092903)

public let acre = Unit<Area>(meterSquared, "acre", "acre", scale: 4046.86)

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

public let coulomb = Unit<Charge>("coulomb", "C")

// (Electric) Capacitance (I2 T4 M−1 L−2
public class Capacitance : Dimension { public static let encoding = DimensionBase.encode(-1, -1, 4, 2, 0, 0, 0, 0) }

public let farad     = Unit<Capacitance> ("farad", "F")
public let picofarad = Unit<Capacitance> (farad, scale: Scale.pico)

// (Electric) Charge Density
// (Electric) Displacement
// (Electric) Field Strength

// (Electric) Conductance (L−2 M−1 T3 I2)
public class Conductance : Dimension { public static let encoding = DimensionBase.encode(-2, -1, 3, 2, 0, 0, 0, 0) }

public let siemens = Unit<Conductance>("seimens", "S")

// (Electric) Inductance (M L2 T−2 I−2)
public class Inductance : Dimension { public static let encoding = DimensionBase.encode(1, 2, -2, -2, 0, 0, 0, 0) }

public let henry = Unit<Inductance>("henry", "H")

// (Electric) Potential (L2 M T−3 I−1)
public class ElectricPotential : Dimension { public static let encoding = DimensionBase.encode(1, 2, -3, -1, 0, 0, 0, 0) }

public let volt = Unit<ElectricPotential>("volt", "V")

public let kiloVolt  = Unit<ElectricPotential> (volt, scale: Scale.kilo)
public let milliVolt = Unit<ElectricPotential> (volt, scale: Scale.milli)

// (Electric) Resistance (L2 M T−3 I−2)
public class Resistance : Dimension { public static let encoding = DimensionBase.encode(1, 2, -3, -2, 0, 0, 0, 0) }

public let ohm = Unit<Resistance>("ohm", "Ω")

public let kiloOhm = Unit<Resistance>(ohm, scale: Scale.kilo)
public let megaOhm = Unit<Resistance>(ohm, scale: Scale.mega)
public let gigaoOhm = Unit<Resistance>(ohm, scale: Scale.giga)

// Energy
public class Energy      : Dimension { public static let encoding = DimensionBase.encode(1, 2, -2, 0, 0, 0, 0, 0) }

public let joule   = Unit<Energy>("joule", "J")

public let milliJoule = Unit<Energy>(joule, scale: Scale.milli)
public let kiloJoule  = Unit<Energy>(joule, scale: Scale.kilo)
public let megaJoule  = Unit<Energy>(joule, scale: Scale.mega)

public let kcal = Unit<Energy>(joule, "kilocalorie", "kcal", scale: 4184)


// Energy Density

// Entropy

// Force
public class Force : Dimension { public static let encoding = DimensionBase.encode(1, 1, -2, 0, 0, 0, 0, 0) }

public let newton  = Unit<Force> ("newton", "N")

public let poundForce = Unit<Force>(newton, "poundForce", "lbf", scale: 4.44822)

// Fuel Efficiency

// Impulse
public class Impulse : Dimension { public static let encoding = DimensionBase.encode(1, 1, -1, 0, 0, 0, 0, 0) }

// Frequencey
public class Frequency : Dimension { public static let encoding = DimensionBase.encode(0, 0, -1, 0, 0, 0, 0, 0) }

public let hertz = Unit<Frequency> ("hertz", "Hz")

public let kiloHertz = Unit<Frequency> (hertz, scale: Scale.kilo)
public let megaHertz = Unit<Frequency> (hertz, scale: Scale.mega)

// Half-Life
// Heat
// Heat Capacity
// Heat Flux Density

// Illuminance (J L−2)
public class Illuminance : Dimension { public static let encoding = DimensionBase.encode(0, -2, 0, 0, 0, 1, 0, 0) }

public let lux  = Unit<Illuminance> ("lux", "lx")

// Impedance (Resistance)
// Index of Refraction

// Irradiance
// Intensity
// Jerk
// Jounce
// Linear Density

// Luminous Flux
public class LuminousFlux : Dimension { public static let encoding = DimensionBase.encode(0, 0, 0, 0, 0, 1, 0, 0) }

public let lumen  = Unit<LuminousFlux> ("lumen", "lm")  // lm = cd sr

// Mach Number

// (Magnetic) Field Strength

// (Magnetic) Flux (M L2 T−2 I−1)
public class MagneticFlux : Dimension { public static let encoding = DimensionBase.encode(1, 2, -2, -1, 0, 0, 0, 0) }

public let weber = Unit<MagneticFlux>("weber", "Wb")

// (Magnetic) Flux Density (M T−2 I−1)
public class MagneticFluxDensity : Dimension { public static let encoding = DimensionBase.encode(1, 0, -2, -1, 0, 0, 0, 0) }

public let tesla = Unit<MagneticFluxDensity>("tesla", "T")

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

public let kilogramMeterPerSecond = Unit<Momentum>("kilogram-meter/second", "kg-m/s")

public let newtonSecond = Unit<Momentum>(kilogramMeterPerSecond, "Newton-second", "N-s", scale: 1.0) // alias

// Permeability
// Permittivity

// Power
public class Power : Dimension { public static let encoding = DimensionBase.encode(1,  2, -3, 0, 0, 0, 0, 0) }

public let watt = Unit<Power>("watt", "W")

// Pressure
public class Pressure : Dimension { public static let encoding = DimensionBase.encode(1, -1, -2, 0, 0, 0, 0, 0) }

public let pascal = Unit<Pressure>("pascal", "Pa")

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

public let metersPerSecond = Unit<Speed> ("metersPerSecond", "m/s")

public let milesPerHour = Unit<Speed> (metersPerSecond, "milesPerHour", "miles/hr",
  scale: 5380.0/3600, offset: 0)

public let kilometersPerHour = Unit<Speed> (metersPerSecond, "kilometersPerHour", "km/hr",
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

public let meterCubed = Unit<Volume>("meterCubed", "m³")

// Wavelength
// Wavenumber
// Weight -> Force
// Work   -> Energy
// Young's Modulus
