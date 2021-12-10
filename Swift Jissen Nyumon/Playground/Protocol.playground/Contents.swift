import UIKit
import Foundation

//プロトコル　型のインターフェースを定義するもの　型がどのようなプロパティやメソッドを持っているか示す
//プロトコルが要求するインターフェースを型が満たすことを準拠という

protocol SomeProtocol {
    func someMethod()
}

struct SomeStruct1: SomeProtocol {
    func someMethod() {
    }
}
// someMethod()が定義されていないためコンパイルエラー
// struct SomeStruct2: SomeProtocol {}



//クラス継承時の準拠方法
protocol SomeProtocol2 {}
class SomeSuperClass {}
class SomeClass: SomeSuperClass, SomeProtocol2 {}



//extensionによる準拠方法
protocol SomeProtocol3 {
    func someMethod()
}
protocol SomeProtocol4 {
    func someMethod2()
}
struct SomeStruct {
    let somePropery: Int
}

extension SomeStruct: SomeProtocol3 {
    func someMethod() {}
}
extension SomeStruct: SomeProtocol4 {
    func someMethod2() {}
}



//プロトコルは構造体、クラス、列挙型等と同様に変数、定数や引数の型として使用できる
protocol ProtocolA {
    var variable: Int { get }
}

func someMethod(x: ProtocolA) {
    //引数xのプロパティやメソッドのうちProtocolAで定義されているものが使用可能
    //x.variable
}



//プロトコルコンポジション 複数のプロトコルの組み合わせ
protocol ProtocolB {
    var variable: Int { get }
}

protocol ProtocolC {
    var variable2: Int { get }
}

struct StructA: ProtocolB, ProtocolC {
    var variable: Int
    var variable2: Int
}

func someFunc(x: ProtocolB & ProtocolC) {
    x.variable + x.variable2
}

let a = StructA(variable: 2, variable2: 3)
someFunc(x: a) // 5



// プロトコルを構成する要素　プロトコルのプロパティは常にvarで宣言　letが使用できないのはストアドやコンピューテッドプロパティといった区別がないため
//ゲッタの実装
protocol ProtocolD {
    var id: Int { get }
}
// 変数のストアド
struct StructB: ProtocolD {
    var id: Int
}
// 定数のストアド
struct StructC: ProtocolD {
    let id: Int
}
//コンピューテッドプロパティ
struct StructD: ProtocolD {
    var id: Int {
        return 1
    }
}


//セッタの実装　セッタも必要な場合変数のストアドプロパティを実装するかゲッタ、セッタの両方を持つコンピューテっどプロパティを実装する
protocol ProtocolE {
    var title: String { get set }
}
//変数のストアド
struct StructE: ProtocolE {
    var title: String
}
//コンピューテッド
struct StructF: ProtocolE {
    var title: String {
        get {
            return "title"
        }
        set {}
    }
}
//定数のストアド
// struct StructG: ProtocolE {
//    let title: Int　コンパイルエラー
//  }




//メソッド　プロトコルに準拠する型にメソッドの実装を要求できる
protocol MethodProtocol {
    func someMethod() -> Void
    static func someStaticMethod() -> Void
}

struct MethodStruct: MethodProtocol {

    func someMethod() {}
    static func someStaticMethod() {}
}



//mutating　値型のインスタンスの変更を宣言するキーワード
protocol Mutating {
    mutating func someMutatingMethod()
    func someMethod()
}

//構造体
struct StructH: Mutating {
    var num: Int

    mutating func someMutatingMethod() {
        // StructHの値を変更する処理を入れることができる
        num = 1
    }
    func someMethod() {
        //スコープ内の値を変更できない
        //        num = 1 コンパイルエラー
    }
}

//クラス
class SomeClass2: Mutating {
    var num = 0

    //参照型であるクラスではmutatingは不要
    func someMutatingMethod() {
        num = 1
    }
    func someMethod() {
        num = 1
    }
}



// 連想型　準拠時に指定可能な型　連想型の実際の型は準拠する型の方で指定します。連想型を使用すれば1つの型に依存しない抽象的なプロトコルを定義できる
protocol nameOfProtocol {
    associatedtype Renso_kata_name

    var propaty: Renso_kata_name { get }
    func method(x: Renso_kata_name)
    func method2() -> Renso_kata_name
}



protocol ProtocolI {
    associatedtype Associatedtype

    //連想型はプロパティやメソッドも可
    var value: Associatedtype { get }
    func someMethod(value: Associatedtype) -> Associatedtype
}

// AssociatedTypeを定義することで要求を満たす
struct StructG: ProtocolI {
    typealias Associatedtype = Int

    var value: Associatedtype
    func someMethod(value: Associatedtype) -> Associatedtype {
        return 1
    }
}

//実装からAssociatedTypeが自動的に決定する
struct StructI : ProtocolI {
    var value: Int
    func someMethod(value: Int) -> Int {
        return 1
    }
}

//ネスト型AssociatedTypeを定義することで要求を満たす ???
//struct StructJ: ProtocolI {
//    struct AssociatedType {}
//
//    var value: Associatedtype
//    func someMethod(value: Associatedtype) -> Associatedtype {
//        return Associatedtype()
//    }
//}



//ランダムな値を生成するという性質を表現　返却する値の型は連想型value
protocol RandomValueGenerator {
    associatedtype Value

    func randomValue() -> Value
}

struct IntegerRandomValueGenerator: RandomValueGenerator {
    func randomValue() -> Int {
        return Int.random(in: Int.min...Int.max)
    }
}

struct StringRandomValueGenerator: RandomValueGenerator {
    func randomValue() -> String {
        let letters = "abcdefghi"
        let offset = Int.random(in: 0..<letters.count)
        let index = letters.index(letters.startIndex, offsetBy: offset)
        return String(letters[index])
    }
}
//このように連想型を利用すれば1つの型に依存しない抽象的な性質を定義できる
let intRandom = IntegerRandomValueGenerator()
let strRandom = StringRandomValueGenerator()

let int = intRandom.randomValue()
let str = strRandom.randomValue()



//型制約の追加　準拠、継承すべきプロトコル、クラスに制約を設けることができる
protocol NameOfProtocol {
    associatedtype Renso_kata_name: SomeProtocol
}



//SomeClass型を継承していなければならないという制約を設ける
class ClassA {}

protocol ProtocolK {
    associatedtype AssociatedType: ClassA
}

class ClassB: ClassA {}

//ClassBはClassAのサブクラスなのでAssociatedTypeの制約を満たす
struct ConformedStruct: ProtocolK {
    typealias AssociatedType = ClassB
}

//IntはClassAのサブクラスではないのでコンパイルエラー
// struct NonConformedStruct: ProtocolK {
//    typealias AssociatedType = Int
// }



//プロトコル名につづけてwhereを追加するとより詳細な制約を指定できる
//SomeDataプロトコルの連想型ValueContainerの連想型ContentがEquatableプロトコルに準拠するという制約を設けている
protocol Container {
    associatedtype Content
}

protocol SomeData {
    associatedtype ValueContainer: Container where
    ValueContainer.Content: Equatable
}



//また:によるプロトコルへの準拠やクラスの継承の制約に加えて==による型の一致の制約も設定できる
//SomeDataプロトコルの連想型 ValueContainerの連想型ContentがInt型であるという制約を設けている
protocol Container2 {
    associatedtype Content2
}

protocol SomeData2 {
    associatedtype ValueContainer2: Container2 where
    ValueContainer2.Content2 == Int
}



//型制約を複数指定　SomeData3が連想型ValueContainer3の連想型Content3がEquatableに準拠、かつ連想型のValueと一致する制約
protocol Container3 {
    associatedtype Content3
}

protocol SomeData3 {
    associatedtype Value
    associatedtype ValueContainer: Container3 where
    ValueContainer.Content3: Equatable, ValueContainer.Content3 == Value
}



//デフォルトの型の指定　プロトコルの連想型には宣言と同時にデフォルトの型を指定できる
protocol ProtocolL {
    associatedtype AssociatedType = Int
}

//AsociattedTypeを定義しなくてもProtcolLに準拠できる
struct StructL: ProtocolL {
    //StructL.AsociattedTypeはIntとなる
}



//プロトコルの継承　クラスのオーバーライドのような概念はない
protocol Protocol1: ProtocolA, ProtocolB {
    //プロトコルの定義
}

protocol Protocol2 {
    var id: Int { get }
}

protocol Protocol3 {
    var title: String { get }
}
// protocol4はid titleの2つを要求するプロトコル
protocol Protocol4: Protocol2, Protocol3 {}

class test: Protocol4 {
    var id: Int
    var title: String

    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}


//クラス専用プロトコル　準拠する型をクラスのみに限定できる
protocol someClassOnly: class {}



//プロトコルエクステンション
extension ProtocolA {
    //対象のプロトコルに実装する要素
}

protocol Items {
    var name: String { get }
    var category: String { get }
}

extension Items {
    var description: String {
        return "商品名: \(name),　カテゴリ: \(category)"
    }
}

struct Book: Items {
    let name: String
    var category: String {
        return "書籍"
    }
}

let book = Book(name: "Swift実践入門")
print(book.description)  //商品名: Swift実践入門,　カテゴリ: 書籍



//デフォルト実装による実装の任意化
protocol Item2 {
    var name: String { get }
    var caution: String? { get }
}

extension Item2 {
    var caution: String? {  //extensionでデフォルト実装
        return nil
    }

    var description: String {
        var decription = "商品名: \(name)"
        if let caution = caution {
            decription += ",注意事項 :\(caution)"
        }
        return decription
    }
}

struct Book2: Item2 {
    let name: String
}

struct Fish: Item2 {
    let name: String

    var caution: String? {
        return "クール便での配送となります"
    }
}

let book2 = Book2(name: "Swift実践入門")
print(book.description)  // 商品名: Swift実践入門,　カテゴリ: 書籍

let fish = Fish(name: "さんま")
print(fish.description) // 商品名: さんま,注意事項 :クール便での配送となります



//型制約の追加　プロトコルエクステンションでwhere節内に記述
extension Collection where Element == Int {
    var sum: Int {
        return reduce(0) { return $0 + $1 }
    }
}

let integ = [1, 2, 3]
integ.sum  // 6

let strin = ["a", "b", "c"]
//strin.sum コンパイルエラー


