//
//  Transaction.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift

struct Transaction: Identifiable {
    var id: String
    var date: String
    var account: String
    var merchant: String
    var amount: Double
    let type: TransactionType
    var paymentBy: PaymentMethod
    var note: String = ""
    var categoryId: Int
    var category: Category
    var tag: TransactionTag
    var isRecurring: Bool
    
    // TODO: - fields (add "is this regular payment? pay on every month?")
    // let isPending: Bool
    // var isEdited: Bool
    
    enum EditableFields {
        case date
        case account
        case merchant
        case amount
        case paymentBy
        case category
        case isRecurring
        case note
        case tag
    }
}

// MARK: -
extension Transaction {
    var icon: UIImage? {
        if let category = Category.all.first(where: { $0.id == categoryId }) {
            return UIImage(systemName: category.iconName)
        }
        return Icons.get(.questionmark)
    }
    
    var dateParsed: Date {
        date.dateParsed()
    }
    
    var signedAmount: Double {
        type == .expense ? -amount : amount
    }
    
    var month: String {
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
    
    var day: String {
        dateParsed.formatted(.dateTime.year().month(.wide).day())
    }
}

// MARK: - Codable
extension Transaction: Codable {
    private struct TransactionData: Codable {
        var date: String
        var account: String
        var merchant: String
        let amount: Double
        let type: TransactionType
        var paymentBy: PaymentMethod
        var categoryId: Int
        var category: Category
        var isRecurring: Bool
        var note: String
        var tag: TransactionTag
        
        private enum CodingKeys: String, CodingKey {
            case date
            case account
            case merchant
            case amount
            case type
            case paymentBy
            case categoryId
            case category
            case isRecurring
            case note
            case tag
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            date = try container.decode(String.self, forKey: .date)
            account = try container.decode(String.self, forKey: .account)
            merchant = try container.decode(String.self, forKey: .merchant)
            amount = try container.decode(Double.self, forKey: .amount)
            type = try container.decode(TransactionType.self, forKey: .type)
            paymentBy = try container.decode(PaymentMethod.self, forKey: .paymentBy)
            categoryId = try container.decode(Int.self, forKey: .categoryId)
            category = try container.decode(Category.self, forKey: .category)
            isRecurring = try container.decode(Bool.self, forKey: .isRecurring)
            note = try container.decode(String.self, forKey: .note)
            tag = try container.decode(TransactionTag.self, forKey: .tag)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(date, forKey: .date)
            try container.encode(account, forKey: .account)
            try container.encode(merchant, forKey: .merchant)
            try container.encode(amount, forKey: .amount)
            try container.encode(type, forKey: .type)
            try container.encode(paymentBy, forKey: .paymentBy)
            try container.encode(categoryId, forKey: .categoryId)
            try container.encode(category, forKey: .category)
            try container.encode(isRecurring, forKey: .isRecurring)
            try container.encode(note, forKey: .note)
            try container.encode(tag, forKey: .tag)
        }
    }
    init(snapshot: DocumentSnapshot) throws {
        id = snapshot.documentID
        let data = try snapshot.data(as: TransactionData.self)
        date = data.date
        account = data.account
        merchant = data.merchant
        amount = data.amount
        type = data.type
        paymentBy = data.paymentBy
        categoryId = data.categoryId
        category = data.category
        isRecurring = data.isRecurring
        note = data.note
        tag = data.tag
    }
}

// MARK: - Enums
enum TransactionTag: String, Codable, CaseIterable {
    case smallBill = "smallBill"
    case bigBill = "bigBill"
    case dailyLiving = "dailyLiving"
}
enum TransactionType: String, Codable, CaseIterable {
    case expense = "expense"
    case income = "income"
    case transfer = "transfer"
}
enum PaymentMethod: String, Codable, CaseIterable {
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
                    account: "Mu",
                    merchant: "FairPrice",
                    amount: 20.2,
                    type: .expense,
                    paymentBy: .dbsAltitudeCard,
                    categoryId: 501,
                    category: .groceries,
                    tag: .dailyLiving,
                    isRecurring: false),
        Transaction(id: "2",
                    date: "07/18/2022",
                    account: "Mu",
                    merchant: "FairPrice",
                    amount: 23.1,
                    type: .expense,
                    paymentBy: .dbsAltitudeCard,
                    categoryId: 502,
                    category: .restaurants,
                    tag: .dailyLiving,
                    isRecurring: false),
        Transaction(id: "3",
                    date: "07/19/2022",
                    account: "Mu",
                    merchant: "Circle Life",
                    amount: 5.0,
                    type: .expense,
                    paymentBy: .ocbcBankTransfer,
                    categoryId: 201,
                    category: .mobilePhone,
                    tag: .smallBill,
                    isRecurring: false),
        Transaction(id: "4",
                    date: "07/19/2022",
                    account: "Mu",
                    merchant: "Wet Market",
                    amount: 293.0,
                    type: .expense,
                    paymentBy: .ocbcBankTransfer,
                    categoryId: 501,
                    category: .groceries,
                    tag: .dailyLiving,
                    isRecurring: false),
    ]
}
