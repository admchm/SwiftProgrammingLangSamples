import UIKit
import Foundation

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

/*
func listPhotos(inGallery name: String) async throws -> [String] {
    try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
    return ["IMG001, IMG99", "IMG0404"]
}
*/
 
// let gallery = try await listPhotos(inGallery: "Photos")

// ASYNCHRONOUS SEQUENCES
// Another approach to "downloading" all images at once from the listPhotos is to
// wait for one element of the collection at a time using an asynchronous sequence.

/*
let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}
*/

/** CALLING ASYNCHRONOUS FUNCTIONS IN PARALLEL **/

// drawback - downloading photos completely one after another:
/*
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])

let photos = [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
*/

// improvement - downloading multiple photos parallel:
// (“write async in front of let when you define a constant, and
// then write await each time you use the constant).

// async-let syntax creates a child task for us

/*
async let firstPhoto = await downloadPhoto(named: photoNames[0])
async let secondPhoto = await downloadPhoto(named: photoNames[1])
async let thirdPhoto = await downloadPhoto(named: photoNames[2])

let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
*/

/** TASKS AND TASK GROUPS **/
// A task is a unit that can be run asynchronously as a part of your
// program.

/*
await withTaskGroup(of: Data.self, body: { taskGroup in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        taskGroup.addTask { await downloadPhoto(named: name)}
    }
})
*/

// UNSTRUCTURED CONCURRENCY
// An unsturcutred task doesn't have a parent task. In this case,
// we have complete flexibility to manage unstructured tasks in
// whatever way our program needs, but we're also completely responsible
// for their correctness.
// - To create an unstructured task that runs on the current actor, call:
//   Task.init(priority:operation:)
// - To create an unstructured task that's not a part of the current actor,
//   call Task.deatached(priority:operation) class method.

/*
let newPhoto = // ... some photo data ...
let handle = Task {
    return await add(newPhoto, toGalleryNamed: "Spring Adventures")
}
let result = await handle.value
*/

// TASK CANCELLATION
// To check for cancellation, either call Task.checkCancellation(), which
// throws CancellationError if the task has been cancelled, or check
// the value of Task.isCancelled and handle the cancelation in our own
// code.

/** ACTORS **/

// You can use tasks to break up your program into isolated, concurrent
// pieces. Tasks are isolated from each other, which is what makes it safe
// for them to run at the same time, but sometimes you need to share some
// information between tasks. Actors let you safely share information
// between concurrent code.

actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int
    
    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)


extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}

/** SENDABLE TYPES **/
struct TemperatureReading: Sendable {
    var measurement: Int
}

extension TemperatureLogger {
    func addReading(from reading: TemperatureReading) {
        measurements.append(reading.measurement)
    }
}

let newLogger = TemperatureLogger(label: "Tea kettle", measurement: 85)
let reading = TemperatureReading(measurement: 45)
await newLogger.addReading(from: reading)
