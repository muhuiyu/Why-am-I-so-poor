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
    private var transactions: BehaviorRelay<[Transaction]> = BehaviorRelay(value: [])
    private var accounts: BehaviorRelay<[Account]> = BehaviorRelay(value: [])
    var displayTransactions: BehaviorRelay<[TransactionSection]> = BehaviorRelay(value: [])
    var displayMonthlyBalanceString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayNumberOfAccountsString: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    init() {
        getTransactions()
        
        self.transactions
            .asObservable()
            .subscribe { _ in
                let sections: [TransactionSection] = self.getTransactionByDay()
                    .map { TransactionSection(header: $0, items: $1) }
                self.displayTransactions.accept(sections)
            }
            .disposed(by: disposeBag)
        
        getAccounts()
        
        self.accounts
            .asObservable()
            .subscribe { _ in
                self.displayNumberOfAccountsString.accept("\(self.accounts.value.count) accounts")
            }
            .disposed(by: disposeBag)
        
        getMonthlyBalance()

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
            let dailyExpenses = transactions.value.filter { $0.dateParsed == date && $0.type == .expense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedToTwoDigits()
            cumulativeSum.append((date.formatted(), sum))
        }
        
        return cumulativeSum
    }
}

extension TransactionListViewModel {
    private func getAccounts() {
        // TODO: -
        let value = [
            Account(), Account()
        ]
        accounts.accept(value)
    }
    private func getMonthlyBalance() {
        // TODO: -
        let monthlyBalance: Double = 2392.1
        displayMonthlyBalanceString.accept(monthlyBalance.toCurrencyString())
    }
}

// MARK: - Delegate
extension TransactionListViewModel {

}
