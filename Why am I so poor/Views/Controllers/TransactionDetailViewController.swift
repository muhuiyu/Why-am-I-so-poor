//
//  TransactionDetailViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift

class TransactionDetailViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
    private let headerView = DetailHeaderView()
    private let tableView = UITableView()
    
    // MARK: - Cells
    private let paymentMethodCell = TransactionDetailCell()
    private let categoryCell = TransactionDetailCell()
    private let expenseTagCell = TransactionDetailCell()
    private let noteCell = TransactionDetailCell()
    private lazy var cells: [UITableViewCell] = [
        paymentMethodCell,
        categoryCell,
        expenseTagCell,
        noteCell,
    ]
    
    var viewModel = TransactionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
}
// MARK: - View Config
extension TransactionDetailViewController {
    private func configureViews() {
        navigationController?.title = "details"
        
        view.addSubview(headerView)
        
        // MARK: - Cells
        categoryCell.title = Localized.TransactionDetail.category
        categoryCell.tapHandler = { [weak self] in
            guard let transaction = self?.viewModel.transaction.value else { return }
            self?.homeCoordinator?.showEditTransactionCategory(transaction)
        }
        
        paymentMethodCell.title = Localized.TransactionDetail.paymentBy
        paymentMethodCell.valueIcon = UIImage(systemName: "creditcard.fill")
        paymentMethodCell.tapHandler = { [weak self] in
            guard let transaction = self?.viewModel.transaction.value else { return }
            self?.homeCoordinator?.showEditTransactionPaymentMethod(transaction)
        }
        
        expenseTagCell.title = Localized.TransactionDetail.expenseTag
        expenseTagCell.valueIcon = UIImage(systemName: "tag.fill")
        expenseTagCell.tapHandler = { [weak self] in
            guard let transaction = self?.viewModel.transaction.value else { return }
            self?.homeCoordinator?.showEditTransactionTag(transaction)
        }
        
        noteCell.title = Localized.TransactionDetail.note
        noteCell.value = Localized.TransactionDetail.addNote
        noteCell.valueIcon = UIImage(systemName: "pencil.fill")
        noteCell.tapHandler = { [weak self] in
            guard let transaction = self?.viewModel.transaction.value else { return }
            self?.homeCoordinator?.showEditTransactionNote(transaction)
        }
        
        // MARK: - TableView
        tableView.register(TransactionDetailCell.self, forCellReuseIdentifier: TransactionDetailCell.reuseID)
        tableView.dataSource = self
        tableView.allowsSelection = false
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        headerView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(Constants.spacing.large)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        viewModel.displayIcon
            .asObservable()
            .subscribe { value in
                self.categoryCell.valueIcon = value
            }
            .disposed(by: disposeBag)
        
        viewModel.displayDateString
            .asObservable()
            .subscribe { value in
                self.headerView.secondSubtitle = value
            }
            .disposed(by: disposeBag)

        viewModel.displayMerchantString
            .asObservable()
            .subscribe { value in
                self.headerView.firstSubtitle = value
            }
            .disposed(by: disposeBag)

        viewModel.displayInstitutionString
            .asObservable()
            .subscribe { value in
                // TODO: - update view
            }
            .disposed(by: disposeBag)

        viewModel.displayAmountString
            .asObservable()
            .subscribe { value in
                self.headerView.title = value
            }
            .disposed(by: disposeBag)

        viewModel.displayPaymentMethodString
            .asObservable()
            .subscribe { value in
                self.paymentMethodCell.value = value
            }
            .disposed(by: disposeBag)

        viewModel.displayCategoryString
            .asObservable()
            .subscribe { value in
                self.categoryCell.value = value
            }
            .disposed(by: disposeBag)

        viewModel.displayNoteString
            .asObservable()
            .subscribe { value in
                
            }
            .disposed(by: disposeBag)

        viewModel.displayExpenseTagString
            .asObservable()
            .subscribe { value in
                
            }
            .disposed(by: disposeBag)

    }
}

// MARK: - Data Source
extension TransactionDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
}
