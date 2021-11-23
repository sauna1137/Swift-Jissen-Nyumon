//
//  HomeViewController.swift
//  Swift Jissen Nyumon
//
//  Created by KS on 2021/11/23.
//

import UIKit

class HomeViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.registerCustomCell(HomeTableViewCell.self)
    }
}

extension HomeViewController: UITableViewDelegate { }

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeModel.homeTableViewTitlesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCustomCell(with: HomeTableViewCell.self)

        cell.titleLabel.text = HomeModel.homeTableViewTitlesArray[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard.detailVC
        detailVC.title = HomeModel.homeTableViewTitlesArray[indexPath.row]
        detailVC.labelsText = HomeModel.DetailVCTextViewsArray[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)

        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
