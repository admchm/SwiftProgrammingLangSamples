import UIKit

/** UNDERSTANDING CONFLICTING ACCESS TO MEMORY **/

// A write access to the memory where one is stored.
var one = 1

// A read access from the memory where one is stored.
print("We're number \(one)!")

// A conflicting access can occur when different parts of our code
// are trying to access the same location in the memory at the same
// time.

// CHARACTERISTICS OF MEMORY ACCESS

// A conflict occurs if you have two accesses that meet all of the following conditions:
// - At least one is a write access or a nonatomic access
// - They access the same location in memory
// - Their durations overlap

func oneMore(than number: Int) -> Int {
    return number + 1
}

var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)

/** CONFLICTING ACCESS TO IN-OUT PARAMETERS **/

var stepSize = 1

func increment(_ number: inout Int) {
    number += stepSize
}

// increment(&stepSize) // error: Execution was interrupted, reason: signal SIGABRT. - Fatal access conflict detected.


// One way to solve this conflict is to make an explicit
// copy of stepSize

var copyOfStepSize = stepSize
increment(&copyOfStepSize)

// Update the original
stepSize = copyOfStepSize


func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore) // OK
// balance(&playerOneScore, &playerOneScore) // error: inout arguments are not allowed to alias each other
// Error: conflicting accesses to playerOneScore

/** CONFLICTING ACCESS TO SELF IN METHODS **/
struct Player {
    var name: String
    var health: Int
    var energy: Int

    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)  // OK”

// oscar.shareHealth(with: &oscar) // ERROR: Inout arguments are not allowed to alias each other
                                   // ERROR: Overlapping accesses to 'oscar', but modification
                                   // requires exclusive access; consider copying to a local variable

/** CONFLICTING ACCESS TO PROPERTIES **/

var playerInformation = (health: 10, energy: 20)
// balance(&playerInformation.health, &playerInformation.energy)
// - ERROR: “conflicting access to properties of playerInformation

// var holly = Player(name: "Holly", health: 10, energy: 10)
// balance(&holly.health, &holly.energy)  // Error”

func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)
}
