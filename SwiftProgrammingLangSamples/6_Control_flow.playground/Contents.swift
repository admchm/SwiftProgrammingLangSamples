import UIKit

/** FOR IN LOOPS **/
// array
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

// dictionary
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName) has \(legCount) legs.")
}

// numeric ranges
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

// ignoring values in place of variable by using "_"
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}

print("\(base) to the power of \(power) is \(answer)")

// ranges
let minutes = 60
for tickMark in 0..<minutes {
    // render the tick mark each minute (60 times)
}

// skipping unwanted marks
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // render the tick mark every five minute (60 times)
}

// closed ranges
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // render the tick mark every 3 hours (3, 6, 9, 12)
}

/** WHILE LOOPS  **/
// while evaluates its condition at the start of each pass through the loop
// repeat-while evaluates its condition at the end of each pass through the loop

// WHILE
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1) // [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
board[03] = +8; board[06] = +11; board[09] = +9; board[10] = +2
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0
while square < finalSquare {
    // roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    square += diceRoll
    if square < board.count {
        square += board[square]
    }
}
print("Game over!")

// REPEAT-WHILE
square = 0
diceRoll = 0

repeat {
    // move up or down for a snake or ladder
    square += board[square]
    // roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    square += diceRoll
} while square < finalSquare
print("Game over!")

/** CONDITIONAL STATEMENTS **/

// IF
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}

temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}

// SWITCH
/*
switch some value to consider {
case value 1:
    respond to value 1
case value 2,
     value 3:
    respond to value 2 or 3
default:
    otherwise, do something else
}
*/

let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

// NO IMPLICIT FALLTHROUGH
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}

// INTERVAL MATCHING
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings)")

// TUPLES
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 1):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside of the box")
default:
    print("\(somePoint) is outside of the box")
}

// VALUE BINDINGS
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

// WHERE
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

// COMPOUND CASES
let yetSomeCharacter: Character = "e"
switch yetSomeCharacter {
case "a", "e", "i", "o", "u":
    print("\(yetSomeCharacter) is a vovel")
    case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
    "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(yetSomeCharacter) is a consonant")
default:
    print("\(yetSomeCharacter) isn't a vovel or a consonant")
}

/*
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0) (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
*/

/** CONTROL TRANSFER STATEMENTS **/
// continue
// break
// fallthrough
// return
// throw

// CONTINUE
// Continue statement tells a loop to stop what it's doing and start again at the beginning
// of the next iteration through the loop.
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print(puzzleOutput)

// BREAK

// BREAK IN A LOOP STATEMENT

// BREAK IN A SWITCH STATEMENT
let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value couldn't be found for \(numberSymbol).")
}

// FALLTHROUGH
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)

// LABELED STATEMENTS
var secondFinalSquare = 25
var secondBoard = [Int](repeating: 0, count: secondFinalSquare + 1)
secondBoard[03] = +08; secondBoard[06] = +11; secondBoard[09] = +09; secondBoard[10] = +02
secondBoard[14] = -10; secondBoard[19] = -11; secondBoard[22] = -02; secondBoard[24] = -08
var secondSquare = 0
var secondDiceRoll = 0

gameLoop: while secondSquare != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch secondSquare + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        secondSquare += diceRoll
        secondSquare += board[secondSquare]
    }
}
print("Game over!")

/** EARLY EXIT **/
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weather is nice in \(location)")
}

greet(person: ["name": "Adam"])
greet(person: ["name": "Adam", "location": "Bialystok"])

/** CHECKING API AVAILABILITY **/
if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    // Fall back to earlier iOS and macOS APIs
}

@available(macOS 10.12, *)
struct ColorPreference {
    var bestColor = "blue"
}

func bestChosenColor() -> String {
    guard #available(macOS 10.12, *) else {
        return "gray"
    }
    let colors = ColorPreference()
    return colors.bestColor
}

if #available(iOS 10, *) {
} else {
    // Fallback code
}

if #unavailable(iOS 10) {
    // Fallback code
}
