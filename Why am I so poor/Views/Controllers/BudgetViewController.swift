//
//  BudgetViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class BudgetViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    private let headerView = UIView()
    private let tableView = UITableView()
    
    var viewModel = BudgetListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
// MARK: - View Config
extension BudgetViewController {
    private func configureViews() {
        // TODO: - set header view
        tableView.register(BudgetCell.self, forCellReuseIdentifier: BudgetCell.reuseID)
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        viewModel.displayBudgets
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Budget.self))
            .subscribe { indexPath, item in
                self.viewModel.didSelect(item, at: indexPath)
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)

    }
}

