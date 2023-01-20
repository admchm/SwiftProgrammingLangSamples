import UIKit

// Inheritance is a fundamental behavior that differentiates classes
// from other types in Swift.

// DEFINING A BASE CLASS
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noiose
    }
}

let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")

// SUBCLASSING
/*
class SomeSubclass: SomeSuperclass {
    // subclass definition goes here
}
*/

class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

// Subclasses can themselves be subclassed
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 7.0
print("Tandem: \(tandem.description)")

// OVERRIDING

// A subclass can provide its own custom implementation of an
// instance method, type method, instance property, type property
// or subscript that it would otherwise inherit from a superclass.
// This is known as overriding.
// To override a characteristic that would otherwise be inherited,
// you prefix your overriding definition with the 'override' keyword.

// ACCESSING SUPERCLASS METHODS, PROPERTIES AND SUBSCRIPTS

// We can access the superclass version of a method, property or
// subscript by using the 'super' prefix:
// overriden method someMethod() can call the superclass version by super.someMethod()
// overriden property someProperty can access the superclass version by super.someProperty
// overriden subscript someIndex can access the superclass version by super[someIndex]

// OVERRIDING METHODS
class Train: Vehicle {
    override func makeNoise() {
        print("Choo choo")
    }
}

let train = Train()
train.makeNoise()

class AnotherTrain: Train {
    
}

let anotherTrain = AnotherTrain()
anotherTrain.makeNoise()

// OVERRIDING PROPERTIES

// OVERRIDING PROPERTY GETTERS AND SETTERS
class Car: Vehicle {
    var gear = 1
    override var description: String {
        super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print(car.description)

// OVERRIDING PROPERTY OBSERVERS
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automaticCar = AutomaticCar()
automaticCar.currentSpeed = 35.0
print("Automatic car: \(automaticCar.description)")

// PREVENTING OVERRIDES
// We can prevent a method, property or subscript from being overriden
// by making it 'final'.
// Do this by writing the 'final' modifier before the method, property,
// or subscript's introducer keyword (such as final var, final func,
// final class func, final subscripts).
// We can also mark an entire class as final (final class).
