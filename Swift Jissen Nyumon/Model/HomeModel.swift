//
//  HomeModel.swift
//  Swift Jissen Nyumon
//
//  Created by KS on 2021/11/23.
//

import Foundation

class HomeModel {

    static let homeTableViewTitlesArray = ["変数と定数と式", "基本的な型","コレクションを表す型","制御構文","関数とクロージャ"]

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

"""


    ]


    func forText() {



    }
}
