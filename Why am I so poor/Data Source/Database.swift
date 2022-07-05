//
//  Database.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import Foundation
import UIKit

class Database {
    static let shared = Database()
    
    init() {
        
    }
}

// MARK: - Fetch
extension Database {
    // month: 1-12
    func getMonthlyTransactions(in month: Int, of category: Category? = nil) -> [Transaction] {
        // TODO: - Link to Firebase
        if let category = category {
            return Transaction.testEntries
        }
        return Transaction.testEntries
    }
    func getDailyTransactions(on date: Date, of category: Category? = nil) -> [Transaction] {
        // TODO: - Link to Firebase
        return Transaction.testEntries
    }
    func getBudgetList() -> [Budget] {
        // TODO: - Link to Firebase
        return Budget.testEntries
    }
}

// MARK: - Calculation
extension Database {
    func sum(of transactions: [Transaction]) -> Double {
        return transactions.reduce(0) { $0 + $1.signedAmount }
    }
}
