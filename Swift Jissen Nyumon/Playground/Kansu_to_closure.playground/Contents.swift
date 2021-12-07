import UIKit

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
    print("Hello, \(user)!")
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
    print("Hello,\(user)!!")
}
var userA: String = ""
greet2(user: &userA) //Hello,Anonymous!!
print(userA) // Anonymous


//　可変長引数　引数にString...とすることで引数を任意に追加できる
func printString(strings: String...) {
    if strings.count == 0 {
        return
    }

    print("firest \(strings[0])")
    for string in strings {
        print("element: \(string)")
    }
}

printString(strings: "abc","2","afafa") // first abcelement: abc element: 2 element: afafa


// 暗黙的なreturn　 1行だけならreturnを省略できる
func makeMessage(toUser user: String) -> String {
    "hello, \(user)"
}
print(makeMessage(toUser: "aa")) // hello, aa

func makeMessage2(toUser user: String) -> String {
    print(user)
    //    "hello,\(user)"  コンパイルエラー
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
        return "hello, \(user)\(symbol)"
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
print(queue) // [(Function), (Function)] 関数の配列

queue.forEach { $0() } //引数,戻り値なしの配列の0番目の処理をそれぞれアクセス 　結果: excuted1 excuted2


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
    handler("paramete is \(parameter)")
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



