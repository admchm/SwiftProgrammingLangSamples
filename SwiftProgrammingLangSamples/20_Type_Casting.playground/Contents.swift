import UIKit

// Type casting is a way to check the type of an instance, or to treat that
// instance as a different superclass or subclass from somewhere else in
// its own class hierarchy.
// Type casting in Swift is implemented with the 'is' and 'as' operators.
// - is - checking the type of a value
// - as - casting a value to a different type

/** DEFINING A CLASS HIERARCHY FOR A TYPE CASTING **/

class MediaItem {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

// playing around
/*
for item in library {
    print(item.name)
}
*/

// In order to work with these items as their native type, we need to
// check their type, or downcast them to a different type as described
// below.

/** CHECKING TYPE **/

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("There are \(movieCount) movies and \(songCount) songs.")

/** DOWNCASTING **/

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), artist: \(song.artist)")
    }
}

/** TYPE CASTING FOR ANY AND ANYOBJECT **/
// Swift provides two special types for working with nonspecific types:
// - Any - can represent an instance of any types at all, including function types
// - AnyObject - can represent an instance of any class type

// Use Any and AnyObject only when you explicitly need the behavior and capabilities
// they provide. It's always better to be specific about the types we expect.

var things: [Any] = []

things.append(0)
things.append(0.0)
things.append(42)
things.append(2.42342)
things.append("Hello")
things.append((3.9, 1.7))
things.append(Movie(name: "Scary Movie", director: "???"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    print(thing)
    
    // playing around
    if thing is String {
        print("Here's the string - \(thing)")
    }
    
    if let movie = thing as? Movie {
        movie.name = "Happy Movie"
        movie.director = "Jack Kowalski"
        print("\(movie.name), \(movie.director)")
    }
}

print("######")

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a double positive value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x,y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else ")
    }
}

// cating optional value to Any
let optionalNumber: Int? = 3
things.append(optionalNumber)           // WARNING: - Expression implicitly coerced from 'Int?' to 'Any'
things.append(optionalNumber as Any)    // OK, no warning
