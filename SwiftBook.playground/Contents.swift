import UIKit

func greet(person: String) -> String {
    let greeting = "Hello, \(person)!"
    return greeting
}

func greetAgain(person: String) -> String {
    return "Hello again, \(person)!"
}

func sayHelloWorld() -> String {
    return "Hello, World!"
}

func greetWithBool(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}

func greet3(person: String) {
    print("Hello, \(person)")
}

greet(person: "Anna")
sayHelloWorld()
greetWithBool(person: "Anna", alreadyGreeted: true)
greetWithBool(person: "Tim", alreadyGreeted: false)
greet3(person: "Tony")

let bounds = minMax(array)
