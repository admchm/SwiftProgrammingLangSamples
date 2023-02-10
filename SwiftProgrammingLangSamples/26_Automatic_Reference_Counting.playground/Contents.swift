import UIKit

// ARC IN ACTION
class NewPerson {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: NewPerson?
var reference2: NewPerson?
var reference3: NewPerson?

reference1 = NewPerson(name: "John Appleseed") // strong reference from reference1
                                            // to the new Person instance

// two more strong references are established
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil // only at this point the instance is deallocated

// STRONG REFERENCE CYCLES BETWEEN CLASS INSTANCES
// This can happen if two class instances hold a strong reference to each other,
// such that each instance keeps the other alive. This is known as a strong
// reference cycle.
// We resolve strong reference cycles by defining some of the relationships
// between classes as weak or unowned references instead of as strong references.

// Example of how a strong reference cycle can be created by accident

class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var mark: Person?
var unit4A: Apartment?

mark = Person(name: "Mark Appleseed")
unit4A = Apartment(unit: "4A")

mark?.apartment = unit4A
unit4A?.tenant = mark

// When we break the strong references held by the john and unit4A variables, the
// reference counts don’t drop to zero, and the instances aren’t deallocated by ARC
mark = nil
unit4A = nil

/** RESOLVING STRONG REFERENCE CYCLES BETWEEN CLASS INSTANCES **/

// WEAK REFERENCES
// A weak reference is a reference that doesn’t keep a strong hold on the instance
// it refers to, and so doesn’t stop ARC from disposing of the referenced instance.
// This behavior prevents the reference from becoming part of a strong reference cycle.
// We indicate a weak reference by placing the weak keyword before a property or variable
// declaration.

class PersonFixed {
    let name: String
    init(name: String) { self.name = name }
    var apartment: ApartmentFixed?
    deinit { print("\(name) is being deinitialized") }
}

class ApartmentFixed {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: PersonFixed?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var adam: PersonFixed?
var unit1A: ApartmentFixed?
adam = PersonFixed(name: "Adam Appleseed")
unit1A = ApartmentFixed(unit: "1A")

adam?.apartment = unit1A
unit1A?.tenant = adam

adam = nil
unit1A = nil

// UNOWNED REFERENCES
// Like a weak reference, an unowned reference doesn’t keep a strong hold on the instance
// it refers to. Unlike a weak reference, however, an unowned reference is used when the
// other instance has the same lifetime or a longer lifetime. We indicate an unowned
// reference by placing the unowned keyword before a property or variable declaration.

// Unlike a weak reference, an unowned reference is expected to always have a value. As
// a result, marking a value as unowned doesn’t make it optional, and ARC never sets an
// unowned reference’s value to nil.

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var bart: Customer?
bart = Customer(name: "Bart")
bart?.card = CreditCard(number: 1234_5678_9012_3456, customer: bart!)

bart = nil

// UNOWNED OPTIONAL REFERENCES
// Unowned optional can be nil.

class Department {
    var name: String
    var courses: [Course]
    init(name: String) {
        self.name = name
        self.courses = []
    }
}

class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}

let department = Department(name: "Horticulture")

let intro = Course(name: "Survey of Plants", in: department)
let intermediate = Course(name: "Growing Common Herbs", in: department)
let advanced = Course(name: "Caring for Tropical Plants", in: department)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]

// UNOWNED REFERENCES AND IMPLICITLY UNWRAPPED OPTIONAL PROPERTIES
// There’s a third scenario, in which both properties should always have a value, and
// neither property should ever be nil once initialization is complete. In this scenario,
// it’s useful to combine an unowned property on one class with an implicitly unwrapped
// optional property on the other class.
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")

/** STRONG REFERENCE CYCLES FOR CLOSURES **/

// A strong reference cycle can also occur if we assign a closure to a property
// of a class instance and the body of that closure captures the instance.
// Closure capture list is an elegant solution to this problem.

class HTMLElementBroken {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElementBroken(name: "h1")
let defaultText = "some default text"

heading.asHTML = {
    return "<\(heading.name)\(heading.text ?? defaultText)</\(heading.name)>"
}

var paragraph: HTMLElementBroken? = HTMLElementBroken(name: "p", text: "hello, world")
print(paragraph!.asHTML())

paragraph = nil

/** RESOLVING STRONG REFERENCE CYCLES FOR CLOSURES **/

// Swift requires you to write self.someProperty or self.someMethod() (rather than
// just someProperty or someMethod()) whenever you refer to a member of self within
// a closure. This helps you remember that it’s possible to capture self by accident.

// DEFINING A CAPTURE LIST

/*
lazy var someClosure = {
    [unowned self, weak delegate = self.delegate]
    (index: Int, stringToProcess: String) -> String in
    // closure body goes here
}
*/

// if a closure doesn't specify a parameter list or return type:
/*
lazy var someClosure = {
    [unowned self, weak delegate = self.delegate] in
    // closure body goes here
}
*/

// WEAK AND UNOWNED REFERENCES

// Define a capture in a closure as an unowned reference when the closure and the
// instance it captures will always refer to each other, and will always be
// deallocated at the same time. Conversely, define a capture as a weak reference
// when the captured reference may become nil at some point in the future.

class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var newParagraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(newParagraph!.asHTML())

newParagraph = nil
