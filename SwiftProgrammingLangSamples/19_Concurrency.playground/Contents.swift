import UIKit

/*
listPhotos(inGallery: "Summer vacation") { photoNames in
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    downloadPhoto(named: name) { photo in
        show(photo)
    }
}
*/

// DEFINING AND CALLING ASYNCHRONOUS FUNCTIONS

// An asynchronous function is a special kind of a function that can be
// suspended while it's partway through execution. Inside the body of an
// asynchronous function, we mark each of these places where execution
// can be suspended.

// To indicate that a function is asynchronous, we write the 'async' keyword
// in its declaration after its parameters (similar to throws). If function
// returns a value, we write async before the return arrow.

/*
func listPhotos(inGallery: name) async -> [String] {
    let result = // ... some asynchronous networking code ...
    return result
}
*/

// For a function or method that's both asynchronous and throwing, we write
// async before throws.


