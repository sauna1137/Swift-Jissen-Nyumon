//
//  HomeModel.swift
//  Swift Jissen Nyumon
//
//  Created by KS on 2021/11/23.
//

import Foundation

class HomeModel {

    static let homeTableViewTitlesArray = ["変数と定数と式", "基本的な型","コレクションを表す型"]

    static let contentsArray = [

    """
    let a = 123 \n type(of: a) // Int.Type
    クロージャ { 引数 in 戻り値を返す式 }
    let array = [1,2,3] \n let doubled = original.map({ value in value * 2 })\n doubled // [2,4,6]
    let a = 7 -a = -7\n let a = false !a = true \n\n String(4)もStringという関数にint型の4を渡して\"4\"を受け取る"
    """

    ,

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
    """

    ]


}
