import UIKit
import Foundation
import Darwin

// エラー処理
// エラー処理にはOptional<Wrapped>、Result<Success,Failure>型、do catch文によるエラー処理がある
// 想定外のエラーではfatalError(_:)関数によるものとアサーションによるものの2つがある


// Optional<Wrapped>型によるエラー処理
// 処理の結果をOptionalで表し値が存在すれば成功、存在しなければ失敗とみなす
// 値の有無だけで結果を十分に表せる時に使用　どのようなエラーが発生したのかを表現することはできない

struct User {
    let id: Int
    let name: String
    let email: String
}

func findUser(byID id: Int) -> User? {
    let users = [
        User(id: 1, name: "Yusei", email: "nisiyama@ex.com"),
        User(id: 2, name: "tanaka", email: "ishikawa@ex.com")
    ]

    for user in users {
        if user.id == id {
            return user
        }
    }
    return nil
}

// id 1 print("name \(user.name)")
// id 0 print("Error User not found")


let id = 1
if let user = findUser(byID: id) {
    print("name \(user.name)")
} else {
    print("Error User not found")
}



struct User2 {
    let id: Int
    let name: String
    let email: String

    init?(id: Int, name: String, email: String) {
        // @が含まれていて幾つに分けられるか
        let components = email.components(separatedBy: "@")
        guard components.count == 2 else {
            return nil
        }
        self.id = id
        self.name = name
        self.email = email
    }
}


if let user2 = User2(id: 0, name: "Yosuke", email: "ishikawa.ex.com") {
    print("Username \(user2.name)")
} else {
    print("Error Invalid data")
}
// 結果:　Error Invalid data




// Result<Success,Failure>型によるエラー処理
// 成功を結果の値で、失敗をエラーの詳細で表す　2つのケースを持つ列挙型
// 連想値を通じて失敗時のエラーの値を返す エラー時には必ずエラーの詳細を受け取ることができ詳細に応じてエラー処理の挙動をコントロールできる

//enum Result<Success, Failure> where Failure : Error {
//    case Success(Success) // .successの場合はSuccess型の連想値を持つ
//    case Failure(Failure) // .failureの場合はFailure型の連想値を持つ
//}


enum DatabaseError: Error {
    case entryNotFound
    case duplicatedEntry
    case invalidEntry(reason: String)
}

func findUser2(byID id: Int) -> Result<User, DatabaseError> {
    let users = [
        User(id: 1, name: "aichi", email: "aichi@ex.com"),
        User(id: 2, name: "akita", email: "akita@ex.com")
    ]

    for user in users {
        if user.id == id {
            return .success(user)
        }
    }
    return .failure(.entryNotFound)
}

let id2 = 0
let result = findUser2(byID: id2)

switch result {
case let .success(User): print(".success: \(User.name)")
case let .failure(error):
    switch error {
    case .entryNotFound: print(".failure: .entryNotFound")
    case .duplicatedEntry: print(".failure: .duplicatedEntry")
    case .invalidEntry(reason: let reason): print(".failure .invalidEntry(\(reason)")
    }
}
// 結果: .failure: .entryNotFound



// do-catch文
// do-catch文によるエラー処理ではエラーが発生する可能性のある処理をdo節内に記述
// catch節へプログラムの制御が移り、エラーの詳細情報にアクセスすることができる

do {
    // throw文によるエラーが発生する可能性のある処理
} catch {
    //　エラー処理
    // 定数errorを通じてエラー値にアクセス
}




struct SomeError: Error {}

do {
    throw SomeError()
    print("success")
} catch {
    print("failure: \(error)")
}

// 結果: failure: SomeError()




enum SomeError2: Error {
    case error1
    case error2(reason: String)
}

do {
    throw SomeError2.error2(reason: "何かがおかしい")
} catch SomeError2.error1 {
    print("error1")
} catch SomeError2.error2(let reason) {
    print("error2 \(reason)")
} catch {
    print("unknownError")
}

// 結果: error2 何かがおかしい



// Errorプロトコル エラー情報を表現するプロトコル
// throw分のエラーを表現する方はErrorプロトコルに準拠している必要がある
// Errorプロトコルに準拠する方は列挙型として定義することが一般的で網羅的に記述できる

enum DatabaseError2: Error {
    case entryNotFound
    case duplicatedEntry
    case invalidEntry
}

enum NetworkError: Error {
case timeout
case cancelled
}



// throwsキーワード throwsを追加するとdo-catchを用いずにthrow文によるエラーを発生させられる
// func 関数名(引数) throws -> 戻り値 {
//    throw 文によるエラーが発生する可能性のある処理
// }

enum OperationError: Error {
case overCapacity
}

// retrunの値がInt.maxの三分の一よりも大きいとキャパを超えるためエラーをはく
func triple(of int: Int) throws -> Int {
    guard int <= Int.max / 3 else {
        throw OperationError.overCapacity
    }
    return int * 3
}



// イニシャライザの引数ageが13~19でなければエラーを出しインスタンス化できなくする
enum AgeError: Error {
case outOfRange
}

struct Teenager {
    let age: Int

    init(age: Int) throws {
        guard case 13...19 = age else {
            throw AgeError.outOfRange
        }
        self.age = age
    }
}



// rethrows 関数やメソッドをrethrowsを指定して定義することで引数のクロージャが発せさせるエラーを関数の呼び出し元に伝播させることができる

struct SomeError3: Error {}

func rethorwingFunction(_ throwingClosure: () throws -> Void) rethrows {
    try throwingClosure()
}

do {
    try rethorwingFunction {
        throw SomeError()
    }
} catch {
    // 引数のクロージャが発生させるエラーを関数の呼び出し元で処理
    error // SomeError
}



// tryキーワード　エラーを発生させる可能性のある処理の実行
// throws指定された処理を呼び出すには try 関数名(引数)のように記述する
// do-catchのthrowsが指定された処理の内部でのみ使用できる

enum OperationError2: Error {
case overCapacity
}

func triple2(of int: Int) throws -> Int {
    guard int <= Int.max / 3 else {
        throw OperationError.overCapacity
    }
    return int * 3
}

let int = Int.max

do {
    let tripleOfInt = try triple(of: int)
    print("success \(tripleOfInt)")
} catch {
    print("Error \(error)")
}

// 結果: Error overCapacity



// try! キーワード エラーを無視した処理の実行
// 特定の場面では絶対にエラーが発生しないとわかっていてエラー処理を記述したくないケースに用いる
// 結果としてプログラム全体の信頼性は下がってしまうが実用性のある機能

let tripleInt = try! triple2(of: 30)



// try? エラーをOptional<Wrapped>型で表す処理
// do-catch文を省略でき、代わりに関数の戻り値がOptional<Wrapped>型となる
// 失敗可能イニシャライザのように扱うこともできる

if let tripleInt2 = try? triple2(of: 9) {
    print(tripleInt2)
}



// defer文によるエラーの有無に関わらない処理の実行
func someFunction() {
    print("Do something")
}

func cleanUP() {
    print("CleanUp")
}

do {
    defer {
        // do節を抜けるとタイミングで実行される
        cleanUP()
    }
    try someFunction()
} catch {
    print("Error \(error)")
}



// 連続したエラーのまとめて扱う
enum DatabaseError3: Error {
    case entryNotFound
    case duplicatedEntry
    case invalidEntry(reason: String)
}

struct User3 {
    let id: Int
    let name: String
    let email: String
}

func findUser3(byID id: Int) -> Result<User3, DatabaseError3> {
    let users = [
        User3(id: 1, name: "Yusei", email: "nfsdofa@ex.com"),
        User3(id: 2, name: "tanaka", email: "jfdla@ex.com")
    ]

    for user in users {
        if user.id == id {
            return .success(user)
        }
    }
    return .failure(.entryNotFound)
}

func localPart(fromEmail email: String) -> Result<String, DatabaseError3> {
    let components = email.components(separatedBy: "@")
    guard components.count == 2 else {
        return .failure(.invalidEntry(reason: "Invalid email address"))
    }
    return .success(components[0])
}

let userID = 1

switch findUser3(byID: userID) {
case .success(let user):
    switch localPart(fromEmail: user.email) {
    case .success(let localPart):
        print("Local part: \(localPart)")
    case .failure(let error):
        print("Error \(error)")
    }
case .failure(let error):
    print("Error \(error)")
}

// 結果: Local part: nfsdofa




// fatalError() プログラムの終了
// その箇所が実行されること自体が想定外であることを宣言するための関数
//fatalError("想定しないエラーが発生したためプログラムを終了します")



// Never型 値を返さないことを示す型
// fatalError()関数の戻り値の型は値を返さないことを示すNever型という特殊な型 その箇所以降の処理は実行されないため戻り値を返す必要がない
func randumInt() -> Int {
    fatalError("まだ実装されていません")
}


func title(forButtonAt index: Int) -> String {
    // ケースがInt型の値を網羅できないとコンパイルエラー
    //    switch index {
    //    case 0: return "赤"
    //    case 1: return "青"
    //    case 2: return "黄"
    //    }
    return "a"
}

func title2(forButtonAt index: Int) -> String {
    switch index {
    case 0: return "a"
    case 1: return "b"
    case 2: return "c"
    default: fatalError("想定外のボタンのインデックスを受け取りました")
    }
}




// アサーションによるデバッグ時のプログラム終了
// プログラムがある時点で満たしているべき条件を記述するための機能で条件が満たされていない場合はプログラムの実行を終了する
// リリース時は実行は継続し終了しない
func format(minute: Int, second: Int) -> String {
    assert(second < 60, "secondは60未満に設定してください")
    return "\(minute)分 \(second)秒"
}


func printSeason(forMonth month: Int) {
    switch month {
    case 1...2, 12: print("冬")
    case 3...5: print("春")
    case 6...8: print("夏")
    case 9...11: print("冬")
    default: assertionFailure("monthには1から12までの値を設定してください")
    }
}

printSeason(forMonth: 11)
printSeason(forMonth: 12)
//printSeason(forMonth: 13) // error


// エラー処理の使い分け
// Optional<Wrapped>　エラーの詳細情報が不要で結果の成否のみによってエラーを扱える場合
// Result<Success, Failure>　非同期処理の場合
// do-catch 動機処理の場合
// fatalError(_:)　エラー発生時にプログラムの実行を終了したい場合
// アサーション デバック時のみ エラー発生時にプログラムを終了したい場合


