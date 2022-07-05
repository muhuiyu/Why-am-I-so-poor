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
    
    private let editBudgetLabel = UILabel()
    private let headerView = UIView()
    private let tableView = UITableView()
    
    var viewModel = BudgetListViewModel(mode: .view)
    
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
// MARK: - Actions
extension BudgetViewController {
    @objc
    private func didTapEditBudget() {
        homeCoordinator?.showEditBudget()   // should i use home or budget?
    }
}
// MARK: - View Config
extension BudgetViewController {
    private func configureViews() {
        // TODO: - Navigation Bar
        
        editBudgetLabel.text = Localized.Budget.editBudget
        editBudgetLabel.textColor = UIColor.brand.primary
        editBudgetLabel.font = .bodyHeavy
        editBudgetLabel.textAlignment = .right
        editBudgetLabel.isUserInteractionEnabled = true
        headerView.addSubview(editBudgetLabel)
        view.addSubview(headerView)
        
        tableView.register(BudgetCell.self, forCellReuseIdentifier: BudgetCell.reuseID)
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        editBudgetLabel.snp.remakeConstraints { make in
            make.trailing.equalTo(headerView)
            make.top.bottom.equalTo(headerView.layoutMarginsGuide).inset(Constants.spacing.small)
        }
        headerView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapEditBudget))
        editBudgetLabel.addGestureRecognizer(tapRecognizer)
    }
    private func configureSignals() {
        viewModel.displayBudgets
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Budget.self))
            .subscribe { indexPath, item in
                self.homeCoordinator?.showBudgetDetail(item)
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)

    }
}

