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
}

let registerdUser = RegisterdUser(id: 1, name: "Yosuke Ishikawa")
let id = registerdUser.id
let message = registerdUser.message
registerdUser.printProfile()

