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

// CONVERTING ERRORS TO OPTIONAL VALUES

// DISABLING ERROR PROPAGATION

/** SPECIFYING CLEANUP ACTIONS  **/
