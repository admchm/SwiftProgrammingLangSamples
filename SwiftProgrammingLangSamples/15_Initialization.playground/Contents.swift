import UIKit

/** SETTING INITIAL VALUES FOR STORED PROPERTIES **/

// INITIALIZERS

/*
init() {
    // perform some initialization here
}
*/

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()
print("The default temperature is \(f.temperature) Fahrenheit")

// DEFAULT PROPERTY VALUES

struct FarhenheitInitialized {
    var temperature: Double = 32.0
}

/** CUSTOMIZING INITIALIZATION  **/

// INITIALIZATION PARAMETERS
struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

print(boilingPointOfWater.temperatureInCelsius)
print(freezingPointOfWater.temperatureInCelsius)

// PARAMETER NAMES AND ARGUMENT LABELS
struct Color {
    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

// INITIALIZER PARAMETERS WITHOUT ARGUMENT LABELS
struct CelsiusExtended {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = CelsiusExtended(37.0)

// OPTIONAL PROPERTY TYPES
class SurveyQuestion {
    var text: String
    var response: String?
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.response = "Yes, I do like cheese."

// ASSIGNING CONSTANT PROPERTIES DURING INITIALIZATION
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()

beetsQuestion.response = "I also like beets. (But not with cheese.)"

/** DEFAULT INITIALIZERS **/
class ShoppingListitem {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListitem()

// MEMBERWISE INITIALIZERS FOR STRUCTURE TYPES
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

/** INITIALIZER DELEGATION FOR VALUE TYPES **/

// for value types, we use self.init to refer to other initializers from the same
// value type when writing our own custom initializers. We can call self.init only
// from within an initializer.
// Note that if you define a custom initializer for a value type, you will no
// longer have access to the default initializer (or the memberwise initializer,
// if it’s a structure) for that type.

struct SizeNew {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = SizeNew()
    init() {}
    init(origin: Point, size: SizeNew) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: SizeNew) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

/** CLASS INHERITANCE AND INITIALIZATION **/

// Swift defines two kinds of initializers for class types to help ensure all stored
// properties receive an initial value. These are known as designated initializers
// and convenience initializers.

// DESIGNATED INITIALIZERS AND CONVENIENCE INITIALIZERS

// Designated initializers are the primary initializers for a class.
// Convenience initializers are secondary, supporting initializers for a class.

// SYNTAX FOR DESIGNATED AND CONVENIENCE INITIALIZERS

// Designated initializer syntax:
/*
init(parameters) {
    statements
}
*/

// Convinience initializer syntax:
/*
convinience init(parameters) {
    statements
}
*/

// INITIALIZER DELEGATION FOR CLASS TYPES

// Swift applies the following three rules for delegation calls between initializers:
// - Rule #1:
//      designated initializer must call a designated initializer from its immediate
//      superclass.
// - Rule #2:
//      convenience initializer must call another initializer from the same class.
// - Rule #3:
//      convenience initializer must ultimately call a designated initializer.

// TWO-PHASE INITIALIZATION

// INITIALIZER INHERITANCE AND OVERRIDING

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        // If the superclass’s initializer is asynchronous,
        // we need to write await super.init() explicitly.
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

// AUTOMATIC INITIALIZER INHERITANCE

// Assuming that you provide default values for any new properties you introduce
// in a subclass, the following two rules apply:

// - Rule #1: If our subclass doesn’t define any designated initializers, it
//            automatically inherits all of its superclass designated initializers.

// - Rule #2: If our subclass provides an implementation of all of its superclass
//            designated initializers—either by inheriting them as per rule 1, or by
//            providing a custom implementation as part of its definition—then it
//            automatically inherits all of the superclass convenience initializers.

// DESIGNATED AND CONVENIENCE INITIALIZERS IN ACTION

class Food {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

var namedMeat = Food()
print("namedMeat = \(namedMeat.name)")

namedMeat = Food(name: "Bacon")

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = Food(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true

for item in breakfastList {
    print(item.description)
}

/** FAILABLE INITIALIZERS **/

// To define a failable initializer, we need to place a question mark after
// the init keyword (init?)
// We cannot define a failable and a nonfailable initializer with the same
// parameter types and names.
// We write return nil within a failable initializer to indicate a point at
// which initialization failure can be triggered.
// A main role of the failable initializer is to ensure that self is fully
// and correctly initialized.

let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}

let valueChanged = Int(exactly: pi)
// valueChanged is of type Int?, not Int

if valueChanged == nil {
    print("\(pi) conversion to Int doesn't maintain value")
}

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
// someCreate is of type Animal?, not Animal

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymousCreature couldn't be initialized.")
}

// FAILABLE INITIALIZERS FOR ENUMERATIONS

enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}

// FAILABLE INITIALIZERS FOR ENUMERATIONS WITH RAW VALUES

enum TemperatureUnitRaw: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let fahrenheitUnitRaw = TemperatureUnitRaw(rawValue: "F")
if fahrenheitUnitRaw != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnitRaw = TemperatureUnitRaw(rawValue: "X")
if unknownUnitRaw == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}

// PROPAGATION OF INITIALIZATION FAILURE

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}

// OVERRIDING A FAILABLE INITIALIZER

class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

// THE INIT! FAILABLE INITIALIZER
// Alternatively, we can define a failable initializer that creates an implicitly
// unwrapped optional instance of the appropriate type. Do this by placing an
// exclamation point after the init keyword (init!) instead of a question mark.

/** REQUIRED INITIALIZERS **/

// Write the required modifier before the definition of a class initializer to
// indicate that every subclass of the class must implement that initializer.

class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}

// We must also write the required init write the required modifier before every
// subclass implementation of a requred initializer. We don' write override
// keyword in this case.
class SomeSubclass: SomeClass {
    required init() {
        // subclass implmentation of the required initializer goes here
    }
}

// We don’t have to provide an explicit implementation of a required initializer
// if you can satisfy the requirement with an inherited initializer.

/** SETTING A DEFAULT PROPERTY VALUE WITH A CLOSURE OR FUNCTION **/
/*
class SomeNewClass {
    let someProperty: SomeType = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return someValue
    }()
}
*/

// Note that the closure’s end curly brace is followed by an empty pair of parentheses.
// This tells Swift to execute the closure immediately. If we omit these parentheses,
// we are trying to assign the closure itself to the property, and not the return value
// of the closure.
struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))
