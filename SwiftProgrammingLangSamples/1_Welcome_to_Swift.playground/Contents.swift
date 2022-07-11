import UIKit

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
