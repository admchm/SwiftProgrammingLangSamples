import UIKit
import PlaygroundSupport

/** CONSTANTS AND VARIABLES **/

// DECLARING CONSTANTS AND VARIABLES
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0

var x = 0.0, y = 0.0, z = 0.0

// TYPE ANNOTATIONS
var welcomeMessage: String
welcomeMessage = "Hello"

var red, green, blue: Double

// NAMING CONSTANTS AND VARIABLES
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"

let languageName = "Swift"
// languageName = "Swift++"

// PRINTING CONSTANTS AND VARIABLES
print(friendlyWelcome)

print("The current value of friendlyWelcome is \(friendlyWelcome)")

/** COMMENTS **/

// This is a comment

/* This is also a comment
 but is written over multiple lines. */

/* This is the start of the first multiline comment.
 /* This is the second, nested multiline comment. */
 This is the end of the first multiline comment. */

/** SEMICOLONS **/
let cats = "🐱"; print(cats)

/** INTEGERS **/

// INTEGER BOUNDS
let minValue = UInt8.min
let maxValue = UInt8.max

// Int
// UInt

/** FLOATING-POINT NUMBERS **/

/** TYPE SAFETY AND TYPE INFERENCE **/
let meaningOfLife = 42      // inferred to be of type Int
let pi = 3.14159            // inferred to be of type Double
let anotherPi = 3 + 0.14159 // anotherPi is also to be of type Double

/** NUMERIC LITERALS **/
let decimalInteger = 17
let binaryInteger = 0b10001    // 17 in binary notation
let octalInteger = 0o21        // 17 in octal notation
let hexadecimalInteger = 0x11  // 17 in hexadecimal notation

// All of these floating-point literals have a decimal value of 12.1875:
let decimalDouble = 12.1875
let exponentDouble = 1.211875e1
let hexadecimalDouble = 0xC.3p0

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

/** NUMERIC TYPE CONVERSIONS **/

// INTEGER CONVERSION
// let cannotBeNegative: UInt = -1 // error
// let tooBig: Int8 = Int8.max + 1 // error

let twoTousand: UInt16 = 2_000
let one: UInt8 = 1
let twoTousandAndOne = twoTousand + UInt16(one)

// INTEGER AND FLOATING-POINT CONVERSION
let three = 3
let pointOneFourOneFiveNine = 0.14159
let piValue = Double(three) + pointOneFourOneFiveNine
let integerPi = Int(pi)

/** TYPE ALIASES **/
typealias AudioSample = UInt16

var maxAmplitudeFound = AudioSample.min

/** BOOLEANS **/
let orangesAreOrange = true
let turnipsAreDelicious = false

if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}

let i = 1
// if i { } // gives error
if i == 1 {} // OK

/** TUPLES **/
// Tuples are particularly useful as the return values of functions

let http404Error = (404, "Not Found")
 
// you can decompose a tuple's contents into separate variables, which you then access as usual:
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

// if you only need some of the tuple's values, ignore parts of the tuple with an underscore (_) when you decompose the tuple
let (onlyStatusCode, _) = http404Error
print("The status code is equals to \(onlyStatusCode)")

// alternatively, access the individual element values in a tuple using index numbers starting at zero
print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")

// you can name the individual elements in a tuple when the tuple is defined
let http200Status = (statusCode: 200, statusMessage: "OK")

print("The status code is \(http200Status.statusCode)")
print("The status code is \(http200Status.statusMessage)")

let (positiveStatusCode, positiveStatusMessage) = http200Status
print("The status code is \(positiveStatusCode)")
print("The status message is \(positiveStatusMessage)")

/** OPTIONALS **/
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

// NIL
var serverResponseCode: Int? = 404
serverResponseCode = nil

// without default value, optional variable is set to nil
var surveyAnswer: String?

/** ERROR HANDLING **/

/** ASSERTIONS AND PRECONDITIONS **/




