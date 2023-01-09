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

if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
