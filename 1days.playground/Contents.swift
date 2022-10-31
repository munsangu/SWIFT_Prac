// 변수
var a = 5
// a = 10
// a = 12

var b = 10
// b = 20
// b = 30

var c = 20, d = 30, e = 40

//print(a + b) // 15
//print(c + d + e) // 90

var name = "Stark"
var age = 50
var address = "NewYork"

name = "Tony Stark"
age = 20
//print("I'm \(name).")
//print("I'm \(age) years old.")
//print("I live in \(address).")

// String Interpolation: "\(변수명)" -- 문자열 중간에 삽입할 때 사용

// 상수
let team = "Avengers"
// team = "AutoBot"; // Cannot assign to value: 'team' is a 'let' constant (Error)

// 데이터 타입
// SWIFT에서 사용하는 데이터 타입: Int(정수), Float(실수 6자리까지), Double(실수 15자리까지), Character(글자 한 개), String(문자열), Bool(참 & 거짓)
// SWIFT에서는 동일한 데이터타입끼리의 계산이 가능
// 타입(형) 변환 ex) Int(변수명), Double(변수명) ...
// 타입(형) 변환이 실패할 경우 nil(값이 없음)으로 바뀜

var m: Int = 4
var n: Int = 3
var l = m + n
// print(l)
type(of: l) // type(of: 변수명) -> 타입을 확인하는 함수

let num1 = 12
let num2 = 3.141529
//let res = num1 + num2
//print(res)

let charc = "123.45678"
let num3 = Int(charc)

//print(num3)

// Type Alias -> 데이터 타입의 명칭을 변경하는 것
typealias Syntax = String

let eng: Syntax = "ABCD" // let eng: String = "ABCD"와 동일

// 연산자
let ax = 6
let bx = 2
var res2: Int

res2 = ax + bx
//print(res2)

res2 = ax - bx
//print(res2)

res2 = ax * bx
//print(res2)

res2 = ax / bx
//print(res2)

res2 = ax % bx
//print(res2)

// 0...50 ~= rangex // 범위연산자, 패턴매칭 연산자

var lotto = Float.random(in: 1.0...45.0) // Int(Float).random(in: 범위) -> 범위 내 숫자 임의로
// print(lotto)

// (주의) SWIFT에서는 x++ 안됨 -> x += 1로 해야함

// 조건문
// if - else if - else
var rank = 100
if(rank >= 90 && rank < 100) {
    print("90점 이상이다")
    print("당신의 점수는 \(rank)점")
} else if(rank >= 80 && rank < 90) {
    print("80점 이상이다")
    print("당신의 점수는 \(rank)점")
} else if(rank >= 70 && rank < 80) {
    print("70점 이상이다")
    print("당신의 점수는 \(rank)점")
} else {
    print("당신의 점수는 \(rank)점")
}

// switch - case
var cho = "보"

switch cho {
case "가위":
    print("가위")
case "바위":
    print("바위")
case "보":
    print("보")
default:
    print("뭐야??")
    break;
}

// fallthrough in switch-case: 무조건 다음 조건식으로 이동
var cho2 = "보"

switch cho2 {
case "가위":
    print("가위")
    fallthrough
case "바위":
    print("바위")
    fallthrough
case "보":
    print("보")
    fallthrough
default:
    print("뭐야??")
    break;
}

// value binding
var six = 6

switch six {
case let a: // let a = num(binding)
    print("숫자: \(a)")
}

// where
var sev = 7

switch sev {
case let f where f % 2 == 0: // let f = sev
    print("너는 짝수 \(sev)")
case let f where f % 2 != 0:
    print("너는 홀수 \(sev)")
default:
    print("너는 0")
}

switch sev {
case let s where s <= 7:
    print("7 이하의 숫자 \(sev)")
default:
    print("7 이상의 숫자 \(sev)")
}

switch sev {
case var z where z > 3:
    z = 7
    print(z)
default:
    print(sev)
}

// 튜플
let threeNums = (2, 4, 8)
let (fst, snd, thd) = threeNums
print(fst) // 2


let iosDEV = (lang: "Swift", ver: "5")
iosDEV.lang // iosDEV.0
iosDEV.ver  // iosDEV.1

switch iosDEV {
case ("Swift", "5"):
    print("당신의 \(iosDEV.lang)의 버전은 \(iosDEV.ver)")
case ("Swift", "4"):
    print("당신의 \(iosDEV.lang)의 버전은 \(iosDEV.ver)")
default:
    break
}

var coods = (0, 20)

switch coods {
case(let distx, 0), (0, let distx):
    print("X축 또는 Y축 위에 위치하며, \(distx)만큼의 거리가 떨어져 있음")
default:
    print("어디에 있어??")
}

coods = (20, 0)

switch coods {
case (let q, let p) where q == p:
    print("(\(q), \(p))의 좌표는 y = x 그래프 위에 위치")
case (let q, let p) where q == -p:
    print("(\(q), \(p))의 좌표는 y = -x 그래프 위에 위치")
case (let q, let p):
    print("어디야??")
}

// 삼항연산자
var xz = 50
xz > 100 ? print("응") : print("아니야")
