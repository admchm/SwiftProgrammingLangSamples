import UIKit

// Properties associate values with a particular class, structure, or enumeration.
// - Stored properties store constant and variable as a part of an instance.
// - Computed properties calculate a value.

/** STORED PROPERTIES **/
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThree = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThree.firstValue = 6

// STORED PROPERTIES OF CONSTANT STRUCTURE INSTANCES
/*
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
rangeOfFourItems.firstValue = 6 // ERROR: Cannot assign to property: 'rangeOfFourItems' is a 'let' constant
*/

// LAZY STORED PROPERTIES
// A lazy stored property whose initial value isn't calculated until the first time it's used. You indicate
// a lazy stored property by writing the lazy modifier before its declaration.
// Lazy stored property must be a variable, not constant. It is useful when the initial value isn't known
// until after an instance's initialization is complete.

class DataImporter {
    /*
     DataImporter is a class to import data from an external file.
     The class is assumed to take a nontrivial amount of time to initialize.
     */
    var filename = "data.txt"
    // The DataImporter class would provide data importing functionality here.
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality
    // here.
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

// the DataImporter instance for the importer property hasn't yet been created

print(manager.importer.filename)
// the DataImporter instance for the importer property has now been created

// STORED PROPERTIES AND INSTANCE VARIABLES

/** COMPUTED PROPERTIES **/

// Computed properties, don't actually store a value. Instead, they provide
// a getter and optional setter to retrieve and set other properties and
// values indirectly.

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0 , y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
var initialSquareCenter = square.center

square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at \(square.origin.x), \(square.origin.y)")

// SHORTHAND SETTER DECLARATION
// If a computed property's setter doesn't define a name for the new value
// to be set, a default name of 'newValue' is used.

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// SHORTHAND GETTER DECLARATION
// If a body of a getter is a single expression, the getter implicitly
// returns that expression

struct CompactRect {
    var origin = Point()
    var size = Size()
    
    var center: Point {
        get {
            // we are skipping the return here
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
        }
        
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// READ-ONLY COMPUTED PROPERTIES

// Read-only computed property is a computed property that have no setter
// In case of read-only computed property, we can remove get keyword and its
// braces
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("The volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

/** PROPERTY OBSERVERS  **/
// Property observers observe and respond to changes in a property's value.

// We can add property observers in the following places:
// - Stored properties that we define
// - Stored properites that we inherit
// - Computed properties that we inherit

// We have the option to define either or both of those observers on a property:
// - willSet - is called just before the value is stored
// - didSet  - is called immediately after the new value is stored

// default parameter names:
// - willSet - newValue
// - didSet  - oldValue

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 250
stepCounter.totalSteps = 50

/** PROPERTY WRAPPERS **/
// TODO: finish the rest of the chapter
