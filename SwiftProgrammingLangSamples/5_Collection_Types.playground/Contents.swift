import UIKit

/** MUTABILITY OF COLLECTIONS **/

/** ARRAYS **/

// ARRAY TYPE SHORTHAND SYNTAX
// Array<Element> vs Array[Element]

// CREATING AN EMPTY ARRAY
var someInts: [Int] = []
print("someInts is of type [Int] with \(someInts.count) items.")

someInts.append(3)
someInts = []

// CREATING AN ARRAY WITH A DEFAULT VALUE
var threeDoubles = Array(repeating: 0.0, count: 3)

// CREATING AN ARRAY BY ADDING TWO ARRAYS TOGETHER
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
var sixDoubles = threeDoubles + anotherThreeDoubles

// CREATING AN ARRAY WITH AN ARRAY LITERAL
var shoppingList: [String] = ["Eggs", "Milk"]
var shorterShoppingList = ["Eggs", "Milk"]

// ACCESSING AND MODYFING AN ARRAY
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list isn't empty.")
}

shoppingList.append("Flour")

shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

var firstItem = shoppingList[0]
shoppingList[0] = "Six eggs"

print(shoppingList)
shoppingList[4...6] = ["Bananas", "Apples"]
print(shoppingList)

shoppingList.insert("Maple Syrup", at: 0)
let mapleSyrup = shoppingList.remove(at: 0)
print(shoppingList)

firstItem = shoppingList[0]

let apples = shoppingList.removeLast()
print(apples)

// ITERATING OVER ARRAY
for item in shoppingList {
    print(item)
}

for (index, item) in shoppingList.enumerated() {
    print("Item \(index + 1): \(item)")
}

/** SETS **/
// A set stores values of the same type in a collection with no defined ordering.
// You can use a set instead of array when the order of items isn't important or
// when you need to ensure that an item only appears once.

// HASH VALUES FOR SET TYPES
// A type must be hashable in order to be stored in a set.

// SET TYPE SYNTAX
// Set<Element>, where Element is the type that the set is allowed to store.

// CREATING AND INITIALIZING AN EMPTY SET
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count)")

letters.insert("a")
letters = []

// CREATING A SET WITH AN ARRAY LITERAL
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
var favoriteGenresInShorterForm: Set = ["Rock", "Classical", "Hip hop"]

// ACCESSING AND MODIFYING A SET
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have a particular music preferences.")
}

favoriteGenres.insert("Jazz")

if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}

// ITERATING OVER A SET
for genre in favoriteGenres {
    print(genre)
}

for (index, genre) in favoriteGenres.enumerated() {
    print("\(index + 1 ): \(genre)")
}

for genre in favoriteGenres.sorted() {
    print(genre)
}

/** PERFORMING SET OPERATIONS **/

// FUNDAMENTAL SET OPERATIONS

// intersection
// symmetricDifference
// union
// substracting

// Use the intersection(_:) method to create a new set with only the values common in both sets.
// Use the symmetricDifference(_:) method to create a new set with values in either set, but not both
// Use the union(_:) method to create a new set with all of the values in both sets.
// Use the substracting(_:) method to create a new set with values not in the specific set.

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
oddDigits.intersection(evenDigits).sorted()
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()

// SET MEMBERSHIP AND EQUALITY
// Use the == to determine wether two sets contain all of the same values.
// Use the isSubset(of:) method to determine whether all of the values of a set are contained in the specific set.
// Use the isSuperset(of:) method to determine whether a set contains all of the values in a specific set.
// Use the isStrictSubset(of:) or isStrictSuperset(of:) methods to determine whether a set is a subset or superset,
//      but not equal to, a specified set.
// Use the isDisjoint(with:) method to determine whether two sets have no values in common.
let houseAnimals: Set = ["Dog", "Cat"]
let farmAnimals: Set = ["Cow", "Chicken", "Sheep", "Dog", "Cat"]
let cityAnimals: Set = ["Pidgeon", "Mouse"]

houseAnimals.isSubset(of: farmAnimals)
farmAnimals.isSuperset(of: houseAnimals)
farmAnimals.isDisjoint(with: cityAnimals)

/** DICTIONARIES **/
// A dictionary stores association between keys of the same type and values of the same
// type in a collection with no defined ordering. Each value is associated with a unique
// key, which acts as indentifier.

// DICTIONARY TYPE SHORTHAND SYNTAX
// Dictionary<Key, Value>,
// where Key is the type of the value that can be used as a dictionary key,
// and Value is a type of value that dictionary stores for those keys.

// Dictionary: [Key: Value]

// CREATING AN EMPTY DICTIONARY
var namesOfIntegers: [Int: String] = [:]

namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]

// CREATING A DICTIONARY WITH A DICTIONARY LITERAL
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

var airportsShorter = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// ACCESSING AND MODIFYING A DICTIONARY
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary isn't empty.")
}

airports["LHR"] = "London"
print(airports)

airports["LHR"] = "London Heathrow"
print(airports)

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
print(airports)

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport isn't in the airports dictionary.")
}

airports["APL"] = "Apple International"
airports["APL"] = nil
print(airports)

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue)")
} else {
    print("That airport isn't in the airports dictionary.")
}

// ITERATING OVER A DICTIONARY
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values {
    print("Airport name: \(airportName)")
}


let aiportCodes = [String](airports.keys)
print(aiportCodes)

let airportNames = [String](airports.values)
print(airportNames.sorted())
