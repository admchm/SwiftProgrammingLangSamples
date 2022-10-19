import UIKit
import PlaygroundSupport

/* A Swift Tour */
print("Hello world")

/** SIMPLE VALUES **/
var myVariable = 42
myVariable = 50
let myConstant = 42

let implicitInteger = 70
let imiplicitDouble = 70.0
let explicitDouble: Double = 70


/* EXPERIMENT:
 * Create a constant with an explicit type of Float and a value of 4
 */
let explicitFloat: Float = 4
type(of: explicitFloat)

let label = "The width is "
let width = 94
let widthLabel = label + String(width)


/* EXPERIMENT:
 * Try removing the conversion to String from the last line. What error do you get?
 */
// let widthLabel = label + width - ERROR: Binary operator '+' cannot be applied to operands of type 'String' and 'Int'

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."


/* EXPERIMENT:
 * Use \() to include a floating-point calculation in a string and to include someone's name in a greeting.
 */
let yourName = "Adam"
let appleDevicesCount: Float = 3.5
let greetingWithCalc = "Hello \(yourName)! We want to remind you that you have \(appleDevicesCount) Apple devices - there is a half, because one of them is broken!"


let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""


var shoppingList = ["catfish", "water", "tulips"]
shoppingList[1] = "bottle of water"

shoppingList.append("beer")
print("Shopping list: \(shoppingList)")


let emptyArray: [String] = []
let emptyDictionary: [String: Float] = [:]

var occupations = [
    "Malcolm": "Programmer",
    "Kaylee": "Mechanic",
    ]
occupations["Ian"] = "Public Relations"

shoppingList = []
occupations = [:]


/** CONTROL FLOW **/
let indiualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in indiualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print("Team score: \(teamScore)")


var optionalString: String? = "Hello"
print(optionalString == nil)
// Prints "false"


var optionalName: String? = "John Snow"
var greeting = "Hello!"
// optionalName = nil
if let name = optionalName {
    greeting = "Hello, \(name)!"
}


/* EXPERIMENT:
 * Change optionalName to nil. What greeting do you get? Add an else clause that sets a different greeting if optionalName is nil.
 */

var experimentalOptionalName: String? = nil
if let name = experimentalOptionalName {
    greeting = "Hello, \(name)!"
} else {
    greeting = "Hello, hmm..."
}


let nickname: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickname ?? fullName)"

if let nickname {
    print("Hey, \(nickname)")
}


let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwitch.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}


/*
 * Try removing the default case. What error do you get?
 */
// - I'm getting "Switch must be exhaustive"

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]


var largest = 0
for (_, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print("largest = \(largest)")


/* EXPERIMENT:
 * Replace the _ with a variable name, and keep track of which kind of number was the biggest
 */

var dictResults: [String: Int] = [:]
var biggest  = 0
for (numberType, numbers) in interestingNumbers {
    for number in numbers {
        if number > biggest {
            biggest = number
            dictResults.updateValue(biggest, forKey: numberType)
        }
    }
    biggest = 0
}


print("Biggest numbers in each category = \(dictResults)")

var n = 2
while n < 100 {
    n *= 2
}
print(n)

var m = 2
repeat {
    m *= 2
} while m < 100
print(m)
            
var total = 0
for i in 0..<4 {
    total += i
}


/** FUNCTIONS AND CLOSURES **/
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)"
}

greet(person: "Mark", day: "Monday")


/* EXPERIMENT:
 * Remove the day parameter. Add a parameter to include today's lunch special in the greeting.
 */
func greeting(person: String, lunchSpecial: String) -> String {
    return "Hello \(person), today's lunch special is \(lunchSpecial)"
}

greeting(person: "Paul", lunchSpecial: "pizza")


func newGreet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)"
}

newGreet("Bart", on: "Friday")


func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}

let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum) //
print(statistics.2)   // these are the same


func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()


// returning another function as its value
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)


// function can take another function as one of its arguments
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}

var numbers = [3, 19, 17, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)


// closure
numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})


/* EXPERIMENT:
 * Rewrite the closure to return zero for all odd numbers
 */
numbers.map({ ( number: Int) -> Int in
    if number % 2 != 0 {
        return 0
    } else {
        return number
    }
})


// writing closures more concisely
let mappedNumbers = numbers.map({ number in
    10 * number })
print(mappedNumbers)

// refer to parameters by number instead of by name
let sortedNumbers = numbers.sorted { $0 < $1}
print(sortedNumbers)


/** OBJECTS AND CLASSES **/

class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}


/* EXPERIMENT:
 * Add a constant property with let, and add another method that takes an argument
 */

class Amount {
    var value = 15
    let exchangeRate = 3.887
    
    func simpleDescription() -> String {
        return "The amount equals \(value)."
    }
    
    func polishCurrencyCalculation() -> String {
        return "You can exchange this amount in Poland to \(Double(value) * exchangeRate) of polish zloty."
    }
}


// creating a class instance
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

// class initializer to set up the class when an instance is created. Use init to create one
class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides"
    }
}
var namedShape = NamedShape(name: "star")


// subclassing, overriding
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()


/* EXPERIMENT:
 * Make another subclass of NamedShape called Circle that takes a radius and a name as arguments to its initializer.
 * Implement an area() and a simpleDescription()
 */

class Circle: NamedShape {
    var radius: Double
    
    init(radius: Double, name: String) {
        self.radius = radius
        super.init(name: name)
    }
    
    func area() -> Double {
        return 3.14 * (radius * radius)
    }
    
    override func simpleDescription() -> String {
        return "A circle with radius of \(radius) and area that equals \(area())."
    }
}

let circle = Circle(radius: 1.1, name: "our test circle")
circle.simpleDescription()


// getter and setter
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equaliteral triangle with sides of lenght \(sideLength)"
    }
}

var triangle = EquilateralTriangle(sideLength: 1.0, name: "a triangle")
print(triangle.perimeter)

triangle.perimeter = 9.9
print(triangle.sideLength)

// willSet
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}

var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.triangle.sideLength)
print(triangleAndSquare.square.sideLength)
triangleAndSquare.square = Square(sideLength: 2, name: "some square")

//let optionalSquare = Square? = Square(sideLength: 1, name: "optional square")
//let sideLenght = optionalSquare?.sideLength

/** ENUMERATIONS AND STRUCTURES **/
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue

/* EXPERIMENT:
 * Write a function that compares two Rank Values by comparing their raw values
 */
func compareTwoRankValues(firstVal: Rank, secondVal: Rank) -> String {
    let isFirstValHigher = firstVal.rawValue > secondVal.rawValue ? true : false
    let statement = isFirstValHigher ? "higher" : "lower"
    
    return "\(firstVal) is \(statement) from \(secondVal)"
}

compareTwoRankValues(firstVal: Rank.four, secondVal: Rank.five)

if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}

enum Suit {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()

/* EXPERIMENT:
 * Add a color() method to Suit that return "black" for spades and clubs, and returns "red" for hearts and diamonds.
 */
enum SuitExpanded {
    case spades, hearts, diamonds, clubs
    
    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "black"
        case .hearts, .diamonds:
            return "red"
        }
    }
}

let blackColor = SuitExpanded.spades.color()
let redColor = SuitExpanded.hearts.color()

enum ServerResponse {
    case result(String, String)
    case info(String)
    case failure(String)
}
    
    let success = ServerResponse.result("06:00AM", "07:09PM")
    let description = ServerResponse.info("This structure returns hours for sunrise and sunset")
    let failure = ServerResponse.failure("Out of cheese")
    
    switch success {
    case let .result(sunrise, sunset):
        print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
    case let .info(description):
        print("Info: \(description)")
    case let .failure(message):
        print("Failure... \(message)")
}

struct Card {
    var rank: Rank
    var suit: Suit
    
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}

let threeOfSpades = Card(rank: .ace, suit: .clubs)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

/* EXPERIMENT:
 * Write a function that returns an array containing a full deck of cards, with one card of each combination of rank and suit
 */
enum SuitOfCards: String, CaseIterable {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}

enum RankOfCards: String, CaseIterable {
    case ace
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

func fullDeckOfCards() -> Array<(String, String)> {
    var arrayOfRanks: [String] = RankOfCards.allCases.map { $0.rawValue }
    print(arrayOfRanks)
    
    var arrayOfSuits: [String] = SuitOfCards.allCases.map { $0.rawValue }
    print(arrayOfSuits)
    
    var arrayOfCards: Array<(String, String)> = Array()
    
    for rank in arrayOfRanks {
        for suit in arrayOfSuits {
            
            let card = (rank, suit)
            arrayOfCards.append(card)
        }
    }
    print("Array of cards = \(arrayOfCards)")
    
    return arrayOfCards
}

let testVar = fullDeckOfCards()
/*
 Array of cards = [("ace", "spades"), ("ace", "hearts"), ("ace", "diamonds"), ("ace", "clubs"), ("two", "spades"), ("two", "hearts"), ("two", "diamonds"), ("two", "clubs"), ("three", "spades"), ("three", "hearts"), ("three", "diamonds"), ("three", "clubs"), ("four", "spades"), ("four", "hearts"), ("four", "diamonds"), ("four", "clubs"), ("five", "spades"), ("five", "hearts"), ("five", "diamonds"), ("five", "clubs"), ("six", "spades"), ("six", "hearts"), ("six", "diamonds"), ("six", "clubs"), ("seven", "spades"), ("seven", "hearts"), ("seven", "diamonds"), ("seven", "clubs"), ("eight", "spades"), ("eight", "hearts"), ("eight", "diamonds"), ("eight", "clubs"), ("nine", "spades"), ("nine", "hearts"), ("nine", "diamonds"), ("nine", "clubs"), ("ten", "spades"), ("ten", "hearts"), ("ten", "diamonds"), ("ten", "clubs"), ("jack", "spades"), ("jack", "hearts"), ("jack", "diamonds"), ("jack", "clubs"), ("queen", "spades"), ("queen", "hearts"), ("queen", "diamonds"), ("queen", "clubs"), ("king", "spades"), ("king", "hearts"), ("king", "diamonds"), ("king", "clubs")]
 */

/** CONCURRENCY **/
func fetchUserID(from server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    return 501
}

func fetchUsername(from server: String) async -> String {
    let userID = await fetchUserID(from: server)
    
    if userID == 501 {
        return "John Appleseed"
    }
    return "Guest"
}

func connectUser(to server: String) async {
    async let userID = fetchUserID(from: server)
    async let username = fetchUsername(from: server)
    
    let greeting = await "Hello \(username), user ID \(userID)"
    print(greeting)
}

Task {
    await connectUser(to: "primary")
}

/** PROTOCOLS AND EXTENSIONS **/
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105

    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}

var a = SimpleClass()
a.adjust()

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure."
    
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

var b = SimpleStructure()
b.adjust()

/* EXPERIMENT:
 * Add another requirement to ExampleProtocol. What changes do you need to make to SimpleClass and SimpleStructure so that they still conform to the protocol
 */
// ANSWER: We need to make sure that both SimpleClass and SimpleStructure are implementing the requirement that was added (in this case, "anotherProperty")

protocol ExtendedSimpleProtocol {
    var simpleDescription: String { get }
    var anotherProperty: Int { get }
    mutating func adjust()
}

class ExtendedSimpleClass: ExtendedSimpleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105

    func adjust() {
        simpleDescription += " Now 100% adjusted. Current anotherProperty equals \(anotherProperty)"
    }
}

var c = SimpleClass()
c.adjust()

struct ExtendedSimpleStructure: ExtendedSimpleProtocol {
    var simpleDescription: String = "A simple structure."
    var anotherProperty: Int = 525252
    mutating func adjust() {
        simpleDescription += " (adjusted). Current anotherProperty equals \(anotherProperty)"
    }
}

var d = SimpleStructure()
d.adjust()


extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)

/* EXPERIMENT:
 * Write an extension for Double type that adds an absoluteValue property
 */

extension Double {
    func absoluteValue() -> Double {
        var value = self
        value = value < 0 ? value * -1 : value
        
        return value as Double
    }
}

var experimentalDouble: Double = -70.0
print("Absolute value of experimentalDouble: \(String(describing: experimentalDouble.absoluteValue))")

let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// protocolValue.anotherProperty
