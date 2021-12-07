import UIKit

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
    print("to: \(greeting2.to)")
    print("body: \(greeting.body)")
    print("signature: \(Greeting2.signature)")
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
        print("willSet: (to; \(self.to), newValue: \(newValue))")
    }

    didSet {
        print("didSet: \(self.to)")
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
print("valueの値は\(someStruct2.value)")
print("lazyValueの値は\(someStruct2.lazyValue)")

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
            return "Hello, \(to)"  //ストアドプロパティを使用可能
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

//セッタの省略
