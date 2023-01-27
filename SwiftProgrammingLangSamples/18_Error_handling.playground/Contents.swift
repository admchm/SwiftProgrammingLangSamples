import UIKit

// Error handling is the process of responding from error conditions in
// our program.

/** REPRESENTING AND THROWING ERRORS **/
// In Swift, errors are represented by values of types that conform to the
// 'Error' protocol.

// Swift enumerations are particularly well suited to modeling a group of
// related error conditions, with associated values allowing for additional
// information about the nature of an error to be communicated.

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

// Throwing an error lets you indicate that something unexpected happened
// and the normal flow of execution can't continue.

// throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

/** HANDLING ERRORS **/

// There are four ways to handle errors in Swift:
// - we can propagate the error from a function to the code that calls the
//   function
// - handle the error using a do-catch statement
// - handle the error as an optional value
// - assert that the error will not occur

// To identify places in code that can throw errors, we could use
// 'try', 'try?' or 'try!' before a piece of code that calls a function,
// method or initializer that can throw an error.

// Error handling keywords in Swift - 'try', 'catch', 'throw'

// PROPAGATING ERRORS USING THROWING FUNCTIONS

// To indicate that a function can throw an error, we write throws keyword
// in the function's declaration after its parameters.

// playing around
/*
func someThrowingFunction(_ value: Int) throws -> String {
    return "You've passed a value \(String(value))"
}

try someThrowingFunction(5)
*/

// func canThrowErrors() throws -> String
// func cannotThrowErrors() -> String

// A throwing function propagates errors that are thrown inside of it to the
// scope from which it's called.

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func vend(itemName name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let someVendingMachine = VendingMachine()
someVendingMachine.coinsDeposited = 100
try someVendingMachine.vend(itemName: "Chips")


let favoriteSnacks = [
    "Alice": "Pizza",
    "Adam": "Chips",
    "Eve": "Pretzels"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemName: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemName: name)
        self.name = name
    }
}

let purchasedSnack = try PurchasedSnack(name: "Pretzels", vendingMachine: someVendingMachine)
print(someVendingMachine.coinsDeposited)

// HANDLING ERRORS USING DO-CATCH
// You use a do-catch statement to handle errors by running a block of code. If an
// error is thrown by the code in the do clause, it’s matched against the catch
// clauses to determine which one of them can handle the error.

/*
do {
    try expression
    statements
} catch pattern 1 {
    statements
} catch pattern 2 where condition {
    statements
} catch pattern 3, pattern 4 where condition {
    statements
} catch {
    statements
}
*/

var anotherVendingMachine = VendingMachine()
anotherVendingMachine.coinsDeposited = 8

do {
    try buyFavoriteSnack(person: "Adam", vendingMachine: anotherVendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid selection.")
} catch VendingMachineError.outOfStock {
    print("Out of stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    // If a catch clause doesn’t have a pattern, the clause matches any error and
    // binds the error to a local constant named error.
    print("Unexpected error: \(error)")
}


func nourish(with item: String) throws {
    do {
        try anotherVendingMachine.vend(itemName: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from the vending machine.")
    }
}

do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error : \(error)")
}


func eat(item: String) throws {
    do {
        try anotherVendingMachine.vend(itemName: item)
    } catch VendingMachineError.outOfStock,
            VendingMachineError.invalidSelection,
            VendingMachineError.insufficientFunds {
        print("Out of stock or invalid selection or insufficient funds")
    }
}

// CONVERTING ERRORS TO OPTIONAL VALUES
// We use 'try?' by converting it to an optional value. If an error is thrown
// while evaluating the try? expression the value of the expression is nil.

func someThrowingFunction() throws -> Int {
    // ...
    return Int()
}

let x = try? someThrowingFunction()

let y: Int?

do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

// Using try? lets you write concise error handling code when you want to
// handle all errors in the same way.

/*
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    
    return nil
}
*/

// DISABLING ERROR PROPAGATION
// Sometimes we know a throwing function won't throw an error. On those
// occasions, we can write 'try!' before the expression to disable error
// propagation and assert that no error will be thrown.

/*
let photo = try! loadImage(at: "./Resources/JohnAppleseed.jpg")
*/


/** SPECIFYING CLEANUP ACTIONS  **/
// You use a defer statement to execute a set of statements just before code
// execution leaves the current block of code.
// This statement lets you do any necessary cleanup that should be performed
// regardless of how execution leaves the current block of code.
// A defer statement defers execution until the current scope is exited.

// Deferred actions are executed in the reverse of the order that they’re
// written in your source code.

/*
func processFiles(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // work with the file
        }
        // close(file) is called here, at the end of the scope
    }
}
*/
