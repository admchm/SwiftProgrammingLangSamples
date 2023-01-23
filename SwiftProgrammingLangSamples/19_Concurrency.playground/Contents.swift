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

// When calling an asynchronous method, execution suspends until the method
// returns. You write await in front of the call to mark the possible
// suspension point.
// Inside an asynchronous method, the flow of execution is suspended only
// when you call another asynchronous method. Suspension is never implicit.
// Every possible suspension point is marked with await.

/*
let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(named: name)
show(photo)
*/
