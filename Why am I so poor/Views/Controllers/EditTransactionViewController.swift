//
//  EditTransactionViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import UIKit
import RxSwift
import Vision

class EditTransactionViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    // MARK: - TableView
    private let tableView = UITableView()
    private lazy var cells: [UITableViewCell] = [
        amountCell,
        dateCell,
        merchantCell,
        categoryCell,
        paymentMethodCell,
        tagCell,
        noteCell,
    ]
    
    private let amountCell = TransactionAmountCell()
    // TODO: - Date cell
    private let dateCell = TransactionDetailCell()
    private let merchantCell = TransactionDetailCell()
    private let categoryCell = TransactionDetailCell()
    private let paymentMethodCell = TransactionDetailCell()
    private let tagCell = TransactionDetailCell()
    private let noteCell = TransactionDetailCell()
    
    var viewModel = TransactionViewModel()
    
    private let mode: Mode
    enum Mode {
        case add
        case edit
    }
    init(mode: EditTransactionViewController.Mode) {
        self.mode = mode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
}
// MARK: - View Config
extension EditTransactionViewController {
    private func configureViews() {
        navigationItem.setBarButtonItem(at: .left, image: Icons.get(.xmark), target: self, action: #selector(didTapClose))
        switch mode {
        case .add:
            navigationItem.setTitle(Localized.TransactionDetail.addTransaction)
            navigationItem.setBarButtonItem(at: .right, with: Localized.General.save, target: self, action: #selector(didTapAdd))
        case .edit:
            navigationItem.setTitle(Localized.TransactionDetail.editTransaction)
        }
        
//        amountCell
        
        dateCell.title = Localized.TransactionDetail.date
        dateCell.value = Date().formatted()
        dateCell.tapHandler = { [weak self] in
            self?.didRequestToEdit(.date)
        }
        merchantCell.title = Localized.TransactionDetail.merchant
        merchantCell.value = Localized.TransactionDetail.addMerchant
        merchantCell.valueIcon = Icons.get(.giftcard)
        merchantCell.tapHandler = { [weak self] in
            self?.didRequestToEdit(.merchant)
        }
        categoryCell.title = Localized.TransactionDetail.category
        categoryCell.value = Localized.TransactionDetail.addCategory
        categoryCell.valueIcon = Icons.get(.plus)
        categoryCell.tapHandler = { [weak self] in
            self?.didRequestToEdit(.category)
        }
        tagCell.title = Localized.TransactionDetail.tag
        tagCell.value = Localized.TransactionDetail.addTag
        tagCell.valueIcon = Icons.get(.plus)
        tagCell.tapHandler = { [weak self] in
            self?.didRequestToEdit(.tag)
        }
        paymentMethodCell.title = Localized.TransactionDetail.paymentBy
        paymentMethodCell.value = Localized.TransactionDetail.addPaymentMethod
        paymentMethodCell.valueIcon = Icons.get(.creditcard)
        paymentMethodCell.tapHandler = { [weak self] in
            self?.didRequestToEdit(.paymentBy)
        }
        noteCell.title = Localized.TransactionDetail.note
        noteCell.value = Localized.TransactionDetail.addNote
        noteCell.valueIcon = Icons.get(.pencil)
        noteCell.tapHandler = { [weak self] in
            self?.didRequestToEdit(.note)
        }
        
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(TransactionAmountCell.self, forCellReuseIdentifier: TransactionAmountCell.reuseID)
        tableView.register(TransactionDetailCell.self, forCellReuseIdentifier: TransactionDetailCell.reuseID)
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
        viewModel.displayIcon
            .asObservable()
            .subscribe { value in
                self.categoryCell.valueIcon = value
            }
            .disposed(by: disposeBag)
        
        viewModel.displayDateString
            .asObservable()
            .subscribe { value in
                self.dateCell.value = value
            }
            .disposed(by: disposeBag)

        viewModel.displayMerchantString
            .asObservable()
            .subscribe { value in
                self.merchantCell.value = value
            }
            .disposed(by: disposeBag)

        viewModel.displayAmountString
            .asObservable()
            .subscribe { value in
                self.amountCell.value = value
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
                self.noteCell.value = value
            }
            .disposed(by: disposeBag)

        viewModel.displayTagString
            .asObservable()
            .subscribe { value in
                self.tagCell.value = value
            }
            .disposed(by: disposeBag)
    }
}
// MARK: - Data Source
extension EditTransactionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
}
// MARK: - Navigation
extension EditTransactionViewController {
    @objc
    private func didTapClose() {
        homeCoordinator?.dismissCurrentModal()
    }
    @objc
    private func didTapAdd() {
        viewModel.updateTransaction()
        homeCoordinator?.dismissCurrentModal()
    }
    private func didRequestToEdit(_ field: Transaction.EditableFields) {
        if let transaction = viewModel.transaction.value {
            homeCoordinator?.showEditTransactionFieldOptionList(transaction, field: field)
        }
    }
}
