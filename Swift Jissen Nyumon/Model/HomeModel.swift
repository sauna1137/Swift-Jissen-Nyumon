//
//  HomeModel.swift
//  Swift Jissen Nyumon
//
//  Created by KS on 2021/11/23.
//

import Foundation

class HomeModel {

    static let homeTableViewTitlesArray = ["変数と定数と式", "基本的な型","コレクションを表す型","制御構文","関数とクロージャ","型の構成要素","型の種類","プロトコル","型の設計指針","イベント通知","非同期処理","エラー処理"]

    static let contentsArray = [

        // MARK: - 変数と定数と式
    """
    let a = 123 \n type(of: a) // Int.Type
    クロージャ { 引数 in 戻り値を返す式 }
    let array = [1,2,3] \n let doubled = original.map({ value in value * 2 })\n doubled // [2,4,6]
    let a = 7 -a = -7\n let a = false !a = true \n\n String(4)もStringという関数にint型の4を渡して\"4\"を受け取る"
    """

    ,

    // MARK: - 基本的な型
            """
            // 基本的な型
            let none = Optional<Int>.none
            print(".none", none as Any) // nil

            let some = Optional<Int>.some(7)
            print("some",some as Any) // Optional(7)

            // Optional<Wrapped>型の値の生成
            var a: Int?
            a = nil // nilリテラルの代入による.noneの生成
            a = Optional(1) // イニシャライザによる.someの生成
            a = 1 // 値の代入による.someの生成

            let d: Int? = 1
            let e: Int? = 2
            //        let f = d + e  これはコンパイルエラーなのでアンラップしないと使用できない　そこで下記3種のアンラップ法がある

            // オプショナルバインディング
            if let newD = d {
                print(newD)
                // dがnilの処理
            } else {
            }

            // ??演算子
            let optionalInt: Int? = 1
            let int = optionalInt ?? 3 // 結果1

            let optionalInt2: Int? = nil
            let int2 = optionalInt ?? 3 // 結果3

            // オプショナルチェイン
            let optionalDouble = Optional(3.0) //3.0
            let optionalIsInfinite: Bool?

            if let double = optionalDouble {
                optionalIsInfinite = double.isInfinite
            } else {
                optionalIsInfinite = nil
            }


            // map
            let f = Optional(17)
            let g = a.map { Value in Value * 2 } //34
            type(of: g) // Optional<Int>.Type

            let h = Optional(17)
            let i = h.map { Value in String(Value) } //"17"


            //可能な限りAny型への代入は避ける　型の情報が保たれない

            //タプル型 インデックス、要素名、代入による3つのアクセスがある
            var tuple: (Int,String)
            tuple = (1,"abc")

            //インデックスによるアクセス
            let int3 = tuple.0
            let string = tuple.1

            //要素名によるアクセス
            let tuple2 = (int: 1, string: "abc")
            let int4 = tuple2.int  // 1
            let string2 = tuple2.string  // "abc"

            //代入によるアクセス
            let int5: Int
            let string3: String
            (int5, string3) = (1,"a")

            //Void型　要素の方が0個のタプル型をVoid型と言います。Void型は値が存在し得ないことを表す型
            //nilリテラルも値が存在しない事を表すがnilはあくまでも値が存在し得る場所で値がないことを示すもの。その場所に値が存在し得ないことを表すVoid型とは根本的に異なる

            //型のキャストとは値の方を確認し可能であれば別の型として扱う操作
            //アップキャストはStringからAny型などより抽象的な型への変換
            let any = "abc" as Any
            let int5 = "abc" as Int //String型はInt型を継承していないためエラー
            let any2: Any = "abc" //String型からAny型への暗黙的なアップキャスト

            //ダウンキャスト　抽象的な上位の型から具体的な下位の型として扱う操作
            //ダウンキャストにはas? as!演算子を使用する
            //as?演算子は左辺の値を右辺の型の値へダウンキャストし、失敗した場合はnilを返す
            let any3 = 3 as Any
            let int6 = any as! Int
            let string4 = any as! String //実行時エラー
            //失敗しないことが保証できるときなどでas!演算子が役立つこともあるが基本的には安全なas?を使うべき

            //型の判定
            let a: Any = 1
            let isInt = a is Int //true

            //値の比較のためのプロトコル
            //プロトコルとはそれに準拠する型が持つべき性質を定義したもの。IntやString型は異なる型だが同一の型同士なら==や＜を使って比較できるという共通の性質がある。これは
            //Int型とString型がEquatableプロトコルとしてComparableプロトコルという共通のプロトコルに準拠することで実現している
            //Any型はEquatableに準拠していないため比較できない
            //Comparableプロトコルは大小関係を検証するためのプロトコル。Int,Float,Double,Stringは準拠しているがBool,Anyは準拠していない。
            """,


    // MARK: - コレクションを表す型
        """
        //配列
        var strings = ["abc","123","def"]
        let strings1 = strings[0] // "abc"
        let strings3 = strings[2] // "def"

        strings[3] = "456"
        //strings = ["abc","123","def","456"]

        var integers = [1,2,3]
        integers.append(4) // [1,2,3,4]
        integers.insert(0, at: 0) // [0,1,2,3,4]

        integers.remove(at: 2) // [0,1,3,4]
        integers.removeLast() // [0,1,3]
        integers.removeAll() // []

        //辞書型
        let dicrionaly = ["a": 1, "b": 2] // [String: Int]型
        let dic: [String: Int] = [:]

        // valueに配列を入れる[String: [Int]]とすることも、[Stiring: [String: Int]]とすることもできる
        let dic2 = ["even": [2,4,6,8], "odd": [1,3,5,7]]

        dic2["even"] != nil // true
        dic2["oodd"] != nil // false

        //　更新
        var dic3 = ["key": 1]
        dic3["key"] = 2
        dic3 // ["key": 2]

        // 追加
        var dic4 = ["key": 1]
        dic4["key2"] = 2
        dic4 // ["key": 1,"key2": 2]

        //削除
        var dic5 = ["key": 1]
        dic5["key"] = nil
        dic5 // [:]

        //範囲型
        let range = 1..<4 // CountableRange(1..<4)

        for value in range {
            print(value) // 1 2 3
        }

        let range2 = 1...4 // CountableClosedRange(1...4)

        for value in range {
            print(value) // 1 2 3 4
        }

        let floatRange: Range<Float> = 1..<3 //Range<Float型>
        floatRange.upperBound // 3
        floatRange.lowerBound // 1

        let rangeThrough = ...5.8
        rangeThrough.upperBound //5.8

        rangeThrough.contains(3.7) // true
        rangeThrough.contains(6.5) // false

        //Character型
        let string = "a" // String型
        let character: Character = "a" // Character型

        let string2 = "abc" // String型
        let startIndex = string.startIndex // String.Index型
        let endIndex = string.endIndex // String.Index型

        let string4 = "abc"
        let character2 = string[string.startIndex] // "a" (Character型)
        let bIndex = string4.index(string4.startIndex, offsetBy: 1)
        let b = string[bIndex] // "b"

        let cIndex = string4.index(string4.endIndex, offsetBy: -1)
        let c = string4[cIndex] // "c"

        //文字数のカウント
        string4.count

        //要素の列挙
        for character in string4 {
            print(character) // a b c
        }


        //Sequenceプロトコル　for-in文を用いてその要素に順次アクセスします　要素への順次アクセス

        // forEach(_:) 要素に対して順次アクセス
        let array = [1,2,3,4,5,6]
        var enumerated = [] as [Int]
        array.forEach { element in
            enumerated.append(element)
        }
        enumerated // [1,2,3,4,5,6]


        //filter(_:)　指定した条件を満たす要素のみ含み新しいシーケンスを返す　要素を絞り込む
        let filtered = array.filter { element in
            element % 2 == 0
        }
        filtered // [2,4,6]


        //map(_:) 要素を変換　全ての要素を特定の処理を用いて変換　要素を変換する処理は引数のクロージャを用いて指定する
        let doubled = array.map { element in
            element * 2
        }
        doubled // [2,4,6,8,10,12]

        let converted = array.map { element in
            String(element)
        }

        converted // ["1","2","3","4"...]


        //flatMap(_:) 要素をシーケンスに変換して一つのシーケンスに連結する
        let a = [1,4,7]
        let b2 = a.flatMap { value in
            [value, value + 1]
        }
        b2 // [1,2,4,5,7,8]
        //同じ処理をmapで行ったら   [[1,2],[4,5],[7,8]]


        //compactMap(_:) 要素を失敗する可能性のある処理を用いて変換する　変換できない値を無視できる
        let strings2 = ["abc", "123", "def", "456"]
        let integers2 = strings2.compactMap { value in
            Int(value)
        }
        integers2 // [123,456]


        //reduce(_:_:) 要素を一つにまとめる　第一引数に初期値を指定し、第二引数に要素を結果に反映する処理を指定します。
        let sum = array.reduce(0) { partialResult, element in
            partialResult + element
        }
        sum // 21    0に1,2,3,4,5,6を足していく

        let concat = array.reduce("") { partialResult, element in
            partialResult + String(element)
        }
        concat // "123456"

        """,

    // MARK: - 制御構文

            """

            // if let文　値の有無による分岐
            let optInt: Int? = 3
            let optStr: String? = "abc"

            if let constant = optInt {
                //　値が存在する場合に実行する分
                print(constant)
            } else {
                //　値が存在しない時に実行される文
            }

            if let a = optInt, let b = optStr {
                print("値はa,bです")
            } else {
                print("どちらかの値が存在しない")
            }


            // guard文　条件不成立時に早期退出する分岐
            guard optStr == "abc" else {
                //　条件式がfalseの場合に実行される文
                return
            }

            func printIntPositive(_ a: Int) {
                guard a > 0 else {
                    return // returnがないとコンパイルエラー
                }

                // guard文以降では　a > 0が保証される
                print(a)
            }

            printIntPositive(4) // 4
            // guard文、条件で早期退出するコードはguard文を実装した方がシンプルとなります。


            // switch文 複数のパターンマッチによる分岐
            let a = 1

            switch a {
            case Int.min..<0:
                print("aは負の値")
            case 1..<Int.max:
                print("aは世の値")
            default:
                print("aは0です")
            }

            //ケースの網羅性チェック
            enum SomeEnum {
                case foo
                case bar
                case baz
            }

            let foo = SomeEnum.foo

            switch foo {
            case .foo:
                print("foo")
            case .bar:
                print("bar")
            case .baz:
                print("baz")
            }

            let baz = SomeEnum.baz
            switch baz {
            case .foo:
                print("foo")
            case .bar:
                print("bar")
            default: print("Default")
            }

            //whereキーワード　ケースにマッチする条件を追加できます
            let optionalA: Int? = 1

            switch optionalA {
            case .some(let a) where a > 10:
                print("10より大きい値aが存在します")
            default: print("値が存在しない、若しくは10以下です")
            }

            let a3 = 1

            switch a3 {
            case 1:
                print("実行する")
                break
                print("実行されない") //breakで実行されない
            default: break
            }

            //ラベル名 switchが入れ子になっている場合などbreakの対象となるswitch文を明示する必要がある
            let value = 0 as Any

            outerSwitch: switch value {
            case let int as Int:
            let description: String
            switch int {
            case 1, 3, 5, 7, 9:
                description = "奇数"
            case 2, 4, 6, 8, 10:
                description = "偶数"
            default: print("対象外の数字です")
                break outerSwitch
            }
            print("値は")
            default: print("対象外の型です")
            }

            // fallthrough文　switch文のケース実行を終了し、次のケースを実行する制御構文 fallthroughキーワードのみで構成される
            let a4 = 1

            switch a4 {
            case 1:print("case 1")
                fallthrough
            case 2: print("case 2")
            default: print("default")
            }

            //実行結果　case 1 case 2


            //繰り返し
            let array = [1,2,3]
            for element in array {
                print(element)  // 1 2 3
            }

            let dictionary = ["a":1, "b": 2]
            for (key, value) in dictionary {
                print("key: , Value:") // key: b,value2  key: a, Value: 1
            }

            //while 継続条件による繰り返し
            var a5 = 1
            while a < 4 {
                print(a5) //1 2 3
                a5 += 1
            }

            // repeat-while文　初回実行を保証する繰り返し
            while a5 < 1 {
                print(a5) // printなし
                a5 += 1
            }

            repeat {
                print(a5) // 1 一回は必ず実行される
                a5 += 1
            } while a < 1


            // break文　繰り返しの終了
            var containsTwo = false
            let array2 = [1,2,3]

            for element in array {
                if element == 2 {
                    containsTwo = true
                    break
                }
                print("element")
            }
            print("containtsTwo:") // element:1 containsTwo: true

            // continue文　繰り返しの終了
            var odds = [Int]()
            let array3 = [1, 2, 3]

            for element in array3 {
                if element % 2 == 1 {
                    odds.append(element)
                    continue  // continueがあることで繰り返しに戻る、element % 2 == 1 でない時はcontinueが実行されないのでeven: 2が実行される
                }
                print("even: ")
            }
            print("odds:")

            // even: 2 odds: [1,3]

            //ラベル　breakやcontinue文の制御対象の指定
            label: for element in [1, 2, 3] {
            for nestedElement in [1 ,2, 3] {
                print("element: , nestedElement: ")
                break label
               }
            }

            //element: 1, nestedElement: 1

            //遅延実行 defer スコープ退出時の処理
            var count = 0

            func someFunc() -> Int {
                defer {
                    count += 1 //スコープ退出時に処理される
                }
                return count
            }

            someFunc() // 0
            print(count) // 1


            //パターンマッチ 値のもつ構造や性質を表現するパターンという概念がある。値が特定のパターンに合致するか検査することをパターンマッチという

            //式パターン 演算子による評価
            let integ = 9

            switch integ {
            case 6: print("match: 6")
            case 5...10: print("match5...10")
            default: print("default")
            }

            //バリューバインディングパターン 値の代入に伴う評価
            let val = 3

            switch val {
            case let matchVal: print(matchVal) // 3
            }


            // オプショナルパターン　Optional<Wrapped>型の値の有無を評価
            let optA = Optional(4)

            switch optA {
            case let a?: print(a) // 4
            default: print("nil")
            }


            // 列挙型ケースパターン ケースとの一致の評価
            enum Hemisphere {
                case northern
                case southern
            }

            let hemisphere = Hemisphere.northern

            switch hemisphere {
            case .northern: print("match .nor") // match .nor
            case .southern: print("match .sou")
            }

            enum Color {
                case rgb(Int, Int, Int)
                case cmyk(Int, Int, Int, Int)
            }

            let color = Color.rgb(100, 200, 255)

            switch color {
            case .rgb(let r, let g, let b): print(".rgb r g b") //.rgb 100 200 255
            case .cmyk(let c, let m, let y, let k): print("cmyk")
            }


            // is演算子による型キャスティングパターン　型の判定による評価
            let any: Any = 1
            switch any {
            case is String: print("match: String")
            case is Int: print("match: Int") // match Int
            default: print("default")
            }


            // as演算子による型キャスティングパターン
            let any2: Any = 1

            switch any2 {
            case let string as String: print("match String")
            case let int as Int: print("match Int")
            default: print("default")
            }


            // if文
            let val2 = 8
            if case 1...10 = val2 {
                print("1...10の値です")
            }

            // guard文
            func someFunc2() {
                let val: Int = 9
                guard case 1...10 = val else {
                    return
                }
                print("1~10の値です")
            }


            // for in文
            let array6 = [1,2,3,4]
            for case 2...3 in array {
                print("2~3の値")
            }
            //2~3の値 2~3の値　2回出力

            // while
            var nextVal = Optional(1)
            while case let value? = nextVal {  // nextValがnilにならない(nextValが3を超えない)間は value1 ,2 , 3と出力
                print("val")

                if value >= 3 {
                    nextVal = nil
                } else {
                    nextVal = value + 1
                }
            }


           """,

"""

//関数とクロージャ　関数はクロージャの一種で共通の仕様が多くある

//関数　入力として引数、出力として戻り値を持つ、名前を持ったひとまとまりの処理
func double(_ x: Int) -> Int {
    return x * 2
}

double(3) // 6

// 戻り値が不要な場合_に代入することで明示できるがエラーとなるので＠discardableResult属性を付与する
@discardableResult
func functionWithDiscaradable() -> String {
    return "discardable"
}

_ = functionWithDiscaradable()

//外部引数名を省略したい場合
func sum(_ int1: Int, _ int2: Int) -> Int {
    return int1 + int2
}
let result = sum(1, 3) // 4


//外部引数あり
func sum2(int1: Int, int2: Int) -> Int {
    return int1 + int2
}
let result2 = sum2(int1: 1, int2: 3) // 4


//デフォルト引数
func greet(user: String = "Anonymous") {
    print("Hello, user!")
}
greet() // Hello,Anonymous!
greet(user: "tanaka") // Hello,tanaka!


//必要のない引数はデフォルト引数で指定し、引数を渡さなくても処理できる
func search(byQuery query: String, sortKey: String = "id", ascending: Bool = false) -> [Int] {
    return [1,2,3]
}
search(byQuery: "query") // [1,2,3]
search(byQuery: "query", sortKey: "name", ascending: true) // [1,2,3]


//インアウト引数  関数の実行後に関数内で処理した変数への変更が関数外の変数へ反映される
func greet2(user: inout String) {
    if user.isEmpty {
        user = "Anonymous"
    }
    print("Hello,user!!")
}
var userA: String = ""
greet2(user: &userA) //Hello,Anonymous!!
print(userA) // Anonymous


//　可変長引数　引数にString...とすることで引数を任意に追加できる
func printString(strings: String...) {
    if strings.count == 0 {
        return
    }

    print("firest strings[0]")
    for string in strings {
        print("element: string")
    }
}

printString(strings: "abc","2","afafa") // first abcelement: abc element: 2 element: afafa


// 暗黙的なreturn　 1行だけならreturnを省略できる
func makeMessage(toUser user: String) -> String {
    "hello, user"
}
print(makeMessage(toUser: "aa")) // hello, aa

func makeMessage2(toUser user: String) -> String {
    print(user)
    //    "hello,user"  コンパイルエラー
    return "aaa"
}


//クロージャ　スコープ内の変数や定数を保持したひとまとまりの処理
let double2 = { (x: Int) -> Int in
    return x * 2
}
double2(3) // 6

let closure: (Int) -> Int
func someFunc(x: (Int) -> Int) {}


//型推論 クロージャの引数と戻り値の方宣言はクロージャの代入先の方から推論することで省略できる
var closure2: (String) -> Int

//引数、戻り値の型を明示
closure2 = { (String: String) -> Int in
    return String.count
}
closure2("fsdfa") // 5

//省略した場合
closure2 = { String in
    return String.count
}
closure2("fda") // 3


//クロージャは外部引数名とデフォルト引数を使用できないが簡略引数名を使用できる
//簡略引数名 $に引数のインデックスをつけた$0,$1などです　可読性の低いコードになりがちだがシンプルな処理を行う場合には積極的に利用すべき
let isEqual: (Int,Int) -> Bool = {
    return $0 == $1
}
isEqual(2,2) // true
isEqual(1,2) // false


//戻り値がない関数を定義できるようにクロージャも定義できる
let emptyReturn: () -> Void = {}
let singleReturn: () -> Int = {
    return 1
}


//クロージャによる変数と定数のキャプチャ クロージャが参照している変数や定数はクロージャが実行されるスコープが変数や定数が定義されたスコープ外であっても
//クロージャの実行時に利用できる。 クロージャ自身が定義されたスコープの変数や定数への参照を保持しているため。この機能をキャプチャという
let greeting: (String) -> String
do {
    let symbol = "!"
    greeting = { user in
        return "hello, usersymbol"
    }
}
greeting("ishikawa") //hello,Ishikawa!
//symbol コンパイルエラー

//定数greetingはdo文のスコープ外で宣言されているためdo文外からも利用できるが定数symbolはdo内で宣言されているためdo外では使用できない
//しかし定数greetingに代入されたクロージャは内部でsymbolを利用しているにも関わらずdo文外で実行できている。これはクロージャがキャプチャによって
//自身が定義されたスコープ変数や定数への参照を保持することで実現される。キャプチャの対象は変数、定数の値ではなく、その変数や定数自身。
//キャプチャされている変数への変更はクロージャの実行時にも反映される

let counter: () -> Int
do {
    var count = 0
    counter = {
        count += 1
        return count
    }
}
//count += 1 スコープ外
counter() // 1
counter() // 2


//引数としてのクロージャ　クロージャを関数や別のクロージャの引数として利用する場合のみ有効な使用として属性とトレイリングクロージャがある
//属性はクロージャに対して指定する追加情報　トレイリングクロージャはクロージャを引数にとる関数の可読性を高めるための仕様

//func 関数名(引数名: @属性名 クロージャの型名) {
//関数呼び出し時に実行する文
//}

// or(_:_:)関数の第二引数の方はautoclosure属性のクロージャ
func or (_ lhs: Bool, _ rhs: @autoclosure () -> Bool) -> Bool {
    if lhs {
        return true
    } else {
        return rhs()
    }
}
or(true,false) // true

//escaping属性 非同期的に実行されるクロージャ 関数に引数として渡されたクロージャが関数のスコープ外で保持される可能性があることを示す属性
//コンパイラはescaping属性の有無によってクロージャがキャプチャを行う必要があるかを判別する。
//クロージャが関数のスコープ外で保持される可能性がある場合、つまりescaping属性が必要な場合はクロージャの実行時まで関数のスコープの変数を保持する必要があるためキャプチャが必要となる

var queue = [() -> Void]() //引数,戻り値なしの関数の配列
func enqueue(operation: @escaping () -> Void) {   //operationという引数名でescaping属性を持った引数,戻り値なしのクロージャ
    queue.append(operation) //queue(引数,戻り値なしの関数の配列)にoperationを足す
}

enqueue { print("excuted1") } // enqueueという関数にprint("excuted")という引数、戻り値なしの処理を渡して実行 queueにprint("excuted")が追加される
enqueue { print("excuted2") } //　同上の処理  print("excuted")はescapingにより関数のスコープ外で保持される
print(queue) // [(Function), (Function)]

queue.forEach { $0() } //引数なしの戻り値なしの配列の0番目の処理をそれぞれ実行 　結果: excuted1 excuted2


//escaping属性が指定されていないクロージャは関数のスコープ外で保持できない クロージャの実行は関数のスコープ内で行わなければならない
//executeTwiceに渡されたクロージャは関数のスコープ内でのみ実行されるためコンパイルエラーにならない
func executeTwice(operation: () -> Void) {
    operation()
    operation()
}
executeTwice { print("excuted") }


//autoclosure属性　クロージャを用いた遅延評価
func or2(_ lhs: Bool, _ rhs: @autoclosure () -> Bool) -> Bool {
    if lhs {
        return true
    } else {
        return rhs()
    }
}
or2(true,false) // true

func or3(_ lhs: Bool, _ rhs: Bool) -> Bool {
    if lhs {
        print("true")
        return true
    } else {
        print(rhs)
        return rhs
    }
}

func lhs() -> Bool {
    print("lhs実行")
    return true
}

func rhs() -> Bool {
    print("rhs実行")
    return false
}

or3(lhs(), rhs()) //lhs実行　rhs実行 true
//出力結果から両方の関数が実行されていることがわかる　関数の引数がその関数に引き渡される前に実行されるため　これを正格評価という

//上のケースでは第二引数は実行される必要がない　第一引数がtrueであるとわかれば結果がtrueと決定できるから
//第二引数を実行しないように書き換える
func or4(_ lhs: Bool, _ rhs: () -> Bool) -> Bool {
    if lhs {
        print("true")
        return true
    } else {
        let rhs = rhs()
        print(rhs)
        return rhs
    }
}
or4(lhs(), { return rhs() })  // lhs実行　true
//結果のように不要な関数の呼び出しが行われていない 第二引数をクロージャにすることで必要になるまで評価を遅らせることができた これを遅延評価という
//しかし呼び出しがわが煩雑になるデメリットもある。メリットも享受してデメリットを回避するための属性が autoclosure
func or5(_ lhs: Bool, _ rhs: @autoclosure () -> Bool) -> Bool {
    if lhs {
        print("true")
        return true
    } else {
        let rhs = rhs()
        print(rhs)
        return rhs
    }
}
or5(lhs(), rhs()) // lhs実行　true
//このようにautoclosureを仕様すれば遅延評価を簡単に実現できる


//トレイリングクロージャ 引数のクロージャを()の外に記述する記法
//関数の最後の引数がクロージャの場合にクロージャを()の外に書くことができる記法
func execute(parameter: Int, handler: (String) -> Void) {
    handler("paramete is parameter")
}

//トレイリングクロージャを使用する場合
execute(parameter: 1, handler: { string in
    print(string)  //paramete is 1
})

//トレイリングクロージャを使用する場合
execute(parameter: 2) { string in
    print(string) // paramete is 2
}


//クロージャとしての関数　関数はクロージャの一種のためクロージャとして扱える　関数として扱うことで変数や定数に代入したり別の関数の引数に渡したりすることができる
// let 定数名 = 関数名
// let 定数名 = 関数名(引数名1: 引数名2:)
func double3(_ x: Int) -> Int {
    return x * 2
}
let function = double3  // functionの型は(Int) -> Intと推論される

let array1 = [1,2,3]
let doubleArray1 = array1.map { $0 * 2 }
doubleArray1 // [2,4,6]

//関数をクロージャとして扱うことで次のような処理が行える
func double4(_ x: Int) -> Int {
    return x * 2
}

let array2 = [1,2,3]
let doubleArray2 = array2.map(double4) // [2,4,6]


//クロージャ式を利用した変数や定数の初期化 3*3のマス目を表現する方を実装するとする
var board = [ [1,1,1], [1,1,1], [1,1,1] ]

var board2 = Array(repeating: Array(repeating: 1, count: 3), count: 3) // [ [1,1,1], [1,1,1], [1,1,1] ]

var board3: [[Int]] = {
    let sideLength = 3
    let row = Array(repeating: 1, count: sideLength)
    let board = Array(repeating: row, count: sideLength)
    return board  // [ [1,1,1], [1,1,1], [1,1,1] ]
}()

""",


"""
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
    print("to: (greeting2.to)")
    print("body: (greeting.body)")
    print("signature: (Greeting2.signature)")
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
            print("willSet: (to; (self.to), newValue: (newValue))")
        }

        didSet {
            print("didSet: (self.to)")
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
print("valueの値はsomeStruct2.value)")
print("lazyValueの値は(someStruct2.lazyValue)")

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
            return "Hello, (to)"  //ストアドプロパティを使用可能
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
        return "Hello,(to)!"
    }
}

let greeting7 = Greeting7()
greeting7.body //Hello,yusuke

struct Greeting8 {
    var to = "yusuke"
    var body: String {
        return "Hello,(to)!"
    }
}

let greeting = Greeting8()
//greeting7.body = "hi" 　セッタが定義されていないためコンパイルエラー



//イニシャライザ　　インスタンスを初期化する　引数と初期化に関する処理を定義
struct Greeting9 {
    let to: String
    var body: String {
        return "hello, (to)!"
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
        print("エラー: 辞書(dictionary)からItemを生成できませんでした")
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



//インスタンスメソッド　型のインスタンスに紐付いたメソッド
struct SomeStruct3 {
    var value = 0

    func printValue() {
        print("value: (self.value)")
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
        signature = "sent from (deviceName)"
    }

    var to = "Yosuke Ishikawa"
    var body: String {
        return "Hello,(to) \n (Greeting10.signature)"
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
        print("string: (value)")
    }

    func put(_ value: Int) {
        print("int: (value)")
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
        return "[(self)]"
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
    let item = NewsFeedItem2(id: 1, title: "Table", kind: kind)

switch item.kind {
case .a: print("a")
case .b: print("b")
case .c: print("c")
}    //　結果　a

""",

"""

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
        print("id: (id)")
        print("message: (message)")
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
        print("name (name)")
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
        self.init(from: from, to: to, title: "Hello,(from)")
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

""",


"""

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
        return "商品名: (name),　カテゴリ: (category)"
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
        var decription = "商品名: (name)"
        if let caution = caution {
            decription += ",注意事項 :(caution)"
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


""",

"""
//クラス、参照時に非同期処理で両方のインスタンスを参照しないようにする
class Temperature {
    var celsius: Double = 0
}

let temerature = Temperature()
temerature.celsius = 25

let dispatchQueue = DispatchQueue.global(qos: .default)
dispatchQueue.async {
    temerature.celsius != 1
}
temerature.celsius = 1
temerature.celsius //　非同期の処理によって実行のタイミングによって結果が異なる



//インスタンスのライフサイクルに合わせて処理を実行する
var tempraryData: String?

class SomeClass {
    init() {
        print("Create a temporary data")
        tempraryData = "a temporary data"
    }

    deinit {
        print("Clean up the temporary data")
        tempraryData = nil
    }
}

var someClass: SomeClass? = SomeClass()
tempraryData // a temporary data

someClass = nil
tempraryData // nil  deinitでファイルはデイニシャライザが実行され一時ファイルも削除される

// Create a temporary data
// Clean up the temporary data



// クラスの継承がもたらす期待しない挙動
protocol Ownable {
    var owner: String { get set }
}

protocol Animal {
    func sleep()
    func move()
}

extension Animal {
    func sleep() { print("sleeping") }
}

struct Dog: Animal, Ownable {
    var owner: String
    func move() { print("Prancing") }
}

struct Cat: Animal, Ownable {
    var owner: String
    func move() { print("Prancing") }
}

struct WildEagle: Animal {
    func move() { print("Flying") }
}



//クラスの継承を利用するべき時 複数の型の間でストアドプロパティの実装を共有する
class Animal2 {
    var owner: String? {
        didSet {
            guard let owner = owner else { return }
            print("(owner) was assigned as the owner")
        }
    }
}

class Dog2: Animal2 { }
class Cat2: Animal2 { }
class WildEagle2: Animal2 { }
let dog = Dog2()
dog.owner = "Yusei Nishiyama"
// Yusei Nishiyama was assigned as the owner


""",


"""

import UIKit
import PlaygroundSupport
import Dispatch

//イベント通知　UIタップやプロパティの値変更などアプリ内で発生するあらゆる事象をイベントという
//イベント通知のパターンにデリゲート、クロージャ、オブザーバ　パターン

//デリゲートパターン　別オブジェクトへの処理の移譲
//デリゲートパターンを利用するべき時　    二つのオブジェクト間で多くの種類のイベント通知を行うとき
protocol GameDelegate {
    var numberOfPlayers: Int { get }
    func gameDidStart(_ game: Game)
    func gameDidEnd(_ game: Game)
}

class TwoPersonsGameDelegate: GameDelegate {
    var numberOfPlayers: Int { return 2 }
    func gameDidStart(_ game: Game) { print("game start")}
    func gameDidEnd(_ game: Game) { print("game end") }
}

class Game {
    var delegate: GameDelegate?

    func start() {
        print("Number of players is (delegate?.numberOfPlayers ?? 1)")
        delegate?.gameDidStart(self)
        print("Playing")
        delegate?.gameDidEnd(self)
    }
}

let delegate = TwoPersonsGameDelegate()
let twoPersonsGame = Game()
twoPersonsGame.delegate = delegate
twoPersonsGame.start()

//　結果:
//  Number of players is 2
//  game start
//  Playing
//  game end


//デリゲート命名規則
//メソッド名はデリゲート元のオブジェクト名から始めて、イベントを説明する
//didやwillなどの助動詞を用いてイベントのタイミンングを示す
//第一引数にはデリゲート元のオブジェクトを渡す


//・弱参照による循環参照への対処
//ARCで参照カウントが0になった時にクラスのインスタンスのメモリが解放される
//クラスのインスタンスへの参照は強参照と弱参照がある。弱参照はARCでカウントアップしない
//weakとともにプロパティを宣言すると弱参照になる。弱参照は循環参照の解消に用いる
//循環参照は2つのインスタンスがお互い強参照を持ち合う状態で、この状態では参照カウントが0になることはあり得ない。
//メモリが確保されたままとなり解放されない問題全般はメモリリークと言う。




//クロージャ　別オブジェクトへのコールバック時の処理の登録
//利用するべき時　クロージャによるコールバックでは処理の実行とコールバック時の処理を同じ箇所に実装できる
//完了イベントだけを受け取れば良いといったシンプルなケースではクロージャを選択するべき
//コールバックの種類がいくつもあるケースではデリゲートパターンも検討する

class Game2 {
    private var result = 0

    func start(completion: (Int) -> Void) {
        print("Playing")
        result = 42
        completion(result)
    }
}

let game2 = Game2()
game2.start { result in
    print("Result is (result)")
}

// 結果
// Playing
// Result is 42


class Practice {
    func test(name: String, completion: (String) -> Void) {
        print("処理中")
        completion(name)
    }
}
let practice = Practice()
practice.test(name: "Taro") { name in
    print("(name)はテストに合格")
}



//キャプチャリスト　キャプチャ時の参照方法
//キャプチャとはクロージャが定義されたスコープに存在する変数や定数への参照をクロージャ内のスコープでも保持すること
//キャプチャはクラスのインスタンスへの強参照となる。クロージャが解放されない限りキャプチャされたクラスのインスタンスは解放されない

// Playgroundでの非同期実行をもつオプション
PlaygroundPage.current.needsIndefiniteExecution = true

class SomeClass {
    let id: Int

    init(id: Int) {
        self.id = id
    }

    deinit {
        print("deinit")
    }
}

do {
    let object = SomeClass(id: 42)
    let queue = DispatchQueue.main

    queue.asyncAfter(deadline: .now() + 3) {
        print(object.id)
    }
}

//　結果: 3秒後に表示
// 42
// deinit



//キャプチャリストを用いることで弱参照を持つこともできる
//クロージャの解放状況に依存せずにクラスのインスタンスの解放が行われる。
//キャプチャリストを定義するにはクロージャの引数の定義の前にweak,unownedを追加する。

class SomeClass2 {
    let id: Int

    init(id: Int) {
        self.id = id
    }
}

let object = SomeClass2(id: 37)
let object2 = SomeClass2(id: 38)

let closure = { [weak object, unowned object2] () -> Void in
    print(type(of: object))
    print(type(of: object2))
}

closure()
// 結果 :
// Optional<SomeClass2>
// SomeClass2




//weak メモリ解放を想定した弱参照
class SomeClass3 {
    let id: Int

    init(id: Int) {
        self.id = id
    }
}

do {
    let object2 = SomeClass3(id: 42)
    let closure = { [weak object2] () -> Void in
        if let some = object2 {
            print("objectはまた解放されていません、 id-> (some.id)")
        } else {
            print("objectは解放されました")
        }
    }

    print("ローカルスコープ内で実行: ", terminator: "")
    closure()

    let queue = DispatchQueue.main
    queue.asyncAfter(deadline: .now() + 1) {
        print("ローカルスコープ外で実行: ", terminator: "")
        closure()
    }
}

//　結果
// ローカルスコープ内で実行objectはまた解放されていません、 id-> 42
// ローカルスコープ外で実行objectは解放されました
//　ローカルスコープ実行中は定数objectの値はまだ解放されていません　ローカルスコープから抜けた1秒後では定数objectはnilとなり解放されています。




//unowned　メモリ解放を想定しない弱参照 weakと異なり参照先のインスタンスが既に解放されていてもunownedを指定してキャプチャした変数や定数の値はnilにならない
//一つ上の例をweak　から　unownedに置き換える
class SomeClass4 {
    let id: Int

    init(id: Int) {
        self.id = id
    }
}

//do {
//    let object4 = SomeClass4(id: 42)
//    let closure = { [unowned object4] () -> Void in
//        if let some = object4 {
//            print("objectはまた解放されていません、 id-> (some.id)")
//        } else {
//            print("objectは解放されました")
//        }
//    }
//
//    print("ローカルスコープ内で実行: ", terminator: "")
//    closure()
//
//    let queue = DispatchQueue.main
//    queue.asyncAfter(deadline: .now() + 1) {
//        print("ローカルスコープ外で実行: ", terminator: "")
//        closure() 実行時エラーとなる
//    }
//}




//キャプチャリストの使い分け　weak unowned
//循環参照を招かない参照
//クロージャの実行時にインスタンスが必ず存在すべき場合はキャプチャリストを使用しない
//クロージャの実行に参照するインスタンスが存在しなくても良い場合はweak キーワードを使用する

//循環参照を招く参照
//参照するインスタンスが先に解放される可能性がある場合はweakを使用する
//参照するインスタンスが先に解放される可能性がない場合はweak か　unownedを使用する
//より大きいプロジェクトではより安全なweakキーワードのメリットの方が大きい
//unownedを使用することでnilになることはないといる仕様を明確にできる




// typealiasによる複雑なクロージャ型へのエイリアス
//クロージャにも型があり型は引数と戻り値の型で決まる　Intを1つ受け取りString型を戻り値とするのは(Int) -> String
//引数に複雑な型のクロージャを取る関数の定義はかなり読みにくくなる
func someMethod(completion:(Int?, Error?, Array<String>?) -> Void) {} //型の理解に時間がかかる

//型エイリアスを設定した結果型の意味の理解が簡単になる
typealias CompletionHandler = (Int?, Error?, Array<String>?) -> Void
func someMethod2(completion: CompletionHandler) {}




//　オブザーバーパターン　状態変化の別オブジェクトへの通知
// デリゲートとクロージャを用いた方法は1on1のイベント通知で有効
//　1on複数 複数のオブジェクトへの通知にはオブザーバーが有効　一方で多用するとどのタイミングで通知が発生するか予想しづらくなり処理を追うのが難しくなる
//　利用するとき　1on複数のイベント通知が発生する場合、ユーザーがプロフィール更新で全ての画面を再描画する必要が生じる際に更新が必要な画面をオブザーバとして登録しておき更新のタイミングで登録された画面に通知を送り再描画を行う。

// Notification型とNotificationCenterクラスを用いる
// NotificationCenterクラスはサブジェクトである文字通り中央に位置するハブのような役割　このクラスを通じてオブジェクトは通知の送受信を行う
// オブザーバーはこのクラスに登録され通知を受け取るイベントと受け取る際に利用するメソッドを指定する　1つのイベントに対して複数のオブザーバを登録できる
// Notrification型はNotificationCenterクラスから発行される通知をカプセル化したもの

//通知を受け取るオブジェクトにNotification型の値を引数に持つメソッドを実装
//NotificationCenterクラスに通知を受け取るオブジェクトを登録する
//NotificationCenterクラスに通知を投稿する


//通知を発生させるPoster型
class Poster {
    static let notificationName = Notification.Name("SomeNotification")

    // 通知の投稿はpostメソッドを用い通知の名前、通知を送るオブジェクト(多くの場合は自分自身)を渡す
    // メソッド内でSomeNortificationという名前の通知を投稿
    func post() {
        NotificationCenter.default.post(name: Poster.notificationName, object: nil)
    }
}

//通知を受け取るObserver型 SomeNotificationという名前の通知のやりとりをする
class Observer {

    // NotificationCenterクラスへの登録はsddObserverを用い、通知を受け取るオブジェクト、通知を受け取るメソッド、受け取りたい通知の名前を登録
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: Poster.notificationName, object: nil)
    }

    // オブザーバーが破棄されるタイミングで通知をやめる処理を明示的に記述する
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // Notification型の値を引数に持つメソッド
    @objc func handleNotification(_ notification: Notification) {
        print("通知を受け取りました")
    }
}

//　PosterとObserver型の値をインスタンス化
var observer = Observer()
let poster = Poster()

//　Poster型のpost()を呼ぶとサブジェクトであるNotificationCenterクラスを通じてSomeNotificationという名前の通知が発行される
// Observer型はこの通知をhandleNotificationメソッドで受け取り"通知を受け取りました"というメッセージを出力
poster.post()




// selector型 メソッドを参照するための型
// Selector型とはObjective-Cのセレクタという概念を表現。セレクタはメソッドの名前を表す型でメソッドをそれが属する方とは切り離して扱うことができる。#selectorに参照したいメソッド名を渡すことでSelector型の値を生成できる。setter,getteを記述することでセッタやゲッタのセレクタを取得できスコープ内のメソッドを参照する場合は型名を省略できる

// #selector(型名.メソッド名)
// #selector(setter: 型名.プロパティ名)



""",


"""

import UIKit
import Dispatch
import PlaygroundSupport

let queue = DispatchQueue.main // メインディスパッチキューを取得
// iOSやmacOS向けのアプリケーションではユーザーインターフェースの更新は常にメインキューで実行される

// userInteractive　アニメーションの実行などユーザーからの入力に対してインタラクティブに実行される。即時に実行されなければフリーズしているように見える処理に用いる

// userInitiated UIをタップした場合などユーザーからの入力を受けて実行される処理に用いる
// default QoSが何も指定されていない場合に利用される
// utility プログレスバー付きのダウンロードなど視覚的な情報の更新を伴いながらも即時の結果を要求しない処理
// background バックアップなど目に見えない所で行われて数分から数時間かかっても問題ない処理

public enum QoSClass {
    case background
    case utility
    case userInitiated
    case userInteractive
}

let queue2 = DispatchQueue.global(qos: .userInteractive)


PlaygroundPage.current.needsIndefiniteExecution = true
let queue3 = DispatchQueue.global(qos: .userInteractive)
queue3.async {
    Thread.isMainThread // false
    print("非同期の処理")
}

let queue4 = DispatchQueue.global(qos: .userInitiated)
queue4.async {
    Thread.isMainThread // false
    print("非同期の処理2")
    let queue5 = DispatchQueue.main
    queue5.async {
        Thread.isMainThread  // true
        print("メインスレッドでの処理")
    }
}


class SomeOperation: Operation {
    let number: Int
    init(number: Int) { self.number = number }
    override func main() {
        // 1秒まつ
        Thread.sleep(forTimeInterval: 1)
        print(number)
    }
}

let queue6 = OperationQueue()
queue6.name = "com.example.my_operation_queue"
queue6.maxConcurrentOperationCount = 2
queue6.qualityOfService = .userInitiated

var operations = [SomeOperation]()

for i in 0..<10 {
    operations.append(SomeOperation(number: i))
}

queue6.addOperations(operations, waitUntilFinished: false)
print("operations are added")


func runAsynchronousTask(handler: @escaping (Int) -> Void) {
    let globalQueue = DispatchQueue.global()
    globalQueue.async {
        let result = Array(0...100000).reduce(0, +)

        let mainQueue = DispatchQueue.main
        mainQueue.async {
            handler(result)
        }
    }
}

runAsynchronousTask { result in
    print(result) // 5000050000
}

"""



    ]



}
