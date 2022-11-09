import UIKit

// 나머지 구하기
func solution(_ num1:Int, _ num2:Int) -> Int {
    guard (num1 > 0 && num1 <= 100), (num2 > 0 && num2 <= 100) else {
        return -1
    }
    var res = 0
    if(num1 >= num2) {
        res = num1 % num2
        return res
    } else {
        res = num2 % num1
        return res
    }
}

solution(3, 2)
solution(10, 5)

// ⭐️중앙값 구하기⭐️
func solution1(_ array:[Int]) -> Int {
    guard (array.count % 2 != 0), (array.count > 0 && array.count < 100) else {
        return -1001
    }
    for i in array {
        guard (i > -1000 && i < 1000) else {
            return -1001
        }
    }
    var newArray = array
    var newIdx = array.count / 2
    newArray.sort(by: <)
    return newArray[newIdx]
}

solution1([1,10,10,7,2, 55, 30])
solution1([1,10,11,7,2])
solution1([9,-1,0])
