//
//  TransactionEditFieldViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import Foundation
import UIKit

//class TransactionEditFieldViewController: BaseViewController {
//    private let tableView = UITableView()
//    
//    private let titleLabel = UILabel()
//    private let textField = UITextField()       // textfield
//    private let toggleView = UISwitch()         // toggle
//    
//    private let viewModel: TransactionEditFieldViewModel
//    
//    init(viewModel: TransactionEditFieldViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // TODO: -
//        configureViews()
//        configureConstraints()
//        configureGestures()
//        configureSignals()
//    }
//}
//// MARK: - View Config
//extension TransactionEditFieldViewController {
//    private func configureViews() {
//        switch field {
//        case .date:
//            configureViewsWithDatePicker()
//        case .account, .merchant, .paymentBy, .category, .tag:
//            configureViewsWithOptions()
//        case .amount, .note:
//            configureViewsWithTextField()
//        case .isRecurring:
//            configureViewsWithToggle()
//        }
//    }
//    private func configureViewsWithDatePicker() {
//        
//    }
//    private func configureViewsWithOptions() {
//        tableView.dataSource = self
//        tableView.delegate = self
//        view.addSubview(tableView)
//        tableView.snp.remakeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//    private func configureViewsWithTextField() {
//        titleLabel.text = "Add note"
//        titleLabel.font = UIFont.h2
//        titleLabel.textAlignment = .left
//        view.addSubview(titleLabel)
//        titleLabel.snp.remakeConstraints { make in
//            make.top.leading.trailing.equalTo(view.layoutMarginsGuide)
//        }
//    }
//    private func configureViewsWithToggle() {
//        
//    }
//
//    private func configureConstraints() {
//        
//    }
//    private func configureGestures() {
//        
//    }
//    private func configureSignals() {
//        
//    }
//}
//// MARK: - Data Source
//extension TransactionEditFieldViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
//}
//// MARK: - Delegate
//extension TransactionEditFieldViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        defer {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//        print(indexPath)
//        // TODO: -
//    }
//}
//
