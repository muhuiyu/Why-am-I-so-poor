//
//  TransactionViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift
import RxRelay

class TransactionViewModel {
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactive properties
    var transaction: BehaviorRelay<Transaction?> = BehaviorRelay(value: nil)
    var displayIcon: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    var displayDateString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayInstitutionString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayMerchantString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayAmountString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayPaymentMethodString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayCategoryString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayNoteString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayExpenseTagString: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    init() {
        transaction
            .asObservable()
            .subscribe(onNext: { value in
                if let value = value {
                    self.displayIcon.accept(value.icon)
                    self.displayDateString.accept(value.dateParsed.formatted())
                    self.displayMerchantString.accept(value.merchant)
                    self.displayInstitutionString.accept(value.institution)
                    self.displayAmountString.accept(value.signedAmount.toCurrencyString())
                    self.displayPaymentMethodString.accept(value.paymentBy.rawValue)
                    self.displayCategoryString.accept(value.category.name)
                    self.displayNoteString.accept(value.note)
                    self.displayExpenseTagString.accept(value.expenseTag.rawValue)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension TransactionViewModel {
    func editNote() {
        // generate viewController
    }
}
