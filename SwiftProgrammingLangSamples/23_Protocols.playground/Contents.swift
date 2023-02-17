import UIKit

// A protocol defines a blueprint of methods, properties, and other
// requirements that suit a particular task or piece of functionality.
// The protocol can be adopted by a class, structure, or enumeration
// to provide an actual implementation of those requirements.

/** PROTOCOL SYNTAX **/

protocol FirstProtocol {
    // protocol definition goes herex
}

protocol SecondProtocol {
    // protocol definition goes herex
}


struct SomeProtocol: FirstProtocol, SecondProtocol {
    // structure definition goes here
}

// If a class or structure has a super class, list the superclass name
// before any protocols it adopts, followed by a coma

class SomeSuperclass {
}

class SomeOtherClass: SomeSuperclass, FirstProtocol, SecondProtocol {
    // class definition goes here
}

/** PROPERTY REQUIREMENTS **/
// A protocol can require any conforming type to provide an instance
// property or type property with a particular name and type.
// The protocol also specifies whether each property must be gettable
// or getable and settable.

protocol SomeDifferentProtocol {
    var mustBeSettable: Int { get set }
    var doesntNeedToBeSettable: Int { get }
}

protocol OtherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

/** METHOD REQUIREMENTS **/
// Protocols can require specific instance methods and type methods
// to be implemented by conforming types. These methods are written
// as part of the protocol's definition in exactly the same way as
// for normal instance, but without curly braces or a method body.

protocol SomeProtocolWithAStaticFunc {
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = ((lastRandom * a * c)
            .truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

/** MUTATING METHOD REQUIREMENT **/
// It's sometimes necessary for a method to modify (or mutate) the
// instance it belongs to.
// For instance methods on value types (that is, structures and
// enumerations), we place the 'mutating' keyword before a method's
// func keyword to indicate that the method is allowed to modify
// the instance it belongs to and any properties of that instance.

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
case off, on
    
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

/** INITIALIZER REQUIREMENTS **/
// Protocols can require specific initializers to be implemented by
// conforming types.

protocol SomeProtocolWithInit {
    init(someParameter: Int)
}

// CLASS IMPLEMENTATIONS OF PROTOCOL INITIALIZER REQUIREMENTS

// We can implement a protocol initializer requirement on a conforming
// class as either designated initializer or a convenience initializer.
// In both cases, we need to mark the initializer implementation with
// the 'required' modifier.

protocol SomeYetAnotherProtocol {
    init()
}

class SomeYetAnotherClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeYetAnotherSubclass: SomeYetAnotherClass, SomeYetAnotherProtocol {
    required override init() {
        // intializer implementation goes here
    }
}

// FAILABLE INITIALIZER REQUIREMENTS

/** PROTOCOLS AS TYPES **/
// Protocols don't actually implement any functionality themselves.
// Nonetheless, we can use protocols as a fully fledged types in our
// code. Using a protocol as a type is sometimes called as an
// existential type, which comes from the phrase "there exists a type
// T such that T conforms to the protocol".

// We can use a protocol in many places where other types are allowed:
// - As a parameter type or return type in a function, method or init
// - As the type of a constant, variable or property
// - As the type of items in array, dictionary or other container

// protocol used as a type

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

// We can pass a value of any conforming type in to this parameter when
// initializing a new Dice instance

// let dice = Dice(sides: 6, generator: RandomNumberGenerator)

let someGenerator = LinearCongruentialGenerator()
let dice = Dice(sides: 6, generator: someGenerator)

dice.roll()
dice.roll()
dice.roll()

// or

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

/** DELEGATION  **/

// Delegation is a design pattern that enables a class or structure
// to hand off (or delegate) some of its responsibilities to an
// instance of another type. This design pattern is implemented by
// defining a protocol that encapsulates the delegated
// responsibilities, such that a conforming type (known as delegate)
// is guaranteed to provide the functionality that has been delegated.
// Delegation can be used to respond to a particular action or to
// retrive data from an external source without needing to know the
// underlying type of that source.

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

// To prevent strong reference cycles, delegates are declared as weak
// references.

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    var square = 0
    var board: [Int]
    
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    weak var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        
    gameLoop: while square != finalSquare {
        let diceRoll = dice.roll()
        delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
        
        switch square + diceRoll {
        case finalSquare:
            break gameLoop
        case let newSquare where newSquare > finalSquare:
            continue gameLoop
        default:
            square += diceRoll
            square += board[square]
        }
    }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

/** ADDING PROTOCOL CONFORMANCE WITH AN EXTENSION **/

// We can extend an existing type to adopt and conform to a new protocol
// even if we don't have access to the source code for the existing type.

protocol TextRepresentable {
    var textualDescription: String { get }
}

// Dice from above can be extended to adopt and conform to TextRepresentable
extension Dice: TextRepresentable {
    public var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

// Similarly, the SnakesAndLadders class can be also extended to adopt
// and conform to TextRepresentable protocol:
extension SnakesAndLadders: TextRepresentable {
    public var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

print(game.textualDescription)

// CONDITIONALLY CONFORMING TO A PROTOCOL

/*
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

let myDice = [d6, d12]
print(myDice.textualDescription)
*/

// DECLARING PROTOCOL ADOPTION WITH AN EXTENSION
// If a type already conforms to all of the requirements of a protocol
// but hasn't yet stated that it adopts that protocol, we can make it
// adopt the protocol with an empty extension

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

// Instances of Hamster can now be used wherever TextRepresentable is
// the required type

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

/** ADOPTING A PROTOCOL USING SYNTHESIZED IMPLEMENTATION **/

struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent.")
}

enum SkillLevel: Comparable {
    case beginner
    case intermediate
    case expert(stars: Int)
}
var levels = [SkillLevel.intermediate, SkillLevel.beginner,
              SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
for level in levels.sorted() {
    print(level)
}

/** COLLECTIONS OF PROTOCOL TYPES **/
// A protocol can be used as the type to be stored in a collection

let things: [TextRepresentable] = [game, d12, simonTheHamster]

for thing in things {
    print(thing.textualDescription)
}

/** PROTOCOL INHERITANCE **/

// A protocol can iherit one or more other protocols and can add
// further requirements on top of the requirements it inherits.

protocol InhertingProtocol: FirstProtocol, SecondProtocol {
    // protocol definition goes here
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

print(game.prettyTextualDescription)

/** CLASS-ONLY PROTOCOLS **/

// We can limit the adoption to a class types (and not structures
// and enums) by adding AnyObject protocol to a protocol's
// inheritance list.

protocol SomeClassOnlyProtocol: AnyObject, PrettyTextRepresentable {
    // class-only protocol definition goes here
}

/** PROTOCOL COMPOSITiON **/
// It can be useful to require a type to conform to multiple protocols
// at the same time. We can combine multiple protocols into a single
// requirement with a protocol composition.
// Protocol compositions have the form SomeProtocol & AnotherProtocol

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct NewPerson: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = NewPerson(name: "Adam", age: 42)
wishHappyBirthday(to: birthdayPerson)

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)

/** CHECKING FOR PROTOCOL CONFORMANCE **/
// We can use the is and as operators described in Type Casting to
// check for protocol conformance, and to cast to a specific protocol.

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

/** OPTIONAL PROTOCOL REQUIREMENTS **/

// You can define optional requirements for protocols. These requirements
// don’t have to be implemented by types that conform to the protocol.
// Optional requirements are prefixed by the optional modifier as part of
// the protocol’s definition.

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

/** PROTOCOL EXTENSIONS **/
// Protocols can be extended to provide method, initializer, subscript,
// and computed property implementations to conforming types.

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And here's a random Boolean: \(generator.randomBool())")

// If a conforming type provides its own implementation of a required
// method or property, that implementation will be used instead of the
// one provided by the extension.

extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

// ADDING CONSTRAINTS TO PROTOCOL EXTENSIONS
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]

print(equalNumbers.allEqual())
print(differentNumbers.allEqual())
