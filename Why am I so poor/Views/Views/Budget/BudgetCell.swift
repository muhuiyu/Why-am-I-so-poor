//
//  BudgetCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//


import UIKit
import RxSwift

class BudgetCell: UITableViewCell {
    static let reuseID = NSStringFromClass(BudgetCell.self)
    
    private let iconView = UIImageView()
    private let detailStack = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let amountStack = UIStackView()
    private let remainingAmountLabel = UILabel()
    private let totalAmountLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    var viewModel = BudgetViewModel()
    
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
extension BudgetCell {
    private func configureViews() {
        iconView.contentMode = .scaleAspectFit
        contentView.addSubview(iconView)

        titleLabel.textColor = .label
        titleLabel.font = UIFont.bodyHeavy
        titleLabel.text = "default"
        detailStack.addArrangedSubview(titleLabel)

        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.font = UIFont.small
        subtitleLabel.text = "default"
        detailStack.addArrangedSubview(subtitleLabel)

        detailStack.alignment = .leading
        detailStack.axis = .vertical
        detailStack.spacing = Constants.spacing.trivial
        contentView.addSubview(detailStack)

        remainingAmountLabel.textColor = .label
        remainingAmountLabel.font = UIFont.body
        remainingAmountLabel.text = "default"
        amountStack.addArrangedSubview(remainingAmountLabel)
        
        totalAmountLabel.textColor = .secondaryLabel
        totalAmountLabel.font = UIFont.small
        totalAmountLabel.text = "default"
        amountStack.addArrangedSubview(totalAmountLabel)
        
        amountStack.alignment = .trailing
        amountStack.axis = .vertical
        amountStack.spacing = Constants.spacing.trivial
        contentView.addSubview(amountStack)
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
        amountStack.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(detailStack.snp.trailing)
        }
//        detailStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
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

        viewModel.displayCategoryString
            .asObservable()
            .subscribe { value in
                self.titleLabel.text = value
            }
            .disposed(by: disposeBag)

        viewModel.displayMonthlyAverageString
            .asObservable()
            .subscribe { value in
                self.subtitleLabel.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.displayRemainingAmountString
            .asObservable()
            .subscribe { value in
                self.remainingAmountLabel.text = value
            }
            .disposed(by: disposeBag)

        viewModel.displayTotalAmountString
            .asObservable()
            .subscribe { value in
                self.totalAmountLabel.text = value
            }
            .disposed(by: disposeBag)

    }
}

