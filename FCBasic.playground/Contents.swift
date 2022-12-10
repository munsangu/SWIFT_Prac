import UIKit

/*
 
 1. 성, 이름을 받아서 fullname을 출력하는 함수
 2. 1번에서 만든 함수인데, 파라미터 이름을 제거하고 fullname을 출력하는 함수
 3. 성, 이름을 받아서 fullname을 return 하는 함수
  
 */

func fullname1(familyName: String, Name: String) {
    print("Ur fullname is \(familyName + Name)")
}

func fullname2(_ familyName: String, _ Name: String) {
    print("Ur fullname is \(familyName + Name)")
}

func fullname3(familyName: String, Name: String) -> String {
    return familyName + Name
}

fullname1(familyName: "Tony", Name: " Stark")
fullname2("Mark", "-24")
print(fullname3(familyName: "Lion", Name: " Heart"))

/*
 
 1. 최애하는 영화배우의 이름을 담는 변수 작성
 2. let num = Int("10")에서 num의 타입?
  
 */

var myFavoriteActor: String? = "Robert Downey JR"
let num = Int("10") // Int?

var optionalInt = Int("500dsf")

func typeChk(_ anyThing: Int?) {
    guard let res = anyThing else {
        print("Get Out!")
        return
    }
    print(res)
}

typeChk(optionalInt)

print()

/*
 
 1. 최애 음식이름 담는 변수 작성 단, String?
 2. 1번 출력(옵셔널 바인딩)
 3. 닉네임을 받아서 출력하는 함수 만들기, 파라미터 String?
 
 */

var myFavoriteFood: String? = "돼지갈비"
var myFavoriteFood2: String?

func printMyBestFood(foodName: String?) {
    guard let res = foodName else {
        print("좋아하는 음식이 없군요")
        return
    }
    print("당신이 가장 좋아하는 음식은 \(res)군요.")
}
printMyBestFood(foodName: myFavoriteFood)
printMyBestFood(foodName: myFavoriteFood2)

func printNickName(nickName: String?) {
    guard let res = nickName else {
        print("닉네임이 없군요")
        return
    }
    print("당신의 닉네임은 \(res)군요.")
}

printNickName(nickName: "Hiro")
printNickName(nickName: nil)

print()
/*
 
 1. 이름, 직업, 도시에 대해서 본인의 딕셔너리 만들기
 2. 1에서 도시를 부산으로 바꾸기
 3. 딕셔너리를 받아서 이름과 도시를 프린트하는 함수 만들기
 
 */

var infoSet = ["name": "Tony", "job": "HERO", "city": "NewYork"]
infoSet["city"] = "Busan"
func printNameNCity(dic: [String: String]) {
    guard let name = dic["name"], let city = dic["city"] else {
        print("확인 불가 정보")
        return
    }
    print("\(name) lives in \(city)")
}
printNameNCity(dic: infoSet)

var multipleNum: (Int, Int) -> Int = {a, b in
    return a * b
}
let res = multipleNum(4, 4)

var addString: (String ,String) -> String = { a, b in
    return a + b
}
let res2 = addString("Tony", " Stark")

print()
/*
 
# Closure Expression Syntax
 
{ (parameters) -> return type in
    statements
}
 
*/

// 1. Simple Closure
let simpleClosure = {}
simpleClosure()


// 2. 코드블록을 구현한 Closure
let blockClosure = {
    print("Kakao Talk")
}
blockClosure()

// 3. 인풋 파라미터를 받는 Closure
let inputClosure: (String) -> Void = { name in
    print("Ur name is \(name), right?")
}
inputClosure("Stark")

// 4. 값을 리턴하는 Closure
let returnClosure: (String) -> String = { name in
    return "Hey, \(name)!"
}
print(returnClosure("Hurk"))

// 5. Closure를 파라미터로 받는 함수 구현
func chkClosure(firstThing: () -> Void) {
    print("첫번째, 함수에서 호출")
    firstThing()
}
chkClosure(firstThing: {
    print("두번째, 클로저에서 호출")
})


// 6. Trailing Closure
func chkClosure2(msg: String, firstThing: () -> Void) {
    print("첫번째, 함수에서 호출, 그 메세지는 '\(msg)'")
    firstThing()
}
chkClosure2(msg: "안녕하세요 감사해요 잘 있어요 다시 만나요", firstThing: {
    print("두번째, 클로저에서 호출")
})
chkClosure2(msg: "안녕하세요 감사해요 잘 있어요 다시 만나요") {
    print("두번째, 클로저에서 호출")
}

print()

// Class vs Structure

class PersonClass {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

struct PersonStruct {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let pClass1 = PersonClass(name: "Harward", age: 100)
let pClass2 = pClass1
pClass2.name = "Mow"

pClass1.name // Mow
pClass2.name // Mow

var pStruct1 = PersonStruct(name: "Harward", age: 100)
var pStruct2 = pStruct1
pStruct2.name = "Mow"

pStruct1.name // Harward
pStruct2.name // Mow

/*
 
 1. 강의 이름, 강사 이름, 학생 수를 가지는 Struct 만들기(Lecture)
 2. 강의 배열과 강사 이름을 받아서, 해당 강사의 강의 이름을 출력하는 함수 만들기
 3. 강의 3개 만들고 강사 이름으로 강의 찾기
 
 */

struct Lecture {
    
    let lecName: String
    let lecTeacher: String
    let lecViewer: Int
    
}

func printLecName(lecTeacher: String, lectures: [Lecture]) {
    var lecNam = ""
    
    for lec in lectures {
        if lecTeacher == lec.lecTeacher {
            lecNam = lec.lecName
        }
    }
    print("\(lecTeacher) is \(lecNam)'s teacher")
}

let firstInfo = Lecture(lecName: "Math", lecTeacher: "Tony", lecViewer: 5000)
let secondInfo = Lecture(lecName: "Science", lecTeacher: "Stark", lecViewer: 12000)
let thirdInfo = Lecture(lecName: "Medical", lecTeacher: "Strange", lecViewer: 8000)
let lecs = [firstInfo, secondInfo, thirdInfo]

printLecName(lecTeacher: "Tony", lectures: lecs)
printLecName(lecTeacher: "Stark", lectures: lecs)
print()

struct Person {
    var firstName: String {
        willSet {
            print("willSet: \(firstName) -> \(newValue)")
        }
        didSet {
            print("didSet: \(oldValue) -> \(firstName)")
        }
    }
    var lastName: String
    
    lazy var isPopular: Bool = {
        if fullName == "Tony Ksc" {
            return true
        } else {
            return false
        }
    }()
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
        set {
            if let firstName = newValue.components(separatedBy: " ").first {
                self.firstName = firstName
            }
            if let lastName = newValue.components(separatedBy: " ").last {
                self.lastName = lastName
            }
        }
    }
    
    static let isBoss: Bool = true
}

var person1 = Person(firstName: "Linda", lastName: "Tailer")
person1.firstName
person1.lastName
person1.fullName

person1.firstName = "Yagami"
person1.lastName = "Raito"

person1.firstName
person1.lastName
person1.fullName

person1.fullName = "Tony Stark"
person1.firstName
person1.lastName

Person.isBoss
person1.isPopular

// struct -> class

struct PersonStruct2 {
    var firstName: String
    var lastName: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    mutating func uppercaseName() {
        firstName = self.firstName.uppercased()
        lastName = self.lastName.uppercased()
    }
}

class PersonClass2 {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    func uppercaseName() {
        firstName = firstName.uppercased()
        lastName = lastName.uppercased()
    }
}

let firstPersonClass = PersonClass2(firstName: "Bruno", lastName: "mars")
firstPersonClass.firstName
firstPersonClass.lastName
firstPersonClass.fullName
firstPersonClass.uppercaseName()
firstPersonClass.firstName
firstPersonClass.lastName
firstPersonClass.fullName

print()

// Struct vs Class 선택 -> 일단 Struct으로 사용
 

