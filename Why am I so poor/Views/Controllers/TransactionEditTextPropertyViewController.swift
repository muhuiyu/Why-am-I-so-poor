//
//  TransactionEditTextPropertyViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import Foundation
import UIKit
import RxSwift

class TransactionEditTextPropertyViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    
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
extension TransactionEditTextPropertyViewController {
    private func configureViews() {
        titleLabel.text = "Add note"
        titleLabel.font = UIFont.h2
        titleLabel.textAlignment = .left
        view.addSubview(titleLabel)
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        
    }
}

