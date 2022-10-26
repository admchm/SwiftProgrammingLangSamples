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

// TODO: READ THIS SECTION AGAIN

// Integer conversion
// let cannotBeNegative: UInt = -1 // error
// let tooBig: Int8 = Int8.max + 1 // error

let twoTousand: UInt16 = 2_000
let one: UInt8 = 1
let twoTousandAndOne = twoTousand + UInt16(one)



/** TYPE ALIASES **/

/** BOOLEANS **/

/** TUPLES **/

/** OPTIONALS **/

// nil

/** ERROR HANDLING **/

/** ASSERTIONS AND PRECONDITIONS **/




