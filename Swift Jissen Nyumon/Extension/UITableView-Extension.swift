//
//  UITableView-Extension.swift
//  Swift Jissen Nyumon
//
//  Created by KS on 2021/11/23.
//

import Foundation
import UIKit

extension NSObjectProtocol {
    static var className: String {
        return String(describing: self)
    }
}

extension UITableViewCell {

    static var identifier: String {
        return className
    }
}

extension UITableView {

    func registerCustomCell<T: UITableViewCell>(_ cellType: T.Type) {
        register(
            UINib(nibName: T.identifier, bundle: nil),
            forCellReuseIdentifier: "Cell"
        )
    }

    func dequeueReusableCustomCell<T: UITableViewCell>(with cellType: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: "Cell") as! T
    }
}
