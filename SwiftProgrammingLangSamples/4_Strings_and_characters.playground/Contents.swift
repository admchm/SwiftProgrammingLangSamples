import UIKit

/** STRING LITERALS **/
let someString = "Some string literal value"


// MULTILINE STRING LITERALS
let quotation = """
The white Rabbit put on his spectacles. "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

let singleLineString = "These are the same."
let multilineString = """
"These are the same."
"""

// quotes with line breaks that won't be a part of the string value
let softWrappedQuotation = """
The white Rabbit put on his spectacles. "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""

let lineBreaks = """

This string starts with a line break.
It also ends with the line break.

"""

// SPECIAL CHARACTERS IN STRING LITERALS
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{1F496}"

/*
let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation marks \"\"\"
"""
*/

// EXTENDED STRING DELIMITERS
let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#

/** INITIALIZING AN EMPTY STRING **/
var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    print("Nothing to see here")
}

/** STRING MUTABILITY **/
var variableString = "Horse"
variableString += " and carriage"

let constantString = "Highlander"
// constantString += " and another Highlander" - this reports a compile-time error
//                                              a constant string that cannot be
//                                              modified

/** STRINGS ARE VALUE TYPES **/

/** WORKING WITH CHARACTERS **/

for character in "Dog!🐶" {
    print(character)
}

let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString)

/** CONCATENATING STRINGS AND CHARACTERS **/
let exclamationMark: Character = "!"

let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "Look over"
instruction += string2

welcome.append(exclamationMark)


let badStart = """
one
two
"""

let end = """
three
"""
print(badStart + end)

let goodStart = """
one
two

"""
print(goodStart + end)

/** STRING INTERPOLATION **/
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

print(#"Write an interpolated string in Swift using \(multiplier)."#)
print(#"6 times 7 is \#(6 * 7)."#)

/** UNICODE **/

// UNICODE SCALAR VALUES

// EXTENDED GRAPHEME CLUSTERS
let eAcute: Character = "\u{E9}"
let combinedEAcute: Character = "\u{65}\u{301}"
let precomposed: Character = "\u{D55C}"
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"
let enclosedEAcute: Character = "\u{E9}\u{20DD}"
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"

/** COUNTING CHARACTERS **/
let unsualMerangerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unsualMerangerie has \(unsualMerangerie.count) characters")

var word = "cafe"
print("the number of characters in \(word) is \(word.count)")

word += "\u{301}"
print("the number of characters in \(word) is \(word.count)")

/** ACCESSING AND MODYFYING A STRING **/
// STRING INDICES
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]

// runetime errors:
// greeting[greeting.endIndex]
// greeting.index(after: greeting.endIndex)

for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}

// INSERTING AND REMOVING
welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))

welcome.remove(at: welcome.index(before: welcome.endIndex))

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)


/** SUBSTRINGS **/
var newGreeting = "Hello, world!"
var newIndex = newGreeting.firstIndex(of: ",") ?? newGreeting.endIndex
let beginning = newGreeting[..<index]

// Converting the result to a String for long-term storage
let newString = String(beginning)


/** COMPARING STRINGS **/
// STRING AND CHARACTER EQUALITY
let anotherQuotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."

if anotherQuotation == sameQuotation {
    print("These two strings are considered equal")
}


let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}

let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"

if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two strings aren't considered equal")
}

// PREFIX AND SUFFIX EQUALITY
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1") {
        act1SceneCount += 1
    }
}

print("There are \(act1SceneCount) scenes in Act 1")

var mansionCount = 0
var cellCount = 0

for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}

print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")

/** UNICODE REPRESENTATIONS IN STRINGS **/
let dogString = "Dog🐶!!"

// UTF-8 REPRESENTATION
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("")

// UTF-16 REPRESENTATION
for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")

// UNICODE SCALAR REPRESENTATION
for codeUnit in dogString.unicodeScalars {
    print("\(codeUnit) ", terminator: "")
}
print("")

