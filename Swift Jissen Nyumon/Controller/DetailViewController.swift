//
//  DetailViewController.swift
//  Swift Jissen Nyumon
//
//  Created by KS on 2021/11/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    var textViewString = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = textViewString
    }

}
