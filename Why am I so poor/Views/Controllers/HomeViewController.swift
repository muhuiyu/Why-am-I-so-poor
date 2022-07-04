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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell.badge"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(homeViewModel.didTapOnNotification))
        listHeaderView.tapHandler = {[weak self] in
            self?.homeCoordinator?.showTransactionList()
        }
        view.addSubview(listHeaderView)
        
        tableView.register(TransactionPreviewCell.self, forCellReuseIdentifier: TransactionPreviewCell.reuseID)
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        listHeaderView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(listHeaderView.snp.bottom).offset(Constants.spacing.small)
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
    }
}
// MARK: - Navigation
