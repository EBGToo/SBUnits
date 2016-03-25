# Dimensions, Units and Quantities

A number without its unit of measure is meaningless at best and dangerous at worst. The unit 
provides the context within which to interpret the value. For 'commensurate' units (units in the
same `Dimension`), the unit disambiguates different scalings. For example, is the length of 4.6 
in feet or meters? For 'incommensurate' units, the unit limits the valid operations between units.
For example, you can't add meters and seconds.

**No Naked Numbers** 

Software engineers (have been known to) annotate their code to identify the unit 'associated' with
a number.  The annotation may be in a comment:

```swift
    double distance = 0.0 // in miles
```

or it may be in the variable's name:

```swift
    double distanceInMiles = 0.0;
```

or in the documenation:

```swift
    /** The distance in miles */
    double distance = 0.0;
```

None of these appoaches scales with a program's size/complexity'.  The code comment is lost when 
code is delivered as a library, the name might be onerous to type and limit use of more convenient
units and the documentation needs to be referenced or remembered.  It is surely safest to pair the
number with its unit.

![License](https://img.shields.io/cocoapods/l/SBUnits.svg)
[![Language](https://img.shields.io/badge/lang-Swift-orange.svg?style=flat)](https://developer.apple.com/swift/)
![Platform](https://img.shields.io/cocoapods/p/SBUnits.svg)
![](https://img.shields.io/badge/Package%20Maker-compatible-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/SBUnits.svg)](http://cocoapods.org)

## Features


### Dimensions

A dimension identifies commensurate physical quantities. There is a defined set of `base 
dimensions` as: Mass (M), Length(L), Time(T), Current(I), Temperature(Θ), Intensity(J), Amount(N),
and (Planar) Angle(R). [Note Planar Angle and Spherical Angle are non-standard; we use one but
not the other].  From these `base dimensions`, `derived dimensions` can be construct with 
exponents of the base. For example a unit for `Area` is L² which is 'encoded' from the base 
dimensions as L with '2' and all others with '0'; a unit of Acceleration is L/T² and is 'encode' as
L with '1', T with '-2' and all others with '0'

Only units with the same dimension can be added/subtracted with one another. When units are 
multiplied the exponents of the base dimensions are added to produce another dimension.

For type-safe operations on units, we designate `Dimension` as a 'type parameter' in `Unit` and 
`Quantity` type declarations. This allows a statically types system of units (with an exception
or two)

### Units

A `Unit` is a defined amount of a physical quantity. `Units` fall into two categories based on 
their dimension: 'base units' and 'derived units'. 

Every `Unit`, base or dervied, measures a quantity in a specified Dimension. Units with the same 
`Dimension` are related by scale+offset values.  For example, a base unit 'meter' has  dimension
'L'; the 'scaled unit' of 'kilometer' is 1000 meters.  A base unit of 'kelvin' has dimension 'Θ'; 
the 'scaled unit' of 'celsius' has a scale of 1.0 and an offset of -273.15 from kelvin.

Producs or Ratios of units with an offset is ill-defined.

### Quantities

A `Quantity` is a magnitude (or multitude) of a physical property. A Quantity has a `Dimension`
that identifies the type of the physical property; quanities with the same `Dimension` can be
compared with one another.  

A `Quantity` has a `value` and a `unit`. Comparisons between quantities is performed based on
values with the same unit; unit conversion is implicit.

Quanties can be added and subtracted.

Quantities can be conditionally multiplied and divided.  It is possible that the target of the 
product (or division), is specified with a Dimension that is inconsistent with the product.  For
example Volume = Length * Length.  In such cases the result of the product is `nil`.

## Usage


## Installation


### Apple Package Manager

In your Package.swift file, add a dependency on SBUnits:

```swift
import PackageDescription

let package = Package (
  name: "<your package>",
  dependencies: [
     // ...
    .Package (url: "https://github.com/opuslogica/SBUnits.git",  majorVersion: 1),
    // ...
  ]
)
```

### Cocoa Pods

```ruby
source 'https://github.com/EBGToo/CocoaPodSpecs.git'
pod 'SBUnits', '~> 0.1'
```

### XCode

```bash
$ git clone https://github.com/opuslogica/SBUnits.git SBUnits
```

Add the `SBUnits` Xcode Project to your Xcode Workspace.

