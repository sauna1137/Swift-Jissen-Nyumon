//
//  Temperature.swift
//  Swift Jissen Nyumon
//
//  Created by KS on 2021/12/26.
//

import Foundation

public struct Temperature: Equatable {
    public var celsius: Double
    public var fahrenheit: Double {
        return celsius // 仮の実装
    }

    public init(celsius: Double) {
        self.celsius = celsius
    }
}
