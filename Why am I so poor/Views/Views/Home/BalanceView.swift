//
//  BalanceView.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import UIKit

class BalanceView: UIView {
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let amountLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let buttonStackView = UIStackView()
    private let addTransactionButton = IconTextButton()
    private let accountListButton = IconTextButton()
    
    var amountString: String? {
        didSet {
            amountLabel.text = amountString
        }
    }
    var subtitleString: String? {
        didSet {
            subtitleLabel.text = subtitleString
        }
    }
    
    var addTransactionTapHandler: (() -> Void)? {
        didSet {
            addTransactionButton.tapHandler = addTransactionTapHandler
        }
    }
    var viewAccountListTapHandler: (() -> Void)? {
        didSet {
            accountListButton.tapHandler = viewAccountListTapHandler
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
        configureGestures()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - View Config
extension BalanceView {
    private func configureViews() {
        titleLabel.text = "default"
        titleLabel.text = Localized.Home.totalBalance
        titleLabel.font = UIFont.smallBold
        titleLabel.textColor = UIColor.brand.primary
        titleLabel.textAlignment = .left
        stackView.addArrangedSubview(titleLabel)
        
        amountLabel.text = "default"
        amountLabel.font = UIFont.h3
        amountLabel.textColor = .label
        amountLabel.textAlignment = .left
        stackView.addArrangedSubview(amountLabel)
        
        subtitleLabel.text = "default"
        subtitleLabel.font = UIFont.smallBold
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .left
        stackView.addArrangedSubview(subtitleLabel)
        
        stackView.spacing = Constants.spacing.trivial
        stackView.alignment = .leading
        stackView.axis = .vertical
        addSubview(stackView)
        
        addTransactionButton.text = Localized.Home.addTransaction
        addTransactionButton.icon = UIImage(systemName: "plus.circle.fill")
        buttonStackView.addArrangedSubview(addTransactionButton)
        
        accountListButton.text = Localized.Home.accounts
        accountListButton.icon = UIImage(systemName: "creditcard.circle.fill")
        buttonStackView.addArrangedSubview(accountListButton)
        
        buttonStackView.spacing = Constants.spacing.trivial
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .center
        addSubview(buttonStackView)
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
    }
    private func configureConstraints() {
        stackView.snp.remakeConstraints { make in
            make.top.leading.bottom.equalTo(layoutMarginsGuide).inset(Constants.spacing.trivial)
            make.trailing.equalTo(buttonStackView.snp.leading)
        }
        buttonStackView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(layoutMarginsGuide).inset(Constants.spacing.trivial)
        }
    }
    private func configureGestures() {
        
    }
}

