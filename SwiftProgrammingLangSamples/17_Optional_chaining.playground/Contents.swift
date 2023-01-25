import UIKit

// Optional chaining is a processfor querying and calling properties,
// methods and subscripts on an optional that might currently be nil.
// Multiple queries can be chained together, and the entire chain
// fails gracefully if any link in the chain is nil.

/** OPTIONAL CHAINING AS AN ALTERNATIVE TO FORCED UNWRAPPING **/
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

var john = Person()
print(john.residence ?? "nil")

// let roomCount = john.residence!.numberOfRooms - runtime error

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

/** DEFINING MODEL CLASSES FOR OPTIONAL CHAINING **/
class NewPerson {
    var residence: NewResidence?
}

class NewResidence {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}

class Room {
    let name: String
    
    init(name: String) {
        self.name = name
        
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

/** ACCESSING PROPERTIES THROUGH OPTIONAL CHAINING **/

let adam = NewPerson()
if let roomCount = adam.residence?.numberOfRooms {
    print("Adams's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

let someAddress = Address()
someAddress.buildingName = "apartment"
someAddress.street = "Porzeczkowa"
someAddress.buildingNumber = "10"

adam.residence?.address = someAddress

func createAddress() -> Address {
    print("Function was called")
    
    let someAddress = Address()
    someAddress.buildingName = "apartment"
    someAddress.street = "Duboisa"
    someAddress.buildingNumber = "3"
    
    return someAddress
}

adam.residence?.address = createAddress()               // fails, because residence is nil

// playing around
/*
let newResidence = NewResidence()
newResidence.address = createAddress()

adam.residence = newResidence
adam.residence?.address = createAddress()
*/

/** CALLING METHODS THROUGH OPTIONAL CHAINGING **/

if adam.residence?.printNumberOfRooms() != nil {        // fails, because residence is nil
    print("It was possible to print the number of rooms.")
} else {
    print("It wasn't possible to print the number of rooms.")
}

if (adam.residence?.address = someAddress) != nil {     // fails, because residence is nil
    print("It was possible to set the address.")
} else {
    print("It wasn't possible to set the address.")
}

/** ACCESSING SUBSCRIPTS THROUGH OPTIONAL CHAINING **/
// When you access a subscript on an optional value through optional chaining,
// you place the question mark before the subscript’s brackets, not after.

if let firstRoomName = adam.residence?[0].name {        // fails, because residence is nil
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name.")
}

adam.residence?[0] = Room(name: "Bathroom")             // fails, because residence is nil

let adamsHouse = NewResidence()
adamsHouse.rooms.append(Room(name: "Living Room"))
adamsHouse.rooms.append(Room(name: "Kitchen"))
adam.residence = adamsHouse

if let firstRoomName = adam.residence?[0].name {        // success, because residence isn't nil
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name.")
}

// ACCESSING SUBSCRIPTS OF OPTIONAL TYPE
// If a subscript returns a value of optional type, place a question
// mark after the subscript's closing bracket to chain on its optional
// return value.

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72

print(testScores)

/** LINKING MULTIPLE LEVELS OF CHAINING **/
// If the type you are trying to retrieve isn’t optional, it will
// become optional because of the optional chaining.

if let adamsStreet = adam.residence?.address?.street {
    print("Adam's street name is \(adamsStreet).")
} else {
    print("Unable to retrieve the address.")
}

let adamsAddress = Address()
adamsAddress.buildingName = "apartment"
adamsAddress.street = "Porzeczkowa"
adamsAddress.buildingNumber = "10"

adam.residence?.address = adamsAddress

if let adamsStreet = adam.residence?.address?.street {
    print("Adam's street name is \(adamsStreet).")
} else {
    print("Unable to retrieve the address.")
}

/** CHAINING ON THE METHODS WITH OPTIONAL RETURN VALUES **/
if let buildingIdentifier = adam.residence?.address?.buildingIdentifier() {
    print("Adam's building identifier is \(buildingIdentifier)")
}

if let beginsWithThe = adam.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("Adam's building identifier begins with the \"The\".")
    } else {
        print("Adam's building indentifier doesn't begin with the \"The\".")
    }
}
