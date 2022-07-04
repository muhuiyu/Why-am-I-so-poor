//
//  TransactionListHeaderView.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit

class TransactionListHeaderView: UIView {
    
    private let titleLabel = UILabel()
    private let moreButton = UIStackView()
    private let moreButtonLabel = UILabel()
    private let moreButtonIcon = UIImageView()
    
    var tapHandler: (() -> Void)?
    
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
extension TransactionListHeaderView {
    private func configureViews() {
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.h2
        titleLabel.text = Localized.TransactionList.recentTransactions
        addSubview(titleLabel)
        
        moreButtonLabel.textColor = UIColor.brand.primary
        moreButtonLabel.textAlignment = .center
        moreButtonLabel.font = UIFont.body
        moreButtonLabel.text = Localized.TransactionList.seeAll
        moreButton.addArrangedSubview(moreButtonLabel)
        
        moreButtonIcon.tintColor = UIColor.brand.primary
        moreButtonIcon.image = UIImage(systemName: "chevron.right")
        moreButton.addArrangedSubview(moreButtonIcon)
        
        moreButton.isUserInteractionEnabled = true
        moreButton.axis = .horizontal
        moreButton.spacing = Constants.spacing.trivial
        moreButton.alignment = .center
        addSubview(moreButton)
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.leading.top.bottom.equalTo(layoutMarginsGuide)
        }
        moreButtonIcon.snp.remakeConstraints { make in
            make.size.equalTo(Constants.iconButtonSize.slight)
        }
        moreButton.snp.remakeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing)
            make.top.bottom.equalTo(titleLabel)
            make.trailing.equalTo(layoutMarginsGuide)
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        moreButton.addGestureRecognizer(tapRecognizer)
    }
}
// MARK: - Actions
extension TransactionListHeaderView {
    @objc
    private func didTapInView() {
        self.tapHandler?()
    }
}
