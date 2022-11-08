import UIKit

// 두 수의 나눗셈
func solution0(_ num1: Int, _ num2: Int) -> Int {
    guard num1 >= 0 && num1 <= 100 && num2 >= 0 && num2 <= 100 else {
        return -1
    }
    let res: Int = Int(Float(num1) / Float(num2) * 1000)
    return res
}

solution0(3, 2)
solution0(7, 3)
solution0(1, 16)

// 숫자 비교하기
func solution(_ num1: Int, _ num2: Int) -> Int {
    guard num1 >= 0 && num1 <= 10000 && num2 >= 0 && num2 <= 10000 else {
        return 0
    }
    if(num1 == num2) {
        return 1
    } else {
        return -1
    }
}

solution(2, 3)
solution(11, 11)
solution(7, 99)


// ⭐️ 분수의 덧셈 ⭐️
func solution2(_ denum1: Int, _ num1: Int, _ denum2: Int, _ num2: Int) -> [Int] {
    guard (denum1 > 0 && denum1 < 1000), (num1 > 0 && num1 < 1000), (denum2 > 0 && denum2 < 1000), (num2 > 0 && num2 < 1000) else {
        return []
    }
    
    var a = denum1 * num2 + denum2 * num1
    var b = num1 * num2
    var r1: Int
    var r2: Int
    var r3: Int

    if a > b {
        r1 = a
        r2 = b
        while !(r1 % r2 == 0) {
            r3 = r1 % r2
            r1 = r2
            r2 = r3
        }
        a = a / r2
        b = b / r2
    }else if b > a {
        r1 = b
        r2 = a
        while !(r1 % r2 == 0) {
            r3 = r1 % r2
            r1 = r2
            r2 = r3
        }
        a = a / r2
        b = b / r2
    }else {
        r1 = a
        r2 = b
        a = a / r2
        b = b / r1
    }
    return [a,b]
}

solution2(1, 2, 3, 4)
solution2(9, 2, 1, 3)
solution2(9, 4, 1, 4)


// 베열 두배 만들기
func solution3(_ numbers:[Int]) -> [Int] {
    var result: [Int] = []
    for i in [1,2,3,4,5] {
        guard i >= -10000 && i <= 10000 else { break }
        var doubleI = i * 2
        result.append(doubleI)
    }
    return result
}

solution3([1,2,3,4,5])
