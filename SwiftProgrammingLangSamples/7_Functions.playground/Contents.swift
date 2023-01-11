import UIKit

/** DEFINING AND CALLING FUNCTIONS**/

func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print(greet(person: "Anna"))
print(greet(person: "Brian"))

func greetAgain(person: String) -> String {
    return "Hello, " + person + "!"
}

print(greetAgain(person: "Anna"))
print(greetAgain(person: "Brian"))

/** FUNCTION PARAMETERS AND RETURN VALUES**/

// FUNCTIONS WITHOUT PARAMETERS
func sayHelloWorld() -> String {
    return "Hello world"
}

print(sayHelloWorld())

// FUNCTIONS WITH MULTIPLE PARAMETERS
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}

print(greet(person: "Tim", alreadyGreeted: true))

// FUNCTIONS WITHOUT RETURN VALUES
func greet(somePerson: String) {
    print("Hello \(somePerson)")
}

greet(somePerson: "Dave")

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}

func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}

printAndCount(string: "hello, world!")
printWithoutCounting(string: "hello, world!")

// FUNCTION WITH MULTIPLE RETURN VALUES
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    // for value in array[1..<array.count] { // try to improve this
    for value in array {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [1, 2, 3, 5, 6, 9, 11])
print("The min value is \(bounds.min), the max value is \(bounds.max)")

// my own exercise, tuples
let testTuple = (22, 52)
testTuple.0
testTuple.1

let secondTestTuple = (firstValue: 33, secondValue: 55)
secondTestTuple.firstValue
secondTestTuple.secondValue

// OPTIONAL TUPLE RETURN TYPES
// (Int?, Int?) is different than (Int, Int)?, because in the second case,
// entire tuple is optional

func minMaxOpt(array: [Int]) -> (min: Int, max: Int)? {
    var currentMin = array[0]
    var currentMax = array[0]
    // for value in array[1..<array.count] { // try to improve this
    for value in array {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMaxOpt(array: [2, 3, 5, 11, 82]) {
    print("min is \(bounds.min), max is \(bounds.max)")
}

// FUNCTIONS WITH AN IMPLICIT RETURN
// Any function that you write as just one return line can omit the return (implicit return value)
func greeting(for person: String) -> String {
    "Hello" + person + "!"
}
print(greeting(for: "Adam"))

func anotherGreeting(for person: String) -> String {
    return "Hello" + person + "!"
}
print(anotherGreeting(for: "Adam"))

/** FUNCTION ARGUMENT LABELS AND PARAMETER NAMES  **/

func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and
    // secondParameterName refer to the argument values for
    // the first and second parameters.
}

someFunction(firstParameterName: 1, secondParameterName: 2)

// SPECIFYING ARGUMENT LABELS
func someAnotherFunction(firstArgumentName firstParameterName: Int, secondArgumentName secondParameterName: Int) {
}

someAnotherFunction(firstArgumentName: 2, secondArgumentName: 3)

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)!"
}

print(greet(person: "Adam", from: "Poland"))

// OMITTING ARGUMENT LABELS
// if we don't want to an argument label for parameter, write an underscore (_)
// instead of an explicit argument label for that parameter
func someFunction(_ firstParameter: Int, secondParameter: Int) {
    // In the function body, firstParameter name and secondParameter name
    // refer to the argument values for the first and second parameters
}

someFunction(1, secondParameter: 2)

// DEFAULT PARAMETER VALUES
// Place parameters that don’t have default values at the beginning of a function’s parameter list, before the parameters that have default values.

func someFunction(parameterWithoutDefault: Int,
                  parameterWithDefault: Int = 12) {
    print("paramWithoutDefault: \(parameterWithoutDefault), paramWithDefault: \(parameterWithDefault)")
    // If you omit the second argument when calling this function,
    // then the value of parameterWithDefault is 12 inside the function body
}

someFunction(parameterWithoutDefault: 1, parameterWithDefault: 5)
someFunction(parameterWithoutDefault: 13)

func someOtherFunction(parameterWithoutDefault: Int,
                  parameterWithDefault: Int = 12) {
    // parameterWithDefault = 10 - Cannot assign to value: 'parameterWithDefault' is a 'let' constant
    print("paramWithoutDefault: \(parameterWithoutDefault), paramWithDefault: \(parameterWithDefault)")
}

someOtherFunction(parameterWithoutDefault: 1, parameterWithDefault: 5)
someOtherFunction(parameterWithoutDefault: 13)

// VARIADIC PARAMETERS
// A variadic parameter accepts zero or more values of a specified type. You use a variadic
// parameter to specify that the parameter can be passed a varying number of input values
// when the function is called.
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

// arithmeticMean(numbers: 1.0, 2.0, 3.0, 4.0, 5.0)
arithmeticMean(1.0, 2.0, 3.0, 4.0, 5.0)

// IN-OUT PARAMETERS
// If we want to change the parameter of a function (which by default is constant),
// use in-out parameters
// we need to also add & to the argument that will be passed to a function that uses in-out params

var firstVal = 10
var secondVal = 5

func swapTwoInts(a: inout Int, b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
print("Before swapping values - first value \(firstVal), second value \(secondVal)")
swapTwoInts(a: &firstVal, b: &secondVal)
print("After swapping values - first value \(firstVal), second value \(secondVal)")

// testing on my own
func testInout(firstParam: inout Int, secondParam: Int) {
    firstParam = secondParam + 50
}
testInout(firstParam: &firstVal, secondParam: secondVal)
print("After swapping values - first value \(firstVal), second value \(secondVal)")

/** FUNCTION TYPES  **/

// (Int, Int) -> Int
// or
// a function that has two parameters, both type of Int, and that returns a value of type Int
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

// (Int, Int) -> Int
// or
// a function that has two parameters, both type of Int, and that returns a value of type Int
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

// () -> Void
// or
// a function that has no parameters, and returns Void
func printHelloWorld() {
    print("Hello, world!")
}

// USING FUNCTION TYPES
// function type
var mathFunction: (Int, Int) -> Int = addTwoInts
mathFunction(2, 3)

mathFunction = multiplyTwoInts
mathFunction(10, 2)

let anotherMathFunction = addTwoInts
let someFunc = anotherGreeting
let minMaxFunc = minMaxOpt

// FUNCTION TYPES AS PARAMETER TYPES
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

printMathResult(addTwoInts, 2, 2)

// FUNCTION TYPES AS RETURN TYPES

func stepForward(_ input: Int) -> Int {
    return input + 1
}

func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var val = 3
let moveNearerToZeroVal = chooseStepFunction(backward: val > 0)
// moveNearerToZero now refers to the stepBackward() function

while val != 0 {
    print("Current value: \(val)")
    val = moveNearerToZeroVal(val)
}

/** NESTED FUNCTIONS **/
func chooseStepFunctions(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { print("test"); return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}

var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}

print("zero!")
