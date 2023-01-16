import UIKit

// An enumeration defines a common type for a group of related values and
// enables you to work with those values in a type-safe way within your code.

/** ENUMERATION SYNTAX **/
enum SomeEnumeration {
    // enumeration definition goes here
}

enum CompassPoint: String {
    case north
    case south
    case east
    case west
}

// Swift enumeration cases don't have an integer value set by default, unlike
// languages like C and Objective-C.

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west
directionToHead = .east

var testDirection: CompassPoint
testDirection = .east

/** MATCHING ENUMERATION VALUES WITH A SWITCH STATEMENT **/
// You can match individual enumeration values with a switch statement:
directionToHead = .south

switch directionToHead {
case .north:
    print("Lots of planes have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

// ITERATING OVER ENUMERATION CASES
// If we want to iterate over a collection of enumeration cases,
// we need to enable this by writing :CaseIterable after the enumeration's
// name.
// Swift exposes a collection of allCases property of the enumeration type.

enum Beverage: CaseIterable {
    case coffee, tea, juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available.")

for beverage in Beverage.allCases {
    print("Beverage: \(beverage)")
}

/** ASSOCIATED VALUES **/
// It's sometimes useful to be able to store values of other types alongside
// these case values. The additional information is called an associated value,
// and it varies each time you use that case as a value in your code.

// This can be read as:
// define an enumeration type called Barcode, which can take either a value of
// upc with associated values of type (Int, Int, Int, Int) or a value of qrCode
// with an associated value of type String.
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
print("Product barcode: \(productBarcode)")

productBarcode = Barcode.qrCode("ABCDEFGHIJJAFJN")
print("Product barcode: \(productBarcode)")

// extracting associated values as a part of switch statement. You can extract each
// associated value as a constant or variable for use within the switch case's body:
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode)")
}

// if all associated values for an enumeration case are extracted as constants or
// variables, place a single var or let before the case name
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case var .qrCode(productCode):
    print("QR code: \(productCode)")
}

/** RAW VALUES **/
// As an alternative to associated values, enumeration cases can come prepopulated
// with default values (called raw values), which are all of the same type.
// Raw values can be strings, characters or any of the integer or floating-point
// number types. Each raw value must be unique within its enumeration declaration.

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

// IMPLICITLY ASSIGNED RAW VALUES
enum AnotherPlanet: Int, CaseIterable {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

for planet in AnotherPlanet.allCases {
    print(planet.rawValue)
}

let earthsOrder = AnotherPlanet.earth.rawValue
let sunsetDirection = CompassPoint.west.rawValue

// INITIALIZING FROM A RAW VALUE

// This example identifies Uranus from its raw value of 7:
let possiblePlanet = AnotherPlanet(rawValue: 7)

let possibleToFind = 11
if let somePlanet = AnotherPlanet(rawValue: possibleToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe for humans")
    }
} else {
    print("There isn't a planet at position \(possibleToFind)")
}

/** RECURSIVE ENUMERATIONS **/
// Recursive enumeration is an enumeration that has another instance of the
// enumeration as the associatied value for one of the enumeration cases. You
// indicate that an enumeration case is recursive by writing 'indirect' before it.

/*
enum ArtihmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)          // error: cannot find type 'ArithmeticExpression' in scope
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)    // error: cannot find type 'ArithmeticExpression' in scope
}
*/

enum ArithmeticRequirement {
    case number(Int)
}

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticRequirement, ArithmeticRequirement)
    indirect case multiplication(ArithmeticRequirement, ArithmeticRequirement)
}

// You can also write indirect before the beginning of the enumeration to enable
// all indirection for all of the enumeration's cases that have an associated values

indirect enum IndirectArithmeticExpression {
    case number(Int)
    case addition(ArithmeticRequirement, ArithmeticRequirement)
    case multiplication(ArithmeticRequirement, ArithmeticRequirement)
}

// these examples are giving me errors, but I'm including them as the example of using
// the indirect keyword as the reference:

// (5 + 4) * 2
// let five = IndirectArithmeticExpression.number(5)
// let four = IndirectArithmeticExpression.number(4)
// let sum = IndirectArithmeticExpression.addition(five, four)
// let product = IndirectArithmeticExpression.multiplication(sum, IndirectArithmeticExpression.number(2))

/*
func evaluate(_ expression: IndirectArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
*/
