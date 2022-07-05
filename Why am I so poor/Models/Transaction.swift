//
//  Transaction.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit

struct Transaction: Identifiable {
    var id: String
    var date: String
    var institution: String
    var account: String
    var merchant: String
    let amount: Double
    let type: TransactionType      // need to remove
    var paymentBy: PaymentMethod
    // TODO: - add "is this regular payment? pay on every month?"
    
    var categoryId: Int
    var category: Category
    var isRecurring: Bool
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    var note: String = ""
    
    // TODO: - Define expenseTag
    var expenseTag: ExpenseTag
    
    var icon: UIImage? {
        if let category = Category.all.first(where: { $0.id == categoryId }) {
            return UIImage(systemName: category.iconName)
        }
        return UIImage(systemName: "questionmark")
    }
    
    var dateParsed: Date {
        date.dateParsed()
    }
    
    var signedAmount: Double {
        return type.rawValue == TransactionType.credit.rawValue ? amount : -amount
    }
    
    var month: String {
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
    
    var day: String {
        dateParsed.formatted(.dateTime.year().month(.wide).day())
    }
}

extension Transaction: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case date
        case institution
        case account
        case merchant
        case amount
        case type
        case paymentBy
        case categoryId
        case category
        case isRecurring
        case isPending
        case isTransfer
        case isExpense
        case isEdited
        case note
        case expenseTag
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID().uuidString
        date = try container.decode(String.self, forKey: .date)
        institution = try container.decode(String.self, forKey: .institution)
        account = try container.decode(String.self, forKey: .account)
        merchant = try container.decode(String.self, forKey: .merchant)
        amount = try container.decode(Double.self, forKey: .amount)
        type = try container.decode(TransactionType.self, forKey: .type)
        paymentBy = try container.decode(PaymentMethod.self, forKey: .paymentBy)
        categoryId = try container.decode(Int.self, forKey: .categoryId)
        category = try container.decode(Category.self, forKey: .category)
        isRecurring = try container.decode(Bool.self, forKey: .isRecurring)
        isPending = try container.decode(Bool.self, forKey: .isPending)
        isTransfer = try container.decode(Bool.self, forKey: .isTransfer)
        isExpense = try container.decode(Bool.self, forKey: .isExpense)
        isEdited = try container.decode(Bool.self, forKey: .isEdited)
        note = try container.decode(String.self, forKey: .note)
        expenseTag = try container.decode(ExpenseTag.self, forKey: .expenseTag)
    }
}


extension Transaction {
    // TODO: - need to prevent other users from updating the amount?
    mutating func updateNote(to newContent: String) {
        self.note = newContent
    }
}

extension Transaction {
    enum ExpenseTag: String, Codable {
        case smallBill = "smallBill"
        case bigBill = "bigBill"
        case dailyLiving = "dailyLiving"
    }
}

enum TransactionType: String, Codable {
    case debit = "debit"
    case credit = "credit"
}

enum PaymentMethod: String, Codable {
    case ocbcBankTransfer = "OCBC Bank Transfer"
    case dbsBankTransfer = "DBS Bank Transfer"
    case amexTrueCashbackCard = "Amex True Cashback Card"
    case grabPayCard = "GrabPay Card"
    case dbsAltitudeCard = "DBS Altitude Card"
    case jiPayCard = "jiPay Card"
    case ezLinkCard = "EZLink Card"
    case revolutCard = "Revolut Card"
    case cash = "Cash"
}

extension Transaction {
    static let testEntries: [Transaction] = [
        Transaction(id: "1",
                    date: "06/17/2022",
                    institution: "DBS",
                    account: "Mu",
                    merchant: "FairPrice",
                    amount: 20.2,
                    type: .debit,
                    paymentBy: .dbsAltitudeCard,
                    categoryId: 501,
                    category: .groceries,
                    isRecurring: false,
                    isPending: false,
                    isTransfer: false,
                    isExpense: true,
                    isEdited: false,
                    expenseTag: .dailyLiving),
        Transaction(id: "2",
                    date: "07/18/2022",
                    institution: "DBS",
                    account: "Mu",
                    merchant: "FairPrice",
                    amount: 23.1,
                    type: .debit,
                    paymentBy: .dbsAltitudeCard,
                    categoryId: 502,
                    category: .restaurants,
                    isRecurring: false,
                    isPending: false,
                    isTransfer: false,
                    isExpense: true,
                    isEdited: false,
                    expenseTag: .dailyLiving),
        Transaction(id: "3",
                    date: "07/19/2022",
                    institution: "OCBC",
                    account: "Mu",
                    merchant: "Circle Life",
                    amount: 5.0,
                    type: .debit,
                    paymentBy: .ocbcBankTransfer,
                    categoryId: 201,
                    category: .mobilePhone,
                    isRecurring: true,
                    isPending: false,
                    isTransfer: false,
                    isExpense: true,
                    isEdited: false,
                    expenseTag: .smallBill),
        Transaction(id: "4",
                    date: "07/19/2022",
                    institution: "OCBC",
                    account: "Mu",
                    merchant: "Web Market",
                    amount: 293.0,
                    type: .debit,
                    paymentBy: .ocbcBankTransfer,
                    categoryId: 501,
                    category: .groceries,
                    isRecurring: false,
                    isPending: false,
                    isTransfer: false,
                    isExpense: true,
                    isEdited: false,
                    expenseTag: .dailyLiving),
    ]
}
