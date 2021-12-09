import UIKit

//型の構成要素
// struct 構造体　class クラス enum 列挙型

struct Greeting {
    var to = "Yosuke Ishikawa"
    var body = "Hello!"
}

let greeting1 = Greeting()
var greeting2 = Greeting()
greeting2.to = "kawata"

let to1 = greeting1.to // Yosuke Ishikawa
let to2 = greeting2.to // kawata



//スタティックプロパティ 型自身に紐つくプロパティ
struct Greeting2 {
    var to = "Yosuke Ishikawa"
    var body = "Hello"
    static let signature = "sent from iphone"
}

func print(greeting: Greeting2) {
    print("to: \(greeting2.to)")
    print("body: \(greeting.body)")
    print("signature: \(Greeting2.signature)")
}



//ストアドプロパティ　値を保持するプロパティ 変数や定数のように値を代入して保存するプロパティ　 値を保持しないのはコンピューテッドプロパティ
struct SomeStruct {
    var variable = 123 //　再代入可能
    let constant = 123 // 再代入不可
    static var staticVariable = 789 //再代入可能　型自身に紐つく
    static let staticConstant = 789 //再代入不可　型自身に紐つく
}



//プロパティオブザーバー　ストアドプロパティの変更を監視し変更前と変更後に文を実行するもの
// var プロパティ名　= 初期値　{
//   willSet {
//   プロパティの変更前に実行する文
//   変更後の値にはnewValueとしてアクセスできる
// }
//
// didSet {
//    プロパティの変更後に実行する文
//     }
//   }

struct Greeting3 {
    var to = "yosuke" {
        willSet {
            print("willSet: (to; \(self.to), newValue: \(newValue))")
        }

        didSet {
            print("didSet: \(self.to)")
        }
    }
}

var greeting5 = Greeting3()
greeting5.to = "kawata"
//結果: willSet: (to; yosuke, newValue: kawata)
//     didSet: kawata


//レイジーストアドプロパティ　アクセスされるまで初期化を遅延させるプロパティ letキーワードによる再代入不可能なプロパティでは使用できない
struct SomeStruct2 {
    var value: Int = {
        print("valueの値を生成します")
        return 1
    }()

    lazy var lazyValue: Int = {
        print("lazyValueの値を生成します")
        return 2
    }()
}

var someStruct2 = SomeStruct2()
print("someStructをインスタンス化")
print("valueの値は\(someStruct2.value)")
print("lazyValueの値は\(someStruct2.lazyValue)")

//結果: valueの値を生成します
//  someStructをインスタンス化　//someStruct2のインスタンス化時に初期化される
//  valueの値は1
//  lazyValueの値を生成します  //レイジーがつくとアクセス時に初期化が行われる
//  lazyValueの値は2



//コンピューテっどプロパティ　値を保持せずに算出するプロパティ　既に存在するストアドプロパティなどから計算して値を返すプロパティ
//var プロパティ名: 型名　{
//    get {
//        return文によって値を返す処理
//    }
//
//    set {
//        値を更新する処理
//        プロパティに代入された値には定数newValueとしてアクセスできる
//    }
//}

//ゲッタ　値の返却　 他のストアドプロパティなどから値を取得してコンピューテッドプロパティとして値を返す処理
struct Greeting4 {
    var to = "yusuke"
    var body: String {  // コンピューテッドプロパティ
        get {
            return "Hello, \(to)"  //ストアドプロパティを使用可能
        }
    }
}

let greeting6 = Greeting4()
greeting6.body // Hell0, yusuke

//セッタ　値の更新　プロパティに代入された値を使用して他のストアドプロパティなどを更新する処理
struct Temprature {
    //摂氏温度
    var celsius: Double = 0.0

    var fahrenheit: Double {
        get {
            return (9.0 / 5.0) * celsius + 32.0
        }

        set {
            celsius = (5.0 / 9.0) * (newValue - 32.0)
        }
    }
}

var temprature = Temprature()
temprature.celsius // 0
temprature.fahrenheit // 32

temprature.celsius = 20
temprature.celsius //20
temprature.fahrenheit // 68

temprature.fahrenheit = 32
temprature.celsius // 0
temprature.fahrenheit // 32


struct Temprature2 {
    //摂氏温度
    var celsius: Double = 0.0

    var fahrenheit: Double {
        get {
            return (9.0 / 5.0) * celsius + 32.0
        }

        set(newFahrenheit) { //(任意の名前を与えて使用することもできる)
            celsius = (5.0 / 9.0) * (newFahrenheit - 32.0)
        }
    }
}


//セッタの省略　セッタが存在しない場合はgetと{}を省略できる
struct Greeting7 {
    var to = "yusuke"
    var body: String {
        return "Hello,\(to)!"
    }
}

let greeting7 = Greeting7()
greeting7.body //Hello,yusuke

struct Greeting8 {
    var to = "yusuke"
    var body: String {
        return "Hello,\(to)!"
    }
}

let greeting = Greeting8()
greeting.body // hello, yusuke
//greeting7.body = "hi" 　セッタが定義されていないためコンパイルエラー



//イニシャライザ　　インスタンスを初期化する　引数と初期化に関する処理を定義
struct Greeting9 {
    let to: String
    var body: String {
        return "hello, \(to)!"
    }

    init(to: String) {
        self.to = to
    }
}

let greeting9 = Greeting9(to: "yosuke")
let body = greeting9.body // hello, yosuke



//失敗可能イニシャライザ　初期化できないケースに対応　init?
struct Item {
    let id: Int
    let title: String

    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
              let title = dictionary["title"] as? String else {
                  //このケースではidとtitleは未初期化のままでもコンパイル可能
                  return nil
              }
        self.id = id
        self.title = title
    }
}

var item = Item(dictionary: ["id" : 2, "title": "aaa"])
var item2 = Item(dictionary: ["id" : 3,"afda": "aaa"])
print(item?.id,item!.title) // Optional(2) aaa
print(item2?.id,item2?.title)  // nil nil


let dictionaries: [[String: Any]] = [
    ["id": 1, "title": "abc"],
    ["id": 2, "title": "def"],
    ["title": "ght"],
    ["id": 3, "title": "jkl"],
]

for dictionary in dictionaries {
    if let item = Item(dictionary: dictionary) {
        print(item)
    } else {
        print("エラー: 辞書\(dictionary)からItemを生成できませんでした")
    }
}
//結果　Item(id: 1, title: "abc")
//　Item(id: 2, title: "def")
//　エラー: 辞書["title": "ght"]からItemを生成できませんでした
//　Item(id: 3, title: "jkl")


//デフォルト値の用意
struct Item2 {
    let name: String
    let title: String

    init(dictionary: [String: String]) {
        name = dictionary["name"] ?? "noName"
        title = dictionary["title"] ?? "noTitle"
    }
}

var item3 = Item2(dictionary: ["name" : "john"])
print(item3.name,item3.title)   // john noTitle


//インスタンスメソッド　型のインスタンスに紐付いたメソッド
struct SomeStruct3 {
    var value = 0

    func printValue() {
        print("value: \(self.value)")
    }
}

var someStruct3 = SomeStruct3()
someStruct3.value = 1
someStruct3.printValue() //value1

var someStruct3_2 = SomeStruct3()
someStruct3_2.value = 2
someStruct3_2.printValue() //value2


//スタティックメソッド　型自身に紐付くメソッド　メソッドの定義の先頭にstaticキーワードを追加する
struct Greeting10 {
    static var signature = "sent from iphone"
    static func setSignature(withDeviceName deviceName: String) {
        signature = "sent from \(deviceName)"
    }

    var to = "Yosuke Ishikawa"
    var body: String {
        return "Hello,\(to) \n \(Greeting10.signature)"
    }
}

let greeting10 = Greeting10()
print(greeting10.body)
print("---")

Greeting10.setSignature(withDeviceName: "Xperia")
print(greeting10.body)

//  Hello,Yosuke Ishikawa
//  sent from iphone
//  ---
//  Hello,Yosuke Ishikawa
//  sent from Xperia



//オーバーロード　型が異なる同名のメソッドの定義　　異なる型の引数や戻り値を取る同名のメソッドを代入先の型に応じて実行するメソッド
//引数によるオーバーロード
struct Printer {
    func put(_ value: String) {
        print("string: \(value)")
    }

    func put(_ value: Int) {
        print("int: \(value)")
    }
}

let printer = Printer()
printer.put("abc")  //string: abc
printer.put(123)   //int: 123


//戻り値によるオーバーロード
struct ValueContainer {
    let stringValue = "abc"
    let intValue = 123

    func getValue() -> String {
        return stringValue
    }

    func getValue() -> Int {
        return intValue
    }
}

let valueContainer = ValueContainer()
let string: String = valueContainer.getValue() // abc
let int: Int = valueContainer.getValue() // 123



//サブスクリプト　コレクションの要素へのアクセス 　外部引数名がデフォルトで_となる
//　subscript(引数) -> 戻り値の型 {
//    get {
//        return文によって値を返す処理
//    }
//
//    set {
//        値を更新する処理
//    }
//　}

//数列
struct Progression {
    var numbers: [Int]

    subscript(index: Int) -> Int {
        get {
            return numbers[index]
        }

        set {
            numbers[index] = newValue
        }
    }
}

var progression = Progression(numbers: [1,2,3])
let element1 = progression[1]   // 2

progression[1] = 4
let element2 = progression[1]   //4


//エクステンション　型を構成する要素を追加できる
//メソッドの追加
extension String {
    func printSelf() {
        print(self)
    }
}

let string3 = "abc"
string3.printSelf() // abc

extension String{
    var enclosedString: String {
        return "[\(self)]"
    }
}
let title = "重要".enclosedString + "今日はお休み" // "[重要]今日はお休み"


import UIKit

enum WebAPIError: Error {
case connectionError(Error)
case fatalError

    var title: String {
        switch self {
        case .connectionError: return "通信エラー"
        case .fatalError: return "致命的なエラー"
        }
    }

    var message: String {
        switch self {
        case .connectionError(let underlyingError):
            return underlyingError.localizedDescription + "再試行してください"
        case .fatalError: return "サポート窓口に連絡してください"
        }
    }
}

extension UIAlertController {
    convenience init(webAPIError: WebAPIError) {

        //UIAlertControllerの指定イニシャライザ
        self.init(title: webAPIError.title,
                  message: webAPIError.message,
                  preferredStyle: .alert)
    }
}

let error = WebAPIError.fatalError
let alertController = UIAlertController(webAPIError: error)



//型のネスト　型の中に型を定義できる
enum NewsFeedItemKind {
    case a
    case b
    case c
}

struct NewsFeedItem {
    let id: Int
    let title: String
    let type: NewsFeedItemKind
}

//上記は命名で縛っているに過ぎない

//下記は型の中にネストして定義している
struct NewsFeedItem2 {
    enum Kind {
        case a
        case b
        case c
    }

    let id: Int
    let title: String
    let kind: Kind

    init(id: Int, title: String, kind: Kind) {
        self.id = id
        self.title = title
        self.kind = kind
    }
}

    let kind = NewsFeedItem2.Kind.a
    let item4 = NewsFeedItem2(id: 1, title: "Table", kind: kind)

switch item4.kind {
case .a: print("a")
case .b: print("b")
case .c: print("c")
}    //　結果　a


