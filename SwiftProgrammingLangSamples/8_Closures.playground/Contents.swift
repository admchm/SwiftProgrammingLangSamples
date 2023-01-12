import UIKit

// Closures are self-contained blocks of functionality that can be passed
// around and used in your code. Closures in Swift are similar to lambdas
// in other programming languages.

// Closures can capture and store references to any constants and variables
// from the context in which they're defined. Swift handles all of the
// memory management of capturing for you.

// - Global functions are closures that have a name and don't capture any values
// - Nested functions are closures that have a name and can capture values
//      from their enclosing function
// - Closure expressions are unnamed closures written in a lightweight syntax
//      that can capture values from their surrounding context

// Swift's closure expressions have a clean, clear style, with optimizations
// that encourage brief, clutter-free syntax in common scenarios. These
// optimizations include:
// - Inferring parameter and return value types from context
// - Implicit returns from single-expression closures
// - Shorthand argument names
// - Trailing closure syntax

/** CLOSURE EXPRESSIONS **/
// Closure expressions are a way to write inline closures in a brief, focused
// syntax.

// THE SORTED METHOD
var names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

// (String, String) -> Bool
// (name1: String, name2: String) -> isHigher: Bool

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by: backward)

// CLOSURE EXPRESSION SYNTAX
/*
{ (parameters) -> return type in
    statements
}
*/


// - Parameters in this case can be in-out parameters, but they can't have
//      a default values.
// - Variadic parameters can be used if you name the variadic parameter.
// - Tuples can also be used as parameter types and return types.

// closure expression version of a backward function
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

// 'in' keyword indicates that the definition of the closure's parameters
// and return type has finished, and body of the closure is about to begin.

// it can be written in single line as inline closure:
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )

// INFERING TYPE FROM CONTEXT
// Because the sorting closure is passed as an argument to a method, Swift
// can infer the types of its parameters and the type of the value it returns.
reversedNames = names.sorted(by: { s1, s2 in
    return s1 > s2
})

reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )

// It's always possible to infer parameter types and return type when passing
// a closure to a function or method as an inline closure expression.

// IMPLICIT RETURNS FROM SINGLE-EXPRESSION CLOSURES
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )

// There is no ambiguity, so you can skip 'return' keyword
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

// SHORTHAND ARGUMENT NAMES

// Swift automatically provides shorthand argument names to inline closures
// which can be used to refer to the values of the closure's arguments by the names
// $0, $1, $2, and so on.
// If you use these shorthand argument names within your closure expression,
// you can omit closure's argument list from its definition.
// The 'in' keyword can also be omitted.

reversedNames = names.sorted(by: { $0 > $1 })

// OPERATOR METHODS
reversedNames = names.sorted(by: >)

/** TRAILING CLOSURES **/
// If you need to pass a closure expression to a function as the function's final
// argument and the closure expression is long, it can be useful to write it as
// a trailing closure instead.
// You write a trailing closure after the function call's parentheses, even
// though the trailing closure is still an argument to the function.

func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// Here is how you call this function without using a trailing closure
someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here is how you call this function with a trailing closure
someFunctionThatTakesAClosure {
    // trailing closure's body goes here
}

// Closure from previous section can be written outside of the sorted(by:)method's
// paretheses as a trailing closure:
reversedNames = names.sorted(by: { $0 > $1 })
reversedNames = names.sorted() { $0 > $1 }

// If a closure expression is provided as the function's or method's only
// argument and you provide that expressions to a trailing closure
// you don't need to write a pair of parentheses () after the function or method's name
// when you call the function
reversedNames = names.sorted { $0 > $1 }

// Trailing closures are most useful when the closure is sufficiently long, that it isn't
// possible to write it inline on a single line.

// Map method with a trailing closure
let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}

let numsSetToZero = numbers.map { (number) -> Int in
    var number = number
    
    return number * 10
}
print("numsSetToZero equals = \(numsSetToZero)")

// loadPicture(from:completion:onFailure)

// If a function takes multiple closures, you omit the argument label for the
// first trailing closure and you label the remaining trailing closures.
/*
func loadPicture(from server: Server, completion: (Picture) -> Void,
onFailure: () -> Void) {
    if let picture  = download("photo.jpg", from: server) {
        completion(picture)
    } else {
        onFailure()
    }
}
*/

/*
func loadPicture(from: Server) { picture in
    someView.currentPicture = picture
} onFailure: {
    print("Couldn't download the next picture.")
}
*/

/** CAPTURING VALUES **/
// A closure can capture constants and variables from the surrounding context in which
// it's defined. The closure can then refer to and modify the values of those constants
// and variables from within its body, even if the original scope that defined the
// constants and variables no longer exists.

// The return type of makeIncrementer() is a function rather a simple value
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementer
}

let inc50 = makeIncrementer(forIncrement: 50)
inc50()
inc50()

// If you assign a closure to a property of a class instance, and the closure captures that
// instance by referring to the instance or its members, you will create a strong reference
// cycle between the closure and the instance. Swift uses capture lists to break these
// strong reference cycles.

/** CLOSURES ARE REFERENCE TYPES **/
// Closures and functions are reference types
// This means that if you assign a closure to constant or variable, it will refer to the
// closure.
let alsoIncrementBy50 = inc50()
inc50()
