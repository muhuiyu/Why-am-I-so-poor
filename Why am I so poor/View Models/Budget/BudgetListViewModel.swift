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
    private let mode: Mode
    lazy var dataSource = BudgetDataSource.dataSource(mode: mode)
    
    // MARK: - Shared ViewModel
    var budgetViewModel = BudgetViewModel()
    
    // MARK: - Reactive Properties
    var budgets: BehaviorRelay<[Budget]> = BehaviorRelay(value: [])
    var displayBudgets: BehaviorRelay<[BudgetSection]> = BehaviorRelay(value: [])
    
    enum Mode {
        case edit
        case view
    }
    
    init(mode: Mode) {
        self.mode = mode
        
        getBudgets()
        
        self.budgets
            .asObservable()
            .subscribe { budgets in
                self.displayBudgets.accept([BudgetSection(header: "", items: budgets)])
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

}
