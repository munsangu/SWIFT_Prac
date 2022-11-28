import UIKit

// 2014년 6월 2일 세계개발자대회(WWDC 2014)에서 처음으로 SWIFT 발표
// IDE(Integrated Development Environment, 통합 개발 환경)

// Hacking With Swift

// 변수(Variable)와 상수(Constants)
var name = "Tony"
name = "Stark"

let age = 100
//age = 50 // (Error) Cannot assign to value: 'age' is a 'let' constant

// Types of data
var nam: String
nam = "Ironman"

var num: Int
num = 200

//nam = 25 // (Error) Cannot assign value of type 'Int' to type 'String'
//num = "Mark" // (Error) Cannot assign value of type 'String' to type 'Int'

var latitude: Double
latitude = 2336.1667

var longitude: Float
longitude = -86.8644

var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = false

// Operators
var a = 10
var b = 20

a + b
a - b
a * b
a / b
a % b
a += a
b -= b

var firstName = "Tony "
var lastName = "Stark"
var fullname = firstName + lastName
/*
var newText = firstName + a
(Error) Binary operator '+' cannot be applied to operands of type 'String' and 'Int'
*/

a == b
a != b

// String Interpolation
var testName = "Shark"
var testSyn = "Who is \(testName)?"
print("What is \(testName)?")
print(testSyn)

// Array
var evenNum = [2, 4, 6, 8]
var oddNum = [1, 3, 5, 7]
var cities = ["Seoul", "NewYork", "Tokyo"]
/*
 var someThings = [1, 5, "Kyoto"]
 (Error) Heterogeneous collection literal could only be inferred to '[Any]'; add explicit type annotation if this is intentional
*/
var somethings: [Any] = [1, 5, "Kyoto"]

evenNum[0]
oddNum[1]
cities[2]

/*
 evenNum[5] error: Execution was interrupted, reason: EXC_BREAKPOINT (code=1, subcode=0x18bce2e10).
*/

var everyNum = evenNum + oddNum

// Dictionaries
var favMusic = [
                "Lisa": "Akebosi",
                "T.M.Revolution": "Vestige"
               ]
favMusic["Lisa"]

// Conditional Statements
var chkNum = 50

if chkNum > 70 {
    print("U r rank is \(chkNum) > 70")
} else if chkNum > 60 {
    print("U r rank is \(chkNum) > 60")
} else {
    print("U r rank is \(chkNum) = 50")
}


// Loops
for i in 2...9 {
    for j in 1...9 {
        print("\(i) * \(j) = \(i * j)")
    }
    print("==================")
}

var numSum = 0
for j in 1...10 {
    numSum += j
}
print(numSum)

var songsOfJPN = ["明け星", "炎", "紅蓮華", "夜にかける", "新世代"]
for z in songsOfJPN {
    print(z)
}

var cnt = 0
while true {
    cnt += 1
    if cnt > 10 {
        break
    }
}
print(cnt)

// Switch - Case
var rank = 80
switch rank {
case 90...100:
    print("\(rank) is A")
case 80...89:
    print("\(rank) is B")
default:
    print("U r Fall")
}

// Functions
func sayHello() {
    print("Hi")
}

sayHello()

func sayHello2(name: String) {
    print("Welcome, \(name)")
}

sayHello2(name: "Thor")

func chkCharCnt(checkChar chr: String) -> Int {
    return chr.count
}
/*
func chkCharCnt(_ chr: String) -> Int {
    return chr.count
}
chkCharCnt("Avengers")
 */

var resCnt = chkCharCnt(checkChar: "Avengers")
print(resCnt)


// Optionals
func nowStatus(weather: String) -> String? {
    guard weather == "sunny" else {
        return "Hate"
    }
    return nil
}

var res1 = nowStatus(weather: "sunny")
print(res1)
var res2 = nowStatus(weather: "foggy")
print(res2)
print(res2!)
