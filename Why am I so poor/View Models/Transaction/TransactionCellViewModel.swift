//
//  TransactionCellViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift
import RxRelay

class TransactionCellViewModel {
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactive properties
    var transaction: BehaviorRelay<Transaction?> = BehaviorRelay(value: nil)
    var displayIcon: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    var displayMerchantString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayCategoryString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayDateString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayAmountString: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    init() {
        transaction
            .asObservable()
            .subscribe(onNext: { value in
                if let value = value {
                    self.displayIcon.accept(value.icon)
                    self.displayMerchantString.accept(value.merchant)
                    self.displayCategoryString.accept(value.category.name)
                    self.displayDateString.accept(value.dateParsed.formatted())
                    self.displayAmountString.accept(value.signedAmount.toCurrencyString())
                }
            })
            .disposed(by: disposeBag)
    }
}
