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



//muatingキーワード　地震の値の変更を宣言するキーワード
// mutating func メソッド名(引数) -> 戻り値型 {
//    メソッド呼び出し実行文
// }
