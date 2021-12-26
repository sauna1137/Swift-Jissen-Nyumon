import UIKit

struct SomeStruct: Codable {
    let value: Int
}

let someStruct = SomeStruct(value: 1)

let jsonEncoder = JSONEncoder()
let encodedJSONData = try! jsonEncoder.encode(someStruct)
let encodedJSONString = String(data: encodedJSONData, encoding: .utf8)
print("Encoded:", encodedJSONString)

let jsonDecoder = JSONDecoder()
let decodedSomeStruct = try! jsonDecoder.decode(SomeStruct.self, from: encodedJSONData)
print("Decoded", decodedSomeStruct)

// 結果: Encoded: Optional("{\"value\":1}")
// Decoded SomeStruct(value: 1)



// URLRequest
// 通信のリクエストを表現するHTTPリクエストのURL、ヘッダ等の情報を持ちます
let url = URL(string: "https://api.github.com/search/repositories?q=swift")!
var urlRequest = URLRequest(url: url)
urlRequest.httpMethod = "GET"
urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")



// HTTPURLResponse
let url2 = URL(string: "https://api.github.com/search/repositories?q=swift")!
let urlRequest2 = URLRequest(url: url2)



// タスクを実行するにはまずはURLSessionクラスのインスタンスを取得
let session = URLSession.shared
let task = session.dataTask(with: urlRequest) {
    data, urlRequest, error in
    // 通信完了時に実行
}

task.resume()

