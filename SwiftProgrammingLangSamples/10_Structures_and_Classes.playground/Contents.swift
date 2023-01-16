import UIKit

// COMPARING STRUCTURES AND CLASSES
// Both classes and structs can:
// - Define properties to store values
// - Define methods to provide functionality
// - Define subscripts to provide access to their values using subscripts syntax
// - Define initializers to set up their initial state
// - Be extended to expand their functionality beyond a default implementation
// - Conform to protocols to provide standard functionality of a certain kind

// Classes have additional capabilities that structures don't have:
// - Inheritance enables one class to inherit the characteristics of another
// - Type casting enables you to check and interpret the type of a class instance at runtime
// - Deinitializers enable an instance of a class to free up any resources it has assigned
// - Reference counting allows more than one reference to a class instance

// IMPORTANT: AS A GENERAL GUIDELINE, PREFER STRUCTURES BECAUSE THEY'RE EASIER TO REASON
// ABOUT, AND USE CLASSES WHEN THEY'RE APPROPRIATE OR NECESSARY

// DEFINITION SYNTAX
struct SomeStructure {
    // structure definition goes here
}

class SomeClass {
    // structure definition goes here
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var framerate = 0.0
    var name: String?
}

// STRUCTURE AND CLASS INSTANCES
let someResolution = Resolution()
let someVideoMode = VideoMode()

// ACCESSING PROPERTIES
print("The width of someResolution is \(someResolution.width)")

print("The width of someVideoMode is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1280
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

// MEMBERWISE INITIALIZERS FOR STRUCTURE TYPES
// unlike structures, class instances don't receive a default memberwise initializer.

let vga = Resolution(width: 640, height: 480)
// let videoM = VideoMode(reso...

/** STRUCTURES AND ENUMERATIONS ARE VALUE TYPES **/

// A value type is a type whose value is copied when it's assigned to a variable or constant,
// or when it's passed to a function.
// All structures and enumerations are value types in Swift, so they are always copied when
// they are passed around in code.

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")

print("hd is still \(hd.width) pixels wide")

enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}

var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection // making a copy of a value
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")

/** CLASSES ARE REFERENCE TYPES **/

// Unlike value types, reference types are not copied when they're assigned
// to a variable or constant, or when they're passed to a function. Rather
// than a copy, a reference to the same existing instance is used.

let tenEighty = VideoMode()
tenEighty.resolution = hd   // making a copy of hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.framerate = 25.0

let alsoTenEighty = tenEighty   // making a reference to the same VideoMode() instance
alsoTenEighty.framerate = 30.0

// tenEighty and alsoTenEighty were declared as constants, but still, we can change
// the values that were referenced.
// tenEighty and alsoTenEighty themselves don't store the VideoMode instance. Instead,
// both refer to a VideoMode instance behind the scenes
print("alsoTenEighty value: \(alsoTenEighty.framerate)")
print("tenEighty value: \(tenEighty.framerate)")

// IDENTITY OPERATORS

// Use identity operators to check whether two constants or variables refer to the same
// single instance
// === - identical to
// !== - not identical to

if tenEighty === alsoTenEighty {
    print("ten eighty and alsoTenEigthy refer to the same VideoMode instance.")
}
