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

var zxc = Double(4 / 5) // 0.0
var vcxc = Double(4) / Double(5) // 0.8

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

// 범위연산자

// 1. Closed Range Operator, One-Sided Ranges
let rang = 1 ... 10
let rang2 = 1...
// let rang2 = 1 ... Expected expression after operator (Error)
let rang3 = ...10
// let rang3 = ... 10 Expected expression after operator (Error)

// 2. Half-Open Range Operator, One-Sided Ranges
let rangH = 1 ..< 10
// let rangH2 = 1 ..<= 10 사용불가
let rangH3 = ..<10
//let rangH3 = ..< 10 Expected expression after operator (Error)

for i in 1...5 {
    print("\(i)번째 출력")
}

let avengers = ["Ironman", "Hurk", "Thor"]
let cnt = avengers.count
for j in 0..<cnt {
    print("\(j + 1) HERO is \(avengers[j])")
}
for hr in avengers[...2] {
    print(hr)
}

var myAge = 29
switch myAge {
case 10...19:
    print("그대는 10대")
case 20...29:
    print("그대는 20대")
case 30...39:
    print("그대는 30대")
default:
    print("오우...")
}

// 패턴매칭 연산자 ~= 특정 범위내에 해당 숫자의 유무를 true / false 로 표현
// SWIFT에서는 -10<=x<10 사용 불가

let fux = 1...10
fux ~= 5 // true
fux ~= 20 // false

// _ 는 생략의 의미를 가지고 있음
for _ in 0...5 {
    print("*")
}
for boxs in avengers {
    print(boxs)
}

// 참고용 함수

// reversed() -> 역순으로
for number in (1...5).reversed() {
    print(number)
}

//stride(from: <#T##Strideable#>, through: <#T##Strideable#>, by: <#T##Comparable & SignedNumeric#>)
let odd = stride(from: 1, through: 14, by: 2)
for vcc in odd {
    print(vcc)
}

// while
var sum = 0
var num = 0
while num < 11 {
    sum+=num
    num += 1
}
print(sum) // 55

// Xcode 단축키
CMD + SHIFT + J : 열려있는 파일을 프로젝트 트리에서 보여주기
CMD + SHIFT + D 또는 Y: 디버깅 윈도우 열기/닫기 토글
CTRL + 1 : 현재 파일 관련 추가 메뉴 (find caller, callee)
CTRL + 6 : 현재 파일 요약 (method, variable list)
CMD + click: 정의로 이동
CMD + OPT + click: 정의로 이동하되 현재 창 반대편에 열기
CTRL + CMD + 왼쪽 / 오른쪽: 히스토리 이전/다음 이동
CMD + SHIFT + F: 전체 파일 스트링 검색
CMD + SHIFT + O: 파일 검색창 오픈
검색된 파일 선택시 OPT + Enter: 현재창 반대편에 열기
검색된 파일 선택시 OPT + SHIFT + Enter: 창 고르기
CMD + R: 실행
CMD + SHIF + K: 클린
CMD + 1 … 9: 왼쪽 사이드바의 탭 선택-
CMD + CTRL + E: 특정 단어 선택 후 누르면 현재 파일내 동일 단어를 일괄 편집 (모든 파일을 분석해서 업데이트해주는 refactor와는 다름에 주의)
CMD + OPT + 왼쪽 / 오른쪽: 현재 커서가 위치한 블록 접기/펼치기 (코드 양이 많을때 불필요한 메서드나 nesting된 블록을 접어놓고 보기 좋음)
