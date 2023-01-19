import UIKit

// Classes, structures, and enumerations can define subscripts,
// which are shortcuts for accessing the member elements of a
// collection, list, or sequence. We use subscripts to set and
// retrieve values by index without needing separate methods for
// setting and retrieval.

// SUBSCRIPT SYNTAX
/*
subscript(index: Int) -> Int {
    get {
        // return an appropriate subscript value here
    }
    
    set(newValue) {
        // perform a suitable action here
    }
}
*/
// As with read-only computed properties, you can simplify the
// declaration of a read-only subscript by removing the get keyword
// and its braces:
/*
subscript(index: Int) -> Int {
    // Return an appropriate subscript value here.
}
*/

struct TimesTable {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let twoTimesTable = TimesTable(multiplier: 2)
print(twoTimesTable[2])

// SUBSCRIPT USAGE
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

// SUBSCRIPT OPTIONS

struct Matrix {
    let rows: Int
    let columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func isIndexValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(isIndexValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(isIndexValid(row: row, column: column), "Index out of range")
                        grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)

matrix[1, 1] = 2
// matrix[2, 1] = 4 // This triggers an assert, because [2, 2] is outside of the matrix bounds.

// TYPE SUBSCRIPTS
// We can also define subscripts that are called on the type itself.
// To indicate that we are going to write a type subscript, we are writing
// static keyword before the subscript keyword

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}

let mars = Planet[4]
print(mars)
