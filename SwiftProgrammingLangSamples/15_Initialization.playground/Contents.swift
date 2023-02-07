import UIKit

/** SETTING INITIAL VALUES FOR STORED PROPERTIES **/

// INITIALIZERS

/*
init() {
    // perform some initialization here
}
*/

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()
print("The default temperature is \(f.temperature) Fahrenheit")

// DEFAULT PROPERTY VALUES

struct FarhenheitInitialized {
    var temperature: Double = 32.0
}

/** CUSTOMIZING INITIALIZATION  **/

// INITIALIZATION PARAMETERS
struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

print(boilingPointOfWater.temperatureInCelsius)
print(freezingPointOfWater.temperatureInCelsius)

// PARAMETER NAMES AND ARGUMENT LABELS
struct Color {
    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

// INITIALIZER PARAMETERS WITHOUT ARGUMENT LABELS
struct CelsiusExtended {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = CelsiusExtended(37.0)

// OPTIONAL PROPERTY TYPES
class SurveyQuestion {
    var text: String
    var response: String?
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.response = "Yes, I do like cheese."

// ASSIGNING CONSTANT PROPERTIES DURING INITIALIZATION
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()

beetsQuestion.response = "I also like beets. (But not with cheese.)"

/** DEFAULT INITIALIZERS **/
class ShoppingListitem {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListitem()

// MEMBERWISE INITIALIZERS FOR STRUCTURE TYPES
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

/** INITIALIZER DELEGATION FOR VALUE TYPES **/

// for value types, we use self.init to refer to other initializers from the same
// value type when writing our own custom initializers. We can call self.init only
// from within an initializer.
// Note that if you define a custom initializer for a value type, you will no
// longer have access to the default initializer (or the memberwise initializer,
// if it’s a structure) for that type.

struct SizeNew {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = SizeNew()
    init() {}
    init(origin: Point, size: SizeNew) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: SizeNew) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}













/** CLASS INHERITANCE AND INITIALIZATION **/
// DESIGNATED INITIALIZERS AND CONVENIENCEINITIALIZERS
// SYNTAX FOR DESIGNATED AND CONVENIENCE INITIALIZERS
// INITIALIZER DELEGATION FOR CLASS TYPES
// TWO-PHASE INITIALIZATION
// INITIALIZER INHERITANCE AND OVERRIDING
// AUTOMATIC INITIALIZER INHERITANCE
// DESIGNATED AND CONVENIENCE INITIALIZERS IN ACTION

/** FAILABLE INITIALIZERS **/
// FAILABLE INITIALIZERS FOR ENUMERATIONS
// FAILABLE INITIALIZERS FOR ENUMERATIONS WITH RAW VALUES
// PROPAGATION OF INITIALIZATION FAILURE
// OVERRIDING A FAILABLE INITIALIZER
// THE INIT! FAILABLE INITIALIZER

/** REQUIRED INITIALIZERS **/

/** SETTING A DEFAULT PROPERTY VALUE WITH A CLOSURE OR FUNCTION **/


