//
//  Swift_Jissen_NyumonTests.swift
//  Swift Jissen NyumonTests
//
//  Created by KS on 2021/12/26.

// テストターゲット、アサーション、テストケースなどユニットテストに関する基本的な事柄からスタブを用いたテスト方法など
// 挙動を保証することがユニットテストの主目的　開発者はテストがあることで自信をもってプログラムを変更できる　

import XCTest
import Foundation

class Swift_Jissen_NyumonTests: XCTestCase {

    // テストケース　テストをまと多める
    // 個々のテストはXCTestCaseクラスを継承したクラスのメソッドとして定義される　同じクラス内に定義されたテストの集まりをテストケースと呼び
    // 関連するテストは同じテストケース内に配置する

    // 複数のテストの間には共通の事前処理や事後処理が必要になることがある。
    // 共通の事前処理をsetUP(), 共通の事後処理をtearDownメソッドで定義できる


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // 事前処理を行うメソッド　対象の状態リセットや一時ファイルの作成を行う。
        // インスタンス、クラスメソッドの両方がある　インスタンスメソッドではテストごとの事前処理を行い、クラスメソッドではテストケース全体の事前処理を行う

        try super.setUpWithError()
        print("テストケース全体の事前処理")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        // テストの事後処理を行うメソッド 一時ファイルの削除などテストの後に必要な処理を実行
        // インスタンスメソッドではテストごとの事後処理を行い、クラスメソッドではテストケース全体の事後処理を行う
        try super.tearDownWithError()
        print("テストごとの事後処理")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }


    func tests() {
        let value = 5
        let nils = nil as Int?

        XCTAssert(value == 5) //　引数の式がtrueを返す
        XCTAssertTrue(value > 0) // 引数の式がtrueを返す
        XCTAssertFalse(value < 0) // 引数の式がfalseを返す
        XCTAssertNil(nils) // 引数の式がnilを返す
        XCTAssertNotNil(value) // 引数の式がnilでない値を返す

        XCTAssertEqual("ab", "ab") // Equatableに準拠した型 2つの式の結果が等しい
        XCTAssertEqual(0.001, 0.002, accuracy: 0.1) // 2つの式の差分が第3引数で指定された値よりも小さい
        XCTAssertNotEqual("ax", "bx") // Equatableに準拠した型　2つの式の結果が等しくない
        XCTAssertLessThan(4, 7) // 第1引数が第2引数より小さい
        XCTAssertLessThanOrEqual(7, 7) // 第1引数が第2引数以下
        XCTAssertGreaterThan(6, 4) // 第1引数が第2引数より大きい
        XCTAssertGreaterThanOrEqual(4, 4) // 第1引数が第2引数以上
    }

    struct SomeError: Error {

    }

    func throwableFunction(throwsError: Bool) throws {
        if throwsError {
            throw SomeError()
        }
    }
//
//    class ErrorAssertionTests: XCTestCase {
//        func test() {
//            XCTAssertThrowsError(
//                try throwableFunction(throwsError: true))
//            XCTAssertNoThrow(try throwableFunction(throwsError: false))
//        }
//    }

}


// スタブ　テスト対象への入力を置き換える スタブは主に外部システムとの連携部をテストする際に利用されます
// ネットワークの状態にテスト結果が左右される　サーバーの状態にテスト結果が左右される、実行に時間がかかる
// サーバとの通信では実際には通信を行わず固定のレスポンスを返すスタブを作成する



