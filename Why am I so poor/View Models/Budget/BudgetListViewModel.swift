//
//  BudgetListViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import Foundation
import RxSwift
import RxRelay

class BudgetListViewModel {
    private let disposeBag = DisposeBag()
    lazy var dataSource = BudgetDataSource.dataSource()
    
    // MARK: -
    var budgets: BehaviorRelay<[Budget]> = BehaviorRelay(value: [])
    var displayBudgets: BehaviorRelay<[BudgetSection]> = BehaviorRelay(value: [])
    
    init() {
        getBudgets()
        
        self.budgets
            .asObservable()
            .subscribe { budgets in
                self.displayBudgets.accept([BudgetSection(header: "", items: budgets)])
//                let sections: [BudgetSection] = self.getTransactionByMonth()
//                    .map { TransactionSection(header: $0, items: $1) }
//                self.displayTransactions.accept(sections)
            }
            .disposed(by: disposeBag)
    }
}

extension BudgetListViewModel {
    func getBudgets() {
        // TODO: - connect to json URL file (but now we dont have)
        budgets.accept(Budget.testEntries)
    }
}

// MARK: - display titles
extension BudgetListViewModel {
    var displayTitle: String { "Budget" }
}

extension BudgetListViewModel {
    func didSelect(_ budget: Budget, at indexPath: IndexPath) {
        print(budget)
        print(indexPath)
        
        // TODO: - Go to detail page
    }
}
