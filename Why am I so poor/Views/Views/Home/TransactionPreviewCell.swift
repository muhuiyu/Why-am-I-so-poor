//
//  TransactionPreviewCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift

class TransactionPreviewCell: UITableViewCell {
    static let reuseID = NSStringFromClass(TransactionPreviewCell.self)
    
    private let iconView = UIImageView()
    private let detailStack = UIStackView()
    private let merchantLabel = UILabel()
    private let categoryLabel = UILabel()
    private let dateLabel = UILabel()
    private let signedAmountLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    var viewModel = TransactionCellViewModel()
    
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
extension TransactionPreviewCell {
    private func configureViews() {
        iconView.contentMode = .scaleAspectFit
        contentView.addSubview(iconView)
        
        merchantLabel.textColor = UIColor.label
        merchantLabel.font = UIFont.bodyHeavy
        merchantLabel.text = "default"
        detailStack.addArrangedSubview(merchantLabel)
        
        categoryLabel.textColor = UIColor.secondaryLabel
        categoryLabel.font = UIFont.small
        categoryLabel.text = "default"
        detailStack.addArrangedSubview(categoryLabel)
        
        dateLabel.textColor = UIColor.secondaryLabel
        dateLabel.font = UIFont.small
        dateLabel.text = "default"
        detailStack.addArrangedSubview(dateLabel)
        
        detailStack.alignment = .leading
        detailStack.axis = .vertical
        detailStack.spacing = Constants.spacing.trivial
        contentView.addSubview(detailStack)
        
        signedAmountLabel.textColor = UIColor.brand.primary
        signedAmountLabel.font = UIFont.h3
        signedAmountLabel.text = "default"
        contentView.addSubview(signedAmountLabel)
    }
    private func configureConstraints() {
        iconView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.size.equalTo(Constants.iconButtonSize.small)
        }
        detailStack.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(iconView.snp.trailing).offset(Constants.spacing.medium)
        }
        signedAmountLabel.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(detailStack.snp.trailing)
        }
        detailStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        viewModel.displayIcon
            .asObservable()
            .subscribe { image in
                self.iconView.image = image
            }
            .disposed(by: disposeBag)

        viewModel.displayMerchantString
            .asObservable()
            .subscribe { value in
                self.merchantLabel.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.displayCategoryString
            .asObservable()
            .subscribe { value in
                self.categoryLabel.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.displayDateString
            .asObservable()
            .subscribe { value in
                self.dateLabel.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.displayAmountString
            .asObservable()
            .subscribe { value in
                self.signedAmountLabel.text = value
            }
            .disposed(by: disposeBag)

    }
}
