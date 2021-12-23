import UIKit
import Foundation

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
