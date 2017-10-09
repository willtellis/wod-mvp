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
    @IBOutlet var loadingBackgroundView: UIView!
    @IBOutlet var errorBackgroundView: UIView!
    @IBOutlet var errorLabel: UILabel!
    
    var viewModel: WodsViewModel = WodsViewModel()
    let presenter = WodsPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure presenter
        presenter.view = self

        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: WodsView
    func render(_ viewModel: WodsViewModel) {
        navigationItem.title = viewModel.title
        self.viewModel = viewModel

        updateBackgroundView()

        tableView.reloadData()
    }

    private func updateBackgroundView() {
        switch self.viewModel.wodCellViewModels {
        case .loading:
            tableView.backgroundView = loadingBackgroundView
        case .failure(let message):
            errorLabel.text = message
            tableView.backgroundView = errorBackgroundView
        case .success:
            tableView.backgroundView = nil
        }
    }

    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        guard case .success = viewModel.wodCellViewModels else {
            return 0
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .success(let wodCellViewModels) = viewModel.wodCellViewModels else {
            return 0
        }
        return wodCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case .success(let wodCellViewModels) = viewModel.wodCellViewModels else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: WodsTableViewCell.reusableIdentifier, for: indexPath) as! WodsTableViewCell
        let cellViewModel = wodCellViewModels[indexPath.row]
        cell.render(cellViewModel)
        return cell
    }

    // MARK: UITableViewDelegate
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
