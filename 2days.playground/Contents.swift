import UIKit

// Function: 어떤 기능을 하는 코드 모음
// 1) 함수 선언(정의)
func sayHello() {
    print("Hello, World!")
    print("Hello, Swift!")
    print("Let's go!")
}
// 2) 함수 실행
sayHello()

// 반대로는 안됨!
//sayHello2()

//func sayHello2() {
//    print("Hello, World!")
//    print("Hello, Swift!")
//    print("Let's go!")
//}

// 함수 사용 이유
// 1) 반복되는 동작을 편하게 재사용
// 2) 동작 구분의 편의
// 3) 코드의 단순화

// Function with input
func accessChk(name: String) {
    if(name == "TONY") {
        print("Hello, \(name)")
    } else {
        print("\(name)?? WHO R U??")
    }
}

accessChk(name: "TONY")

var mem = "THOR"
accessChk(name: mem)


// Function with output
func intro() -> String {
    return "Hello"
}

var cs = intro()
print("\(cs), Avengers")

// Function with input & output
func addTwo(a: Int, b: Int) -> Int {
    let c = a + b
    return c
}

var total = addTwo(a: 10, b: 20)
print(total)

// Argument Label -> family
func printName (family name: String) {
    print("I'm \(name)")
}

printName(family: "Ironman")

// Argument Label -> wildcard pattern
func addOP(_ first: Int, _ second: Int) {
    print(first + second)
}
addOP(1, 2)

// Variadic Parameters
func avgDoubles(_ numbers: Double...) -> Double {
    var total = 0.0
//    var x = numbers -> [1.0, 2.0, 3.0, 4.0]
//    print(x)
    for i in numbers {
        total += i
    }
    
    return total / Double(numbers.count)
}

print(avgDoubles(1.0, 2.0, 3.0, 4.0))

// default Parameter
func defaultChk(num1: Int, num2: Int = 5) -> Int {
    var res = num1 * num2
    return res
}

print(defaultChk(num1: 3))           // 15
print(defaultChk(num1: 3, num2: 7))  // 21

//print(<#T##items: Any...##Any#>, separator: <#T##String#>, terminator: <#T##String#>)
