import UIKit

// Methods are functions that are associated with a particular type.

// INSTANCE METHODS
class Counter {
    var counter = 0
    func increment() {
        counter += 1
    }
    
    func increment(by amount: Int) {
        counter += amount
    }
    
    func reset() {
        counter = 0
    }
}

let counter = Counter()
counter.increment()
counter.increment(by: 5)
counter.reset()

// THE SELF PROPERTY
// self - equivalent to instance itself
// We use the 'self' property to refer to the current instance
// within its own instance methods.

class OtherCounter {
    var counter: Int = 0
    
    func increment() {
        self.counter += 1
    }
}

// But in practice, we don't need to write
// 'self' very often. We need to write 'self' when a parameter name for an
// instance method has the same name as property of that instance.
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}

let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}

// MODIFYING VALUE TYPES FROM WITHIN INSTANCE METHODS
// By default, the properties of a value type can’t be modified from within
// its instance methods. However, if you need to modify the properties of your
// structure or enumeration within a particular method, you can opt in to
// mutating behavior for that method.

struct OtherPoint {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var otherPoint = OtherPoint(x: 1.0, y: 1.0)
otherPoint.moveBy(x: 2.0, y: 3.0)
print("The point is at (\(otherPoint.x), \(otherPoint.y)).")

// ASSIGNING TO SELF WITHIN A MUTATING METHOD
struct DifferentPoint {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = DifferentPoint(x: 100, y: 50)
    }
}

var differentPoint = DifferentPoint()
print("DifferentPoint is at (\(differentPoint.x), \(differentPoint.y)).")

differentPoint.moveBy(x: 1, y: 2)
print("DifferentPoint is at (\(differentPoint.x), \(differentPoint.y)).")

// Mutating methods for enumerations can set the implicit self parameter to
// be a different case from the same enumeration:

enum TriStateSwitch {
    case off, low, high
    
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next()

/** TYPE METHODS **/

class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}

SomeClass.someTypeMethod()

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 hasn't yet been unlocked")
}
