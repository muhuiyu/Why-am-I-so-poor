//
//  Localized.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import Foundation

struct Localized {
    static var AppName: String { "APPNAME".localized }
}

// MARK: - Loading Screen
extension Localized {
    struct Loading {
        static var title: String { "Loading".localized }
    }
}

// MARK: - Main Tab Bar
extension Localized {
    struct MainTab {
        static var home: String { "MainTab.Home".localized }
        static var budget: String { "MainTab.Budget".localized }
        static var me: String { "MainTab.Me".localized }
    }
}

// MARK: - Home
extension Localized {
    struct Home {
        
    }
}

// MARK: - Transaction
extension Localized {
    struct TransactionList {
        static var recentTransactions: String { "TransactionList.RecentTransactions".localized }
        static var seeAll: String { "TransactionList.SeeAll".localized }
    }
    
    struct TransactionDetail {
        static var category: String { "TransactionDetail.Category".localized }
        static var paymentBy: String { "TransactionDetail.PaymentBy".localized }
        static var expenseTag: String { "TransactionDetail.ExpenseTag".localized }
        static var note: String { "TransactionDetail.Note".localized }
        static var addNote: String { "TransactionDetail.AddNote".localized }
    }
}

// MARK: - Budget
extension Localized {
    struct Budget {
        static var editBudget: String { "Budget.EditBudget".localized }
        static var editBudgetTitle: String { "Budget.EditBudgetTitle".localized }
    }
}

// MARK: - Language
extension Localized {
    struct Language {
        static var Title: String { "Language.Title".localized }
        static var en: String { "Language.en".localized }
        static var ja: String { "Language.ja".localized }
        static var vi: String { "Language.vi".localized }
        static var changeLanguage: String { "Language.changeLanguage".localized }
    }
}
