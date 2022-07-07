//
//  TransactionEditFieldViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import Foundation
import UIKit

class TransactionEditFieldViewController: BaseViewController {
    private let tableView = UITableView()
    
    var transaction: Transaction? {
        didSet {
            
        }
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
extension TransactionEditOptionFieldViewController {
    private func configureViews() {
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
    private func configureSignals() {
        
    }
}
// MARK: - Data Source
extension TransactionEditOptionFieldViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
}
// MARK: - Delegate
extension TransactionEditOptionFieldViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        print(indexPath)
        // TODO: -
    }
}

