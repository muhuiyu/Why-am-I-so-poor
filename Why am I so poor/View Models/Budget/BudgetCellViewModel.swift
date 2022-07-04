//
//  BudgetCellViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift
import RxRelay

class BudgetCellViewModel {
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactive properties
    var budget: BehaviorRelay<Budget?> = BehaviorRelay(value: nil)
    var displayIcon: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    var displayTitleString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displaySubtitleString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayRemainingAmountString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayTotalAmountString: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    init() {
        budget
            .asObservable()
            .subscribe(onNext: { value in
                if let value = value {
                    self.displayIcon.accept(value.icon)
                    self.displayTitleString.accept(value.category.name)
                    self.displaySubtitleString.accept(value.monthlyAverage.toCurrencyString())
                    self.displayRemainingAmountString.accept(value.remainingAmount.toCurrencyString())
                    self.displayTotalAmountString.accept(value.amount.toCurrencyString())
                }
            })
            .disposed(by: disposeBag)
    }
}
