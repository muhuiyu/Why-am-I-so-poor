//
//  HomeViewController.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit
import RxSwift

class HomeViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    private let headerView = UIView()
    private let balanceView = BalanceView()
    private let listHeaderView = TransactionListHeaderView()
    
    private let tableView = UITableView()
    
    var homeViewModel = HomeViewModel()
    var transactionListViewModel = TransactionListViewModel()
    
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
extension HomeViewController {
    private func configureViews() {
        title = homeViewModel.displayTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icons.get(.bellbadge, isFilled: true),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(homeViewModel.didTapOnNotification))
        
        balanceView.addTransactionTapHandler = { [weak self] in
            self?.didTapAddTransaction()
        }
        balanceView.viewAccountListTapHandler = { [weak self] in
            self?.didTapViewAccounts()
        }
        headerView.addSubview(balanceView)
        
        listHeaderView.tapHandler = {[weak self] in
            self?.homeCoordinator?.showTransactionList()
        }
        headerView.addSubview(listHeaderView)
        view.addSubview(headerView)
        
        // TODO: - Set as headerView
//        tableView.tableHeaderView = headerView
//        tableView.tableHeaderView?.layoutIfNeeded()
//        tableView.tableHeaderView = tableView.tableHeaderView
        
        tableView.register(TransactionPreviewCell.self, forCellReuseIdentifier: TransactionPreviewCell.reuseID)
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        balanceView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        listHeaderView.snp.remakeConstraints { make in
            make.top.equalTo(balanceView.snp.bottom).offset(Constants.spacing.medium)
            make.leading.trailing.equalTo(balanceView)
            make.bottom.equalToSuperview()
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
        
    }
    private func configureSignals() {
        transactionListViewModel.displayTransactions
            .bind(to: tableView.rx.items(dataSource: transactionListViewModel.dataSource))
            .disposed(by: disposeBag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Transaction.self))
            .subscribe { indexPath, item in
                self.homeCoordinator?.showTransactionDetail(item)
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
        
        transactionListViewModel.displayMonthlyBalanceString
            .asObservable()
            .subscribe { value in
                self.balanceView.amountString = value
            }
            .disposed(by: disposeBag)
        
        transactionListViewModel.displayNumberOfAccountsString
            .asObservable()
            .subscribe { value in
                self.balanceView.subtitleString = value
            }
            .disposed(by: disposeBag)

    }
}
// MARK: - Navigation
extension HomeViewController {
    private func didTapAddTransaction() {
        homeCoordinator?.showAddTransaction()
    }
    private func didTapViewAccounts() {
        // TODO: -
    }

}
