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

// print(<#T##items: Any...##Any#>, separator: <#T##String#>, terminator: <#T##String#>)

// overloading: 기존에 정의했던 함수의 재사용 -> 파라미터 등을 바꾸기 위함
// ⭐️ SWIFT는 overloading을 지원하는 언어

func something(val: Int) {
    print(val)
}

func something(val: Double) {
    print(val)
}

func something(val: String) {
    print(val)
}

func something(_ val: String) {
    print(val)
}

func something(val1: Int, val2: String) {
    print(val1, val2)
}

something(val: 3)
something(val: 3.5)
something(val: "삼")
something(val1: 3, val2: "삼")

// inout Parameter: 함수를 통해 변수를 직접 수정할 때 사용

// inout 사용 전
var cnt1 = 456
var cnt2 = 789

func swap(a: Int, b: Int) { // let a, let b
    var c = a
//    a = b // a, b는 상수라서 변경 불가
//    b = c
}

swap(a: cnt1, b: cnt2)

// inout 사용 후
var cnt3 = 352
var cnt4 = 542

// 1) 함수 내 parameter type 앞에 inout 키워드 추가
func realSwap(a: inout Int, b: inout Int) { // var a, var b
    var temp = a
    a = b
    b = temp
    print(a, b)
}
// 2) 변수 전달 시, &기호 붙여서 전달
realSwap(a: &cnt3, b: &cnt4) // 542, 352

// guard -> else부분을 먼저 실행해서 조건 판별

// guard (X)
func chkPW(pw: String)  -> Bool {
    if (pw.count >= 6) {
        return true
    } else {
        return false
    }
}

// guard (O)
func chkPW2(pw: String)  -> Bool {
    guard pw.count >= 6 else {
        return false
    }
    
    return true
}

// Optional Type: 값이 있거나 없거나를 모두 포함하는 타입

var numz: Int = 3
// var numz: Int // Error
var num: Int? = 3
// var num: Int? // nil -> 값이 없음을 나타내는 키워드

print(numz) // 3
print(num) // Optional(3)

var opt1: Int? = 7
var opt2 = opt1

print(opt2) // Optional(7)

var opt3: Int = 5
// opt3 = opt2 // Int -> Int? type에 담는 것은 불가능
print(opt3)
// print(opt1 + opt2) // Optional type은 연산 불가능

// Optional value 추출
var afc: Int?
var charx: String? = "Can u hear me, now?"

// 1) Forced Unwrapping: 값이 확실하게 있다면 사용
print(charx!)
//print(afc!) Error

// 2) if condition
if(charx != nil) {
    print(charx!)
}

// 3) optional binding
if let s = charx {
    print(s)
}

var optName: String? = "TONY"
if let nam = optName {
    print(nam)
}

func sth(name: String?) {
    guard let zx = name else {return}
    print(zx)
}

sth(name: "BTS")

// 4) nil-coalescing
var snpName: String? = "Jack"
var nilSniper = snpName ?? "Who r u?" // snpName이 있으면 그 값을 없으면 ?? 뒤에 것을
print(nilSniper)

