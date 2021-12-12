import UIKit

// ジェネリクスとは型をパラメータとして受け取ることで汎用的なプログラムを記述するための機能
func isEqual() -> Bool {
    return 1 == 1
}

func isEqual2(_ x: Int, _ y: Int) -> Bool {
    return x == y
}

isEqual() //true
isEqual2(1, 1) //true
//上記のメソッドでは整数同士のみの比較しか行えない

//下記メソッドはEquatableプロトコルに準拠するあらゆる型をの比較ができる
func isEqual3<T : Equatable>(_ x: T,_ y: T) -> Bool {
    return x == y
}

isEqual3("abc", "def") // false
isEqual3(1.0, 2.2) // false
isEqual3(false, false) // true



//ジェネリクスの基本　ジェネリクスの型安全性　定義方法
// func 関数名<型引数>(引数名: 型引数)　-> 戻り値の型 {
//    実行される文
// }



func someFunction<T, U>(x: T, y: U) -> U {
    let _: T = x //型アノテーションとして使用
    let _ = x //　型推論
    let _ = 1 as? T
    return y
}



//Contentは型引数
struct Container<Content> {
    let content: Content
}

//型引数がStringであることを明示する
let stringContainer = Container<String>(content: "abc") // Content<String>

// 型引数を型推論する
let intContainer = Container(content: 1) //Content<Int>

//　汎用性と型安全性の両立
func identity<T>(_ argument: T) -> T {
    return argument
}
let int = identity(1) // Int
let string = identity("abc") // Strin



//Any型とジェネリクスの比較
//　ジェネリクスを使った関数
func identityWithGenericValue<T>(_ argument: T) -> T {
    return argument
}
let genericInt = identityWithGenericValue(1)         // Int型
let genericString = identityWithGenericValue("abc")  // String型

// Any型を使った関数
func identityWithAnyValue(_ argument: Any) -> Any {
    return argument
}

let anyInt = identityWithAnyValue(1)  // Any型
let anyString = identityWithAnyValue("abc")  // Any型

if let int = anyInt as? Int {
    //ここでようやくInt型として扱えるようになる
    print("anyInt is \(int)")
} else {
    // Int型へのダウンキャストが失敗した場合を考慮する必要がある
    print("The type of anyInt is not Int")
}



//ジェネリック関数　型引数を持つ関数のことZX
//　func 関数名<型引数>(引数) -> 戻り値の型 {
//    関数呼び出し時に実行される文
//　}

func identity2<T>(_ x: T) -> T {
    return x
}
identity2(1) // 1
identity2("abc") // "abc"



//特殊化方法 ジェネリック関数の実行には特殊化が必要　特殊化するには引数から型推論によって型引数を決定する方法と戻り値から型推論によって型引数を決定する
func someFunc<T>(_ argument: T) -> T {
    return argument
}

let int2 = someFunc(1) // 1
let string2 = someFunc("a") //"a"

//引数から型推論による特殊化
func someFunc2<T>(_ argument1: T, _ argument2: T) {}
someFunc2(1, 2) // OK
someFunc2("a", "b") // OK
//someFunc(1,"abc")  コンパイルエラー



//戻り値から型推論による特殊化
func someFunc3<T>(_ any: Any) -> T? {
    return any as? T
}
let a: String? = someFunc3("abc") //Optional("abc")
let b: Int? = someFunc3(2) //Optional(3)
//let c = someFunc3(3) Tが決定できずコンパイルエラー




//型制約　型引数に対する制約　準拠すべきプロトコル等型引数に制約を設けることができる　より細かくコントロールできる

//スーパークラスや準拠するプロトコルに対する制約
func isEqual4<T: Equatable>(_ x: T, _ y: T) -> Bool {
    return x == y
}

isEqual4("abc", "def") //false

//連想型のスーパークラスや準拠するプロトコルに対する制約
func sorted<T: Collection>(_ argument: T) -> [T.Element] where T.Element: Comparable {
    return argument.sorted()
}

sorted([13,2,4,54,21]) //[2, 4, 13, 21, 54]


//型同士の一致を要求する制約
func concat<T: Collection, U: Collection>(_ argument1: T, _ argument2: U) -> [T.Element] where T.Element == U.Element {
    return Array(argument1) + Array(argument2)
}

let array = [1,2,3]
let set2 = Set([1,2,3])
let result = concat(array, set2) // [1, 2, 3, 3, 1, 2]




//ジェネリック型　型引数を持つクラス、構造体、列挙型のこと

//構造体
struct GenerictStruct<T> {
    var propery: T
}
//クラス
class GenericClass<T> {
    func someFunction(x: T) {}
}
//列挙型
enum GenericEnum<T> {
    case SomeCase(T)
}



//特殊化方法　ジェネリック型のインスタンス化やスタティックメソッドの実行には特殊化が必要
//型引数の指定による特殊化
struct Container2<Content> {
    var content: Content
}
let intContainer2 = Container2<Int>(content: 3)
let stringContainer2 = Container2<String>(content: "abc")

//型引数とイニシャライザの引数の方が一致しないのでコンパイルエラー
//let container2 = Container2<Int>(content: "abc")


//型推論による特殊化
struct Container3<Content> {
    var content: Content
}
let intCon = Container3(content: 3) //Container<Int>型
let strCon = Container3(content: "abc") //Container<String>型




//型制約　引数に対する制約
//型の定義で使用できる型制約
// struct 型名<型引数: プロトコルやスーパークラス> {
//    構造体の定義
// }

//ジェネリック型の制約付きエクステンション
//extension ジェネリック型名 where 型制約 {
//    制約を満たす場合に有効となるエクステンション
//}


//プロトコルへの条件付き準拠
// extension ジェネリック型名: 条件付き準拠するプロトコル名 where 型制約 {
//    制約を満たす場合に有効となるエクステンション
// }




