import UIKit

// 두수의 합
func solution(_ num1:Int, _ num2:Int) -> Int {
    guard (num1 >= -50000 && num1 <= 50000), (num2 >= -50000 && num2 <= 50000) else {
        return -110000
    }
    let res = num1 + num2
    return res
}

solution(2, 3)
solution(100, 2)

// 두수의 차
func solution1(_ num1:Int, _ num2:Int) -> Int {
    guard (num1 >= -50000 && num1 <= 50000), (num2 >= -50000 && num2 <= 50000) else {
        return -110000
    }
    let res = num1 - num2
    return res
}

solution1(2, 3)
solution1(100, 2)

// 두수의 곱
func solution2(_ num1:Int, _ num2:Int) -> Int {
    guard (num1 >= 0 && num1 <= 100), (num2 >= 0 && num2 <= 100) else {
        return -1
    }
    let res = num1 * num2
    return res
}

solution2(3, 4)
solution2(27, 19)

// 몫 구하기
func solution3(_ num1:Int, _ num2:Int) -> Int {
    guard (num1 >= 0 && num1 <= 100), (num2 >= 0 && num2 <= 100) else {
        return -1
    }
    let res = num1 / num2
    return res
}

solution3(10, 5)
solution3(7, 2)
