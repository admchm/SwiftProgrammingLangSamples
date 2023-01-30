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

