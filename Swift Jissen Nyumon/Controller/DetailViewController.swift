//
//  DetailViewController.swift
//  Swift Jissen Nyumon
//
//  Created by KS on 2021/11/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var labelsText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = labelsText
    }

}
