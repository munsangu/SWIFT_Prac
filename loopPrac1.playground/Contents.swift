import UIKit

// 구구단 2단 ~ 9단 출력
for i in 2...9 {
    print("\(i)단")
    for j in 1...9 {
        print("\(i) * \(j) = \(i * j)")
    }
    print("=============")
}

print()


// 3의 배수 찾기
for z in 1...100 {
    if(z % 3 == 0) {
        print("3의 배수 발견: \(z)")
        continue
    }
}

print()

// 이모지 반복
for a in 1...5 {
    for b in 0...4 {
        if(a > b) {
            print("😁",terminator: "")
        }
    }
    print()
}
