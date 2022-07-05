//
//  BudgetEditCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import UIKit
import RxSwift

class BudgetEditCell: UITableViewCell {
    private let disposeBag = DisposeBag()
    
    static let reuseID = NSStringFromClass(BudgetEditCell.self)
    
    private let iconView = UIImageView()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let amountStackView = UIStackView()
    private let dollarSignLabel = UILabel()
    private let textField = UnderlinedTextField()
    
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
extension BudgetEditCell {
    private func configureViews() {
        iconView.contentMode = .scaleAspectFit
        contentView.addSubview(iconView)
        
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.bodyHeavy
        titleLabel.textColor = .label
        stackView.addArrangedSubview(titleLabel)
        
        subtitleLabel.textAlignment = .left
        subtitleLabel.font = UIFont.small
        subtitleLabel.textColor = .secondaryLabel
        stackView.addArrangedSubview(subtitleLabel)
        
        stackView.spacing = Constants.spacing.trivial
        stackView.alignment = .leading
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        dollarSignLabel.text = "$"
        dollarSignLabel.textAlignment = .right
        dollarSignLabel.textColor = .label
        dollarSignLabel.font = UIFont.body
        amountStackView.addArrangedSubview(dollarSignLabel)
        
        textField.textAlignment = .right
        textField.textColor = .label
        textField.font = UIFont.body
        textField.keyboardType = .decimalPad
        textField.delegate = self
        amountStackView.addArrangedSubview(textField)
        
        amountStackView.alignment = .center
        amountStackView.spacing = 0
        amountStackView.axis = .horizontal
        contentView.addSubview(amountStackView)
    }
    private func configureConstraints() {
        iconView.snp.remakeConstraints { make in
            make.size.equalTo(Constants.iconButtonSize.small)
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
        stackView.snp.remakeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(Constants.spacing.medium)
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
        }
        amountStackView.snp.remakeConstraints { make in
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
            make.leading.equalTo(stackView.snp.trailing)
        }
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

        viewModel.displayTotalAmountDouble
            .asObservable()
            .subscribe { value in
                self.textField.text = value.formatted()
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Delegate
extension BudgetEditCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
    }
}
