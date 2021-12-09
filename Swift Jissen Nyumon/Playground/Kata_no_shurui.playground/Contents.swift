import UIKit

//型の種類　構造体　クラス　列挙型
//構造体と列挙型は値型で変数や定数への値型のisんスタンスの代入はインスタンスが表す値そのものの代入を意味する

//構造体　値型
struct Color {
    var red: Int
    var green: Int
    var blue: Int
}

var a = Color(red: 255, green: 0, blue: 0) //aに赤を代入
var b = a //bに赤を代入
a.red = 0 //　aのredを0にすることで黒にする

a.red // 0
b.red //255 赤のまま


//クラス 参照型
class Color2 {
    var red: Int
    var green: Int
    var blue: Int

    init(red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

var a2 = Color2(red: 255, green: 0, blue: 0)
var b2 = a2
a2.red = 0

a2.red // 0
b2.red // 0



//muatingキーワード　自身の値の変更を宣言するキーワード
// mutating func メソッド名(引数) -> 戻り値型 {
//    メソッド呼び出し実行文
// }

extension Int {
    mutating func increment() {
        self += 1
    }
}

var int = 1 // 1
int.increment()

let int2 = 1
//int2.increment()  int2が定数で再代入できないためコンパイルエラー


// Array<element> varで宣言した場合は append(_:)メソッドにmuatingキーワードがついているため代入ができる
var mutableArray = [1,2,3]
mutableArray.append(4)
//mutating func append(_ newElement: Element)


//メソッド内のストアドプロパティの変更にはmutatingが必要
struct SomeStruct {
    var id: Int

    init(id: Int) {
        self.id = id
    }

    mutating func someMethod() { //mutatingなしでコンパイルエラー
        id = 4
    }
}

var a3 = SomeStruct(id: 1)
a3.someMethod()
a3.id //4



//メンバーワイズイニシャライザ デフォルトで用意されるイニシャライザ
struct Article {
    var id: Int
    var title: String
    var body: String

    //以下と同等のイニシャライザが自動的に定義される
    //    init(id: Int,title: String,body: String) {
    //        self.id = id
    //        self.title = title
    //        self.body = body
    //    }
}

let article = Article(id: 1, title: "hello", body: "...")
article.id //1
article.title //hello

//Mail型のクラスのsubjectにはデフォルト引数として"No Subject"が定義される



//クラス　継承　新たなクラスを定義するときに、他のクラスのプロパティ、メソッド、イニシャライザなどの型を再利用する仕組み。継承先のクラスでは継承元のクラスと共通する動作をあらためて定義する必要なく継承元のクラスとの差分のみ定義すれば済む。　継承元はスーパークラス　継承先はサブクラス　多重継承は禁止されている
// class class名: SuperClass名　{
//    クラス定義
// }

class User {
    let id: Int

    var message: String {
        return "Hello."
    }

    init(id: Int) {
        self.id = id
    }

    func printProfile() {
        print("id: \(id)")
        print("message: \(message)")
    }
}

// Userを継承したクラス
class RegisterdUser: User {
    let name: String

    init(id: Int, name: String) {
        self.name = name
        super.init(id: id)
    }

    override func printProfile() {
        super.printProfile()
        print("name \(name)")
    }
}

let registerdUser = RegisterdUser(id: 1, name: "Yosuke Ishikawa")
let id = registerdUser.id
let message = registerdUser.message
registerdUser.printProfile() // id 1 message:hello  name yosuke Ishikawa



//final class　継承とオーバーライドの禁止
class SuperCloass {
    func overridableMethod() {}
    final func finalMethod() {}
}

class SubClass: SuperCloass {
    override func overridableMethod() {} // オーバーライド可能
    //    override func finalMethod() {}   オーバライド不可
}

class InheritableClass {}
class ValidSubClass: InheritableClass {}
final class FinalClass {}
//class InvalidSubClass: FinalClass {}  オーバーライド不可



//クラスプロパティ　　これらはオーバーライドできる　スタティックはできない
class A {
    class var className: String {
        return "A"
    }
}

class B: A {  //オーバーライド
    override class var className: String {
        return "B"
    }
}

A.className //A
B.className //B



//クラスメソッド　クラスに紐付くメソッド インスタンスに依存しない処理を実装する際に利用
class A2 {
    class func inheritanceHierarchy() -> String {
        return "A"
    }
}

class B2: A2 {
    override class func inheritanceHierarchy() -> String {
        return super.inheritanceHierarchy() + "<-B"
    }
}

class C2: B2 {
    override class func inheritanceHierarchy() -> String {
        return super.inheritanceHierarchy() + "<-C"
    }
}

A2.inheritanceHierarchy() //"A"
B2.inheritanceHierarchy() //"A<-B"
C2.inheritanceHierarchy() //"A<-B<-C"



//指定イニシャライザ　 クラスの主となるイニシャライザ　全てのストアドプロパティが初期化される必要がある
class Mail {
    let from: String
    let to: String
    let title: String

    //指定イニシャライザ
    init(from: String, to: String, title:String) {
        self.from = from
        self.to = to
        self.title = title
    }
}



//コンビニエンスイニシャライザ　指定イニシャライザをラップする　中継して内部で引数を組み立てて指定イニシャライザを呼び出す
//最終的に同一クラスの指定イニシャライザを呼ぶ
class Mail2 {
    let from: String
    let to: String
    let title: String

    init(from: String, to: String, title:String) {
        self.from = from
        self.to = to
        self.title = title
    }

    convenience init(from: String, to: String) {
        self.init(from: from, to: to, title: "Hello,\(from)")
    }
}

var mail2 = Mail2(from: "yosuke", to: "ishikawa")
print(mail2.from,mail2.to,mail2.title)  //yosuke ishikawa Hello,yosuke


//デフォルトイニシャライザ
class defaultInit {
    let id = 0
    let name = "Taro"

    //以下と同等のイニシャライザが自動で定義される
    //    init() {}
}

let user = defaultInit()

// class defaultInit2 { 初期化する手段がないためコンパ入れラー
//    let id: Int
//    let name: String
// }



//デイニシャライザ　インスタンスの終了処理　ARC(automatic reference counting)によってインスタンスが破棄されるタイミングで実行される
class deInit {
    deinit{
        //クリーンアップなどの処理
    }
}


//参照型の比較 　参照先自体の比較は===で行う
class SomeClass: Equatable {
    static func ==(lhs: SomeClass, rhs: SomeClass) -> Bool {
        return true
    }
}

let a4 = SomeClass()
let b4 = SomeClass()
let c4 = a4

a4 == b4 // true
a4 === b4 // false
a4 === c4 // true



//列挙型　複数の識別子をまとめる型
enum Weekday {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

let sunday = Weekday.sunday // sunday
let monday = Weekday.monday // monday


enum Weekday2 {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    init?(japaneseName: String) {
        switch japaneseName {
        case "日": self = .sunday
        case "月": self = .monday
        case "火": self = .tuesday
        case "水": self = .wednesday
        case "木": self = .thursday
        case "金": self = .friday
        case "土": self = .saturday
        default: return nil
        }
    }
}

let sunday2 = Weekday2(japaneseName: "日") // sunday
let monday2 = Weekday2(japaneseName: "月") // monday


//ローバリュー　実態の定義　列挙型のケースにそれぞれ対応する値を設定できる
//enum lawValue: Any {
//    case a = ローバリュー1
//    case b = ローバリュー2
//}

enum Symbol: Character {
case sharp = "#"
case doller = "$"
case percent = "%"
}

let symbol = Symbol(rawValue: "#")  // sharp
let character = symbol?.rawValue //#


//ローバリューのデフォルト値　最初のケースが0でそれ以降は前のケースに1を足した値　String型はケース名のまま文字列表示
enum Option: Int {
case none
case one
case two
case undefined = 999
}

Option.none.rawValue // 0
Option.one.rawValue // 1
Option.two.rawValue // 2
Option.undefined.rawValue // 999



//連想型　付加情報の付与　列挙型のインスタンスは連想型という付加情報を持たせることもできる
enum Color3 {
    case rgb(Float,Float,Float)
    case cmyk(Float,Float,Float,Float)
}

let rgb = Color3.rgb(0.0, 0.33, 0.66)
let cmyk = Color3.cmyk(0.0, 0.33, 0.66, 0.99)

switch rgb {
case .rgb(let r, let g, let b): print("rgb")
case .cmyk(let c, let m, let y, let k): print("cmyk")
}


//Caselterableプロトコル　要素列挙のプロトコル　CaseIterableプロトコルへの準拠を宣言するとallCasesが追加され、すべての要素を返せる
enum Fruit: CaseIterable {
case peach, apple, grape
}

Fruit.allCases  // [peach, apple, grape]




