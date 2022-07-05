//
//  TransactionListViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import Foundation
import Collections
import RxSwift
import RxRelay

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

class TransactionListViewModel {
    private let disposeBag = DisposeBag()
    lazy var dataSource = TransactionDataSource.dataSource()
    
    // MARK: - Reactive Properties
    var transactions: BehaviorRelay<[Transaction]> = BehaviorRelay(value: [])
    var displayTransactions: BehaviorRelay<[TransactionSection]> = BehaviorRelay(value: [])
    
    init() {
        getTransactions()
        
        self.transactions
            .asObservable()
            .subscribe { transactions in
//                let sections: [TransactionSection] = self.getTransactionByMonth()
//                    .map { TransactionSection(header: $0, items: $1) }
                
                let sections: [TransactionSection] = self.getTransactionByDay()
                    .map { TransactionSection(header: $0, items: $1) }
                self.displayTransactions.accept(sections)
            }
            .disposed(by: disposeBag)
    }
}

extension TransactionListViewModel {
    func getTransactions() {
        // TODO: - connect to json URL file (but now we dont have)
        transactions.accept(Transaction.testEntries)
    }
    
    func getTransactionByMonth() -> TransactionGroup {
        guard !transactions.value.isEmpty else { return [:] }
        let groupedTransactions = TransactionGroup(grouping: transactions.value) { $0.month }
        return groupedTransactions
    }
    func getTransactionByDay() -> TransactionGroup {
        guard !transactions.value.isEmpty else { return [:] }
        let groupedTransactions = TransactionGroup(grouping: transactions.value) { $0.day }
        return groupedTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.value.isEmpty else { return [] }
        
        let today = "02/17/2022".dateParsed()   // Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.value.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedToTwoDigits()
            cumulativeSum.append((date.formatted(), sum))
        }
        
        return cumulativeSum
    }
}

// MARK: - Delegate
extension TransactionListViewModel {
//    func didSelect(_ transaction: Transaction, at indexPath: IndexPath) {
//        print(transaction)
//        print(indexPath)
//        
//        // TODO: - Go to detail page
//    }
}
