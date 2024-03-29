import UIKit

// Generic code enables us to write flexible, reusable functions and
// types that can work with any type.

/** THE PROBLEM THAT GENERICS SOLVE **/
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt) and anotherInt is now \(anotherInt)")

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

/** GENERIC FUNCTIONS **/

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
    print("a is now \(a) and b is now \(b)")
}

// <T> - placeholder type

swapTwoValues(&someInt, &anotherInt)

var firstPart = "first part"
var secondPart = "second part"
swapTwoValues(&firstPart, &secondPart)

/** TYPE PARAMETERS **/

/** NAMING TYPE PARAMETERS **/

// Dictionary<Key, Value>
// Array<Element>
// someFunction <T, U, V>

/** GENERIC TYPES **/

struct IntStack {
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

let fromTheTop = stackOfStrings.pop()

/** EXTENDING A GENERIC TYPE **/

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}

/** TYPE CONSTRAINTS **/
// Type constraints specify that a type parameter must inherit
// from a specific class or conform to a particular protocol or
// protocol composition.

// TYPE CONSTRAINT SYNTAX

/*
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someP: U) {
    // function body goes here...
}
*/

// The first type paratemer (T) has a type constraint to be a subclass
// of SomeClass. The second parameter (U) has a type constraint that
// requires U to conform to the protocol SomeProtocol.

// TYPE CONSTRAINTS IN ACTION
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

// Equatable allows us to make a value comparable
func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
// doubleIndex is an optional Int with no value, because 9.3 isn't in the array
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
// stringIndex is an optional Int containing a value of 2

/** ASSOCIATED TYPES **/

// ASSOCIATED TYPES IN ACTION
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct NewIntStack: Container {
    // original IntStack implementation
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    typealias Item = Int
    
    var count: Int
    
    mutating func append(_ item: Int) {
        self.push(item)
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct NewElementStack<Element>: Container {
    // original StackElement implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    typealias Item = Element
    
    var count: Int
    
    mutating func append(_ item: Element) {
        self.push(item)
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}

// EXTENDING AN EXISTING TYPE TO SPECIFY AN ASSOCIATED TYPE
// extension Array: Container {}

// ADDING CONSTRAINTS TO AN ASSOCIATED TYPE
protocol NewContainer {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// USING A PROTOCOL IN ITS ASSOCIATED TYPE'S CONSTRAINTS
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

/*
extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}

var stackOfInts = Stack<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)”
*/

/*
extension IntStack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack<Int> {
        var result = Stack<Int>()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack<Int>.
}
*/

/** GENERIC WHERE CLAUSES **/

func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {

        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }

        // Check each pair of items to see if they're equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }

        // All items match, so return true.
        return true
}

/*
var stackOfStringsNew = Stack<String>()
stackOfStringsNew.push("uno")
stackOfStringsNew.push("dos")
stackOfStringsNew.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
*/

/** EXTENSIONS WITH A GENERIC WHERE CLAUSE **/
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

if stackOfStrings.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}

struct NotEquatable { }
var notEquatableStack = Stack<NotEquatable>()
let notEquatableValue = NotEquatable()
notEquatableStack.push(notEquatableValue)
// notEquatableStack.isTop(notEquatableValue)  // Error - Referencing instance method 'isTop' on 'Stack' requires that 'NotEquatable' conform to 'Equatable'

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

/*
if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}
*/

extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
// print([1260.0, 1200.0, 98.6, 37.0].average())

/** CONTEXTUAL WHERE CLAUSES **/

extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}
let numbers = [1260, 1200, 98, 37]
// print(numbers.average())
// print(numbers.endsWith(37))

extension Container where Item == Int {
    func averageVariant() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
}

extension Container where Item: Equatable {
    func endsWithVariant(_ item: Item) -> Bool {
        return count >= 1 && self[count-1] == item
    }
}

/** ASSOCIATED TYPES WITH A GENERIC WHERE CLAUSE **/

protocol AnotherContainer {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }

    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

/** GENERIC SUBSCRIPTS **/
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result: [Item] = []
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}
