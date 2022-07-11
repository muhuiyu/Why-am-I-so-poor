//
//  TransactionEditFieldViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import Foundation
import UIKit
import RxSwift

class TransactionEditFieldViewController: BaseViewController {
    private let tableView = UITableView()
    
    let viewModel: TransactionEditFieldViewModel
    init(viewModel: TransactionEditFieldViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
    }
}
// MARK: - Navigation
extension TransactionEditFieldViewController {
    @objc
    private func didTapSave() {
        viewModel.updateField()
        homeCoordinator?.dismissCurrentModal()
    }
}
// MARK: - View Config
extension TransactionEditFieldViewController {
    private func configureViews() {
        navigationItem.setBarButtonItem(at: .right, with: Localized.General.save, target: self, action: #selector(didTapSave))
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureGestures() {

    }
}
// MARK: - Data Source
extension TransactionEditFieldViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.options[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
// MARK: - Delegate
extension TransactionEditFieldViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        for i in 0..<viewModel.options.count {
            let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0))
            cell?.accessoryType = i == indexPath.row ? .checkmark : .none
        }
        viewModel.didSelect(viewModel.options[indexPath.row])
    }
}
