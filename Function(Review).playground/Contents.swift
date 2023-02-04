import UIKit

// 함수 = 함수 정의문 + 함수 실행문
// 함수 정의문
func countPrint() {
    for i in 1...3{
        print(i)
    }
}
// 함수 실행문
countPrint()
print("=========================")
func sayCommand(name: String) {
    print("Hello, \(name)")
}

sayCommand(name: "Tony")

func rankSayCmd(rank: Int, name: String) {
    print("\(name) is My No.\(rank) Person")
}
print("=========================")
rankSayCmd(rank: 1, name: "Hurk")
print("=========================")
func squareNum(num: Int) -> Int {
    let a = num * num
    return a
}
let res = squareNum(num: 5)
print(res)
print("=========================")
func moveToRightCmd() -> String {
    return "Right!"
}
let destination = moveToRightCmd()
print("Ur destination is at \(destination)")
print("=========================")
func labelTest(firstInfo name: String) {
    print("That's right, \(name)")
}
labelTest(firstInfo: "Judy")
print("=========================")
func wildTest(_ name: String) {
    print("U r \(name)")
}
wildTest("Hoppy")
print("=========================")
func avgNums(_ numbers: Double...) -> Double {
    var total = 0.0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
let res2 = avgNums(4.5, 4.5, 4.3, 4.7)
print(res2)
print("=========================")
func defaultTest(num1: Int, num2: Int = 5) -> Int {
    var res = num1 + num2
    return res
}
let test1 = defaultTest(num1: 3)
print(test1)
let test2 = defaultTest(num1: 3, num2: 7)
print(test2)
print("=========================")
