import UIKit

/** BASIC OPERATORS **/

// TERMINOLOGY
// -unary operator    - operate on a single target (-a, !a)
// -binary operator   - operate on a two rargets (2 + 3)
// -ternary operators - operate on on three targets (a ? b : c)

// -In expression 1 + 2, + sign would be called operator,
//  1 and 2 could be called operands

/** ASSIGNMENT OPERATOR **/
let b = 10
var a = 5
a = 5

let (x, y) = (1, 2)

/** ARITHMETIC OPERATORS **/
1 + 2
5 - 3
2 * 3
10.0 / 2.5

"hello" + "world"

// REMAINDER OPERATOR
9 % 4

// UNARY MINUS OPERATOR
let minusThree = -3

// UNARY PLUS OPERATOR
let minusSix = -6
let alsoMinusSix = +minusSix // -6

/** COMPOUND ASSIGNMENT OPERATOR **/
a += 5

/** COMPARISON OPERATORS **/
1 == 1
2 != 1
2 > 1
1 < 2
2 >= 2

/** TERNARY CONDITIONAL OPERATOR **/
1 == 1 ? print("true") : print("false")

let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

/** NIL-COALESCING OPERATOR **/
var userDefinedColorName: String?
let defaultColorName = "red"

var colorNameToUse = userDefinedColorName ?? defaultColorName

/** RANGE OPERATORS **/

// CLOSED RANGE OPERATOR
for index in 1...5 {
    print(index)
}

// HALF-OPEN RANGE OPERATOR
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count

for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}

// ONE-SIDED RANGES
// from a second index of array
for name in names[2...] {
    print(name)
}

// to second index of array
for name in names[...2] {
    print(name)
}

for name in names[..<2] {
    print(name)
}

/** LOGICAL OPERATORS **/

// LOGICAL NOT OPERATOR
let negative = !true

// LOGICAL AND OPERATOR
var testResult = true && true

// LOGICAL OR OPERATOR
testResult = true || false

// COMBINING LOGICAL OPERATORS
let enteredDoorCode = true, passedRetinaScan = true, hasDoorKey = false, knowsOverridePassword = false

if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

// EXPLICIT PARENTHESES
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}



