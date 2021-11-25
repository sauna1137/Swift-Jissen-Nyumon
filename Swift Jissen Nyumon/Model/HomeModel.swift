//
//  HomeModel.swift
//  Swift Jissen Nyumon
//
//  Created by KS on 2021/11/23.
//

import Foundation

class HomeModel {

    static let homeTableViewTitlesArray = ["変数と定数と式", "基本的な型"]

    static let DetailVCTextViewsArray = ["let a = 123 \n type(of: a) // Int.Type \n クロージャ { 引数 in 戻り値を返す式 }　\n\n let array = [1,2,3] \n let doubled = original.map({ value in value * 2 })\n doubled // [2,4,6] \n\n let a = 7 -a = -7\n let a = false !a = true \n\n String(4)もStringという関数にint型の4を渡して\"4\"を受け取る", "Optional<Int>はInt?と記入できる \n Oprional<Wrapped>型の2つのケース\n enum Optional<Wrapped> { \n case none\n case some(Wrapped)\n } 値が存在しない時は Optional<Wrapped>.none 値がある場合は Optional<Wrapped>.someとなる\n "]

    func playGround() {

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
            // dがnilなら
        } else {
            
        }




    }

}
