//
//  HomeModel.swift
//  Swift Jissen Nyumon
//
//  Created by KS on 2021/11/23.
//

import Foundation

class HomeModel {

    static let homeTableViewTitlesArray = ["変数と定数と式", "基本的な型","コレクションを表す型","制御構文"]

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


           """


    ]


    func forText() {



    }
}
