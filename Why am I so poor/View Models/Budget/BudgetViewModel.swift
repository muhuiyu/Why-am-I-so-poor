//
//  BudgetViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift
import RxRelay

class BudgetViewModel {
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactive properties
    var budget: BehaviorRelay<Budget?> = BehaviorRelay(value: nil)
    var displayIcon: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    var displayCategoryString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayMonthlyAverageString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayRemainingAmountString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayTotalAmountString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayTotalAmountDouble: BehaviorRelay<Double> = BehaviorRelay(value: 0)
    
    // MARK: - Transactions
    lazy var dataSource = TransactionDataSource.dataSource()
    var transactions: BehaviorRelay<[Transaction]> = BehaviorRelay(value: [])
    var displayMonthlyTransactions: BehaviorRelay<[TransactionSection]> = BehaviorRelay(value: [])
    
    init() {
        self.budget
            .asObservable()
            .subscribe(onNext: { value in
                if let value = value {
                    self.displayIcon.accept(value.icon)
                    self.displayCategoryString.accept(value.category.name)
                    self.displayMonthlyAverageString.accept("Monthly average: " + value.monthlyAverage.toCurrencyString())
                    self.displayRemainingAmountString.accept(value.remainingAmount.toCurrencyString())
                    self.displayTotalAmountString.accept("/ " + value.amount.toCurrencyString())
                    self.displayTotalAmountDouble.accept(value.amount)
                }
            })
            .disposed(by: disposeBag)
        
        
        // TODO: -
        
        getTransactions(of: Date.currentMonth)
        self.transactions
            .asObservable()
            .subscribe { transactions in
                self.displayMonthlyTransactions.accept([
                    TransactionSection(header: "", items: transactions)
                ])
            }
            .disposed(by: disposeBag)
    }
}

extension BudgetViewModel {
    private func getTransactions(of month: Int) {
        // TODO: -
    }
}
