//
//  TransactionTextFieldCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/10/22.
//

import UIKit

class TransactionTextFieldCell: UITableViewCell {
    static let reuseID = NSStringFromClass(TransactionTextFieldCell.self)
    
    private let titleLabel = UILabel()
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
extension TransactionTextFieldCell {
    private func configureViews() {
        
    }
    private func configureConstraints() {
        
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        
    }
}
