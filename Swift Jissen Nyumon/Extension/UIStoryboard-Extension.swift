//
//  UIStoryboard-Extension.swift
//  Swift Jissen Nyumon
//
//  Created by KS on 2021/11/23.
//

import Foundation
import UIKit

extension UIStoryboard {

    static var detailVC: DetailViewController {
        return UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "Detail") as! DetailViewController
    }
}
