import UIKit

// Access control restricts access to parts of our code from code in
// other source files and modules.

// MODULES AND SOURCE FILES

/** ACCESS LEVELS **/
// Swift provides five different access levels for entities within our
// code:
// - Open access and public access - enable entities to be used within
//   any source file from their defining module
// - Internal access - enables entities to be used within any source
//   file from their defining module, but not in any source file
//   outside of that module.
// - File-private access - restricts the use of any entity to its own
//   defining source file. Use it to hide the implementation details
//   of a specific piece of functionality when those details are used
//   within the entire file.
// - Private access - restritcs the use of any entity to the enclosing
//   declaration and to extensions of that declaration that are in the
//   same file.

// GUIDING ACCESS LEVELS
// Access levels in Swift follow an overall guiding principle: No entity
// can be defined in terms of another entity that has a lower (more
// restrictive) access.

// For example:

// - A public variable can’t be defined as having an internal, file-private,
// or private type, because the type might not be available everywhere
// that the public variable is used.
// - A function can’t have a higher access level than its parameter types
// and return type, because the function could be used in situations where
// its constituent types are unavailable to the surrounding code.

// DEFAULT ACCESS LEVELS

// ACCESS LEVELS FOR SINGLE-TARGET APPS

// ACCESS LEVELS FOR FRAMEWORKS

// ACCESS LEVELS FOR UNIT TEST TARGETS

/** ACCESS CONTROL SYNTAX **/
// Define the accesslevel for entity by placing one of the open, public,
// internal, fileprivate or private modifiers at the beginning of the
// entity's declaration.

public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass{}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}

// Unless otherwise specified, the default access level is internal
class InternalClass {}      // implicitly internal
let InternalConstant = 0    // implicitly internal

/** CUSTOM TYPES **/

public class SomeNewPublicClass {                // explicitly public class
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

class SomeNewInternalClass {                     // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member”
}

fileprivate class SomeNewFilePrivateClass {      // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

private class SomeNewPrivateClass {              // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}

// TUPLE TYPES
// The access level for a tuple type is the most restrictive access level of all types
// used in that tuple.

// FUNCTION TYPES
// The access level for a function type is calculated as the most restrictive access
// level of the function’s parameter types and return type.

// We might expect this function to have the default access level of “internal”,
// but this isn’t the case. In fact, someFunction() won’t compile as written below:
/*
func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // function implementation goes here
}
*/

// Because the function’s return type is private, you must mark the function’s
// overall access level with the private modifier for the function declaration
// to be valid:

private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // function implementation goes here
    return (SomeInternalClass(), SomePrivateClass())
}

// ENUMERATION TYPES
// The individual cases of an enumeration automatically receive the same access
// level as the enumeration they belong to.

public enum CompassPoint {
    case north
    case south
    case east
    case west
}

// RAW VALUES AND ASSOCIATED VALUES
// The types used for any raw values or associated values in an enumeration
// definition must have an access level at least as high as the enumeration’s
// access level.

// NESTED TYPES
// The access level of a nested type is the same as its containing type,
// unless the containing type is public.

/** SUBCLASSING **/
// A subclass can’t have a higher access level than its superclass—for example,
// you can’t write a public subclass of an internal superclass.

// An override can make an inherited class member more accessible than its
// superclass version. In the example below, class A is a public class with
// a file-private method called someMethod().

public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {}
}

public class C {
    fileprivate func someMethod() {}
}

internal class D: C {
    override internal func someMethod() {
        super.someMethod()
    }
}

/** CONSTANTS, VARIABLES, PROPERTIES, SUBSCRIPTS **/
// If a constant, variable, property, or subscript makes use of a private type,
// the constant, variable, property, or subscript must also be marked as private:
private var privateInstance = SomePrivateClass()

// GETTERS AND SETTERS
// Getters and setters for constants, variables, properties, and subscripts
// automatically receive the same access level as the constant, variable, property,
// or subscript they belong to.

// We can give a setter a lower level than its corresponding getter, to restrict the
// read-write scope of that variable, property or subscript. We could assing a lower
// access level by writing fileprivate(set), or internal(set) before the var or
// subscript introducer.

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")

public struct TrackedStringNew {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

/** INITIALIZERS **/
// DEFAULT INITIALIZERS
// DEFAULT MEMBERWISE INITIALIZERS FOR STRUCTURE TYPES

/** PROTOCOLS **/

// If we want to assign an explicit access level to a protocol type, do so at the
// point that you define the protocol. This enables you to create protocols that can
// only be adopted within a certain access context.

// PROTOCOL INHERITANCE
// PROTOCOL CONFORMANCE

/** EXTENSIONS **/
/*
struct SomeStruct {
    private var privateVariable = 12
}

extension SomeStruct: SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}
*/

/** GENERICS **/
/** TYPE ALIASES **/

