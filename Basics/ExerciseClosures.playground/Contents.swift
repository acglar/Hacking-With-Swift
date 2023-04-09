import UIKit

var greeting = {
    "Hello, playground"
}

greeting()

// closure with paremeter
var greet = { (name: String) in
    "Hello, \(name)"
}

greet("Caglar")

var age: Int = 26

var getOld = { (currentAge: inout Int) in
    currentAge += 1
}

getOld(&age)

// closure with returns
var currentYear = 2023

var calculateAge = { (birthYear: Int) -> Int in
    return currentYear - birthYear
}

age = calculateAge(1997)

// closure as parameter
var onCompleteMessage = {
    print("It's done")
}

func CountToTen(onComplete: () -> Void) {
    for number in 1...10 {
        print(number)
    }

    onComplete()
}

CountToTen(onComplete: onCompleteMessage)

func Count(To targetNumber: Int, countAction: (Int) -> Void) {
    for number in 1...targetNumber {
        countAction(number)
    }
}

Count(To: 5, countAction: { (number: Int) in
    print(number)
})

Count(To: 6) { (number: Int) in
    print(number)
}


