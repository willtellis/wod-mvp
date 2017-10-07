//
//  ViewController.swift
//  WODmvp
//
//  Created by Will Ellis on 9/21/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import UIKit

final class WodsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WodsView {

    @IBOutlet var tableView: UITableView!
    var viewModel: WodsViewModel = WodsViewModel()
    let presenter = WodsPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure presenter
        presenter.view = self

        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    func render(_ viewModel: WodsViewModel) {
        navigationItem.title = viewModel.title
        self.viewModel = viewModel
        tableView.reloadData()
    }

    // Mark: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.wodCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WodsTableViewCell.reusableIdentifier, for: indexPath) as! WodsTableViewCell
        let cellViewModel = viewModel.wodCellViewModels[indexPath.row]
        cell.render(cellViewModel)
        return cell
    }

    // Mark: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.presentWodDetails(for: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


final class WodsTableViewCell: UITableViewCell, ClassNameIdentifiable {

    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!

    func render(_ viewModel: WodCellViewModel) {
        title.text = viewModel.title
        content.text = viewModel.content
    }
}
