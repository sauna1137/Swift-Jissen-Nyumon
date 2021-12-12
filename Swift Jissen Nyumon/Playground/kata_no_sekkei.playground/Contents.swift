import UIKit
import Dispatch

//クラス、参照時に非同期処理で両方のインスタンスを参照しないようにする
class Temperature {
    var celsius: Double = 0
}

let temerature = Temperature()
temerature.celsius = 25

let dispatchQueue = DispatchQueue.global(qos: .default)
dispatchQueue.async {
    temerature.celsius != 1
}
temerature.celsius = 1
temerature.celsius //　非同期の処理によって実行のタイミングによって結果が異なる



//インスタンスのライフサイクルに合わせて処理を実行する
var tempraryData: String?

class SomeClass {
    init() {
        print("Create a temporary data")
        tempraryData = "a temporary data"
    }

    deinit {
        print("Clean up the temporary data")
        tempraryData = nil
    }
}

var someClass: SomeClass? = SomeClass()
tempraryData // a temporary data

someClass = nil
tempraryData // nil  deinitでファイルはデイニシャライザが実行され一時ファイルも削除される

// Create a temporary data
// Clean up the temporary data



// クラスの継承がもたらす期待しない挙動
protocol Ownable {
    var owner: String { get set }
}

protocol Animal {
    func sleep()
    func move()
}

extension Animal {
    func sleep() { print("sleeping") }
}

struct Dog: Animal, Ownable {
    var owner: String
    func move() { print("Prancing") }
}

struct Cat: Animal, Ownable {
    var owner: String
    func move() { print("Prancing") }
}

struct WildEagle: Animal {
    func move() { print("Flying") }
}



//クラスの継承を利用するべき時 複数の型の間でストアドプロパティの実装を共有する
class Animal2 {
    var owner: String? {
        didSet {
            guard let owner = owner else { return }
            print("\(owner) was assigned as the owner")
        }
    }
}

class Dog2: Animal2 { }
class Cat2: Animal2 { }
class WildEagle2: Animal2 { }
let dog = Dog2()
dog.owner = "Yusei Nishiyama"
// Yusei Nishiyama was assigned as the owner




//オプショナル型の利用指針
