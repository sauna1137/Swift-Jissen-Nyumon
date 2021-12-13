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
        print("Number of players is \(delegate?.numberOfPlayers ?? 1)")
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
    print("Result is \(result)")
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
    print("\(name)はテストに合格")
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
            print("objectはまた解放されていません、 id-> \(some.id)")
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
//            print("objectはまた解放されていません、 id-> \(some.id)")
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

