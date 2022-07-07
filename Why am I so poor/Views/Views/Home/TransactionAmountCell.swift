//
//  TransactionAmountCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import UIKit

class TransactionAmountCell: UITableViewCell {
    static let reuseID = NSStringFromClass(TransactionAmountCell.self)
    
    private let dollarSignLabel = UILabel()
    private let textField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - View Config
extension TransactionAmountCell {
    private func configureViews() {
        dollarSignLabel.text = "$"
        contentView.addSubview(dollarSignLabel)
        
        textField.textAlignment = .left
        textField.placeholder = "Enter amount"
        textField.delegate = self
        textField.keyboardType = .decimalPad
        contentView.addSubview(textField)
    }
    private func configureConstraints() {
        dollarSignLabel.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.top.bottom.equalTo(textField)
        }
        textField.snp.remakeConstraints { make in
            make.leading.equalTo(dollarSignLabel.snp.trailing).offset(Constants.spacing.trivial)
            make.top.bottom.equalTo(contentView.layoutMarginsGuide).inset(Constants.spacing.small)
        }
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        
    }
}

// MARK: - Delegate
extension TransactionAmountCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // TODO: -
    }
}
