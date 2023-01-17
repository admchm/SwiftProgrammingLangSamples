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
// Property wrapper adds a layer of separation between code that manages
// how a property is stored and the code. When you use a property wrapper,
// you write a management code once when you define a wrapper, and then reuse
// that management code by applying it to multiple properties.

// TODO: - Something in this section might be broken, so it will need to be fixed

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)

rectangle.height = 20
print(rectangle.height)

// We could write a code that uses the behavior of a property wrapper, without
// taking advantage of the special attribute syntax. Look at this in contrast to
// SmallRectangle struct implementation

struct SmallerRectangle {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}

// SETTING INITIAL VALUES FOR WRAPPED PROPERTIES
// To support setting an initial value or other customisation, the property wrapper
// needs to add an initializer.

@propertyWrapper
struct SmallNumber {
    private var maximum: Int = 0
    private var number = 0
    
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }
    
    init() {
        maximum = 12
        number = 0
    }
    
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

// When we apply a wrapper to a property and you don't specify an inital
// value, Swift uses the init() initalizer to set up the wrapper.
struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print("\(zeroRectangle.height) \(zeroRectangle.width)")

struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print("\(unitRectangle.height) \(unitRectangle.width)")

// When we write arguments in parentheses after the custom attribute, Swift
// uses the initializer that accepts those arguments to set up the wrapper.
// This syntax is the most general to use a property wrapper.

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print("\(unitRectangle.height) \(unitRectangle.width)")

narrowRectangle.height = 100
narrowRectangle.width = 100

// When you include property wrapper arguments, we can also specify an initial
// value using assignment. Swift treats the assignment like a wrappedValue
// argument and uses the initializer that accepts the arguments we include.
struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangle()
print("\(mixedRectangle.height)")

mixedRectangle.height = 20
print("\(mixedRectangle.height)")

// PROJECTING A VALUE FROM A PROPERTY WRAPPER
@propertyWrapper
struct SmallerNumber {
    private var number: Int
    private(set) var projectedValue:Bool
    
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
    
    init() {
        self.number = 0
        self.projectedValue = false
    }
}

struct SomeOtherStructure {
    @SmallNumber var someNumber: Int
}

var someOtherStructure = SomeOtherStructure()

someOtherStructure.someNumber = 4
// print(someOtherStructure.$someNumber) // TODO: Value of type 'SomeOtherStructure' has no member '$someNumber'

enum SizeVariation {
    case small, large
}

struct SizedRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int

    mutating func resize(to size: SizeVariation) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 20
        case .large:
            height = 100
            width = 100
        }
        // return $height || $width // TODO: - Cannot find '$height' in scope
        return true                 // TODO: - remove after fixing
    }
}

/** GLOBAL AND LOCAL VARIABLES **/
func someFunction() {
    @SmallNumber var myNumber: Int = 0
    
    myNumber = 10
    
    myNumber = 24
}

// TYPE PROPERTIES
// We can define properties that belong to the type itself, not to any instance
// of that type. There will be only one copy of these properties.

// TYPE PROPERTY SYNTAX
// For computed type properties for class types, you can use the class keyword
// instead to allow subclasses to override the superclass’s implementation.
struct SomeDifferentStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeDifferentEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeDifferentClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

// QUERYING AND SETTING TYPE PROPERTIES
// Type properties are queried and set on the type, not on an instance of that type:
print(SomeDifferentStructure.storedTypeProperty)
SomeDifferentStructure.storedTypeProperty = "Another value."
print(SomeDifferentStructure.storedTypeProperty)
print(SomeDifferentEnumeration.computedTypeProperty)
print(SomeDifferentClass.computedTypeProperty)

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
rightChannel.currentLevel = 11
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)
