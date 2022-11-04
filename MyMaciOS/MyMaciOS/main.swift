//
//  main.swift
//  MyMaciOS
//
//  Created by 문상우 on 2022/11/05.
//

import Foundation

var comChoice = Int.random(in: 1...100)

var myChoice: Int = 0

print("컴퓨터가 선택한 숫자 맞추기")

while true {
    var myInput = readLine()
    print("당신의 입력한 숫자: \(myInput!)")
    if let input = myInput {
        if let num = Int(input) {
            myChoice = num
        }
    }

    if(comChoice > myChoice) {
        print("UP")
        myChoice = 0
    } else if (comChoice < myChoice) {
        print("DOWN")
        myChoice = 0
    } else {
        print("BINGO")
        break
    }
}
