import UIKit
import Dispatch
import PlaygroundSupport

let queue = DispatchQueue.main // メインディスパッチキューを取得
// iOSやmacOS向けのアプリケーションではユーザーインターフェースの更新は常にメインキューで実行される

// userInteractive　アニメーションの実行などユーザーからの入力に対してインタラクティブに実行される。即時に実行されなければフリーズしているように見える処理に用いる

// userInitiated UIをタップした場合などユーザーからの入力を受けて実行される処理に用いる
// default QoSが何も指定されていない場合に利用される
// utility プログレスバー付きのダウンロードなど視覚的な情報の更新を伴いながらも即時の結果を要求しない処理
// background バックアップなど目に見えない所で行われて数分から数時間かかっても問題ない処理

public enum QoSClass {
    case background
    case utility
    case userInitiated
    case userInteractive
}

let queue2 = DispatchQueue.global(qos: .userInteractive)


PlaygroundPage.current.needsIndefiniteExecution = true
let queue3 = DispatchQueue.global(qos: .userInteractive)
queue3.async {
    Thread.isMainThread // false
    print("非同期の処理")
}

let queue4 = DispatchQueue.global(qos: .userInitiated)
queue4.async {
    Thread.isMainThread // false
    print("非同期の処理2")
    let queue5 = DispatchQueue.main
    queue5.async {
        Thread.isMainThread  // true
        print("メインスレッドでの処理")
    }
}


class SomeOperation: Operation {
    let number: Int
    init(number: Int) { self.number = number }
    override func main() {
        // 1秒まつ
        Thread.sleep(forTimeInterval: 1)
        print(number)
    }
}

let queue6 = OperationQueue()
queue6.name = "com.example.my_operation_queue"
queue6.maxConcurrentOperationCount = 2
queue6.qualityOfService = .userInitiated

var operations = [SomeOperation]()

for i in 0..<10 {
    operations.append(SomeOperation(number: i))
}

queue6.addOperations(operations, waitUntilFinished: false)
print("operations are added")


func runAsynchronousTask(handler: @escaping (Int) -> Void) {
    let globalQueue = DispatchQueue.global()
    globalQueue.async {
        let result = Array(0...100000).reduce(0, +)

        let mainQueue = DispatchQueue.main
        mainQueue.async {
            handler(result)
        }
    }
}

runAsynchronousTask { result in
    print(result) // 5000050000
}


