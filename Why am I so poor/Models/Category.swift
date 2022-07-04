//
//  Category.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
    let iconName: String
    var mainCategoryId: Int?
    var monthlyBudget: Double = 0
}

extension Category {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case iconName
        case mainCategoryId
        case monthlyBudget
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        iconName = try container.decode(String.self, forKey: .iconName)
        mainCategoryId = try container.decode(Int.self, forKey: .mainCategoryId)
        monthlyBudget = try container.decode(Double.self, forKey: .monthlyBudget)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(iconName, forKey: .iconName)
        try container.encode(mainCategoryId, forKey: .mainCategoryId)
        try container.encode(monthlyBudget, forKey: .monthlyBudget)
    }
}

extension Category {
    static let autoAndTransport = Category(id: 1, name: "Auto & Transport", iconName: "car")
    static let billsAndUtilities = Category(id: 2, name: "Bills & Utilities", iconName: "dollarsign.square")
    static let entertainment = Category(id: 3, name: "Entertainment", iconName: "film")
    static let feeAndCharges = Category(id: 4, name: "Fees & Charges", iconName: "banknote")
    static let foodAndDining = Category(id: 5, name: "Food & Dining", iconName: "fork.knife")
    static let home = Category(id: 6, name: "Home", iconName: "house")
    static let income = Category(id: 7, name: "Income", iconName: "dollarsign.circle")
    static let shopping = Category(id: 8, name: "Shopping", iconName: "cart")
    static let transfer = Category(id: 9, name: "Transfer", iconName: "arrow.2.squarepath")
    
    static let publicTransportation = Category(id: 101, name: "Public Transportation", iconName: "bus", mainCategoryId: 1)
    static let taxi = Category(id: 102, name: "Taxi", iconName: "car", mainCategoryId: 1)
    static let mobilePhone = Category(id: 201, name: "Mobile Phone", iconName: "iphone.homebutton", mainCategoryId: 2)
    static let movieAndDVDs = Category(id: 301, name: "Movies & DVDs", iconName: "film", mainCategoryId: 3)
    static let bankFee = Category(id: 401, name: "Finance Charge", iconName: "banknote", mainCategoryId: 4)
    static let groceries = Category(id: 501, name: "Groceries", iconName: "bag", mainCategoryId: 5)
    static let restaurants = Category(id: 502, name: "Restaurants", iconName: "fork.knife", mainCategoryId: 5)
    static let rent = Category(id: 601, name: "Rent", iconName: "house", mainCategoryId: 6)
    static let homeSupplies = Category(id: 602, name: "Home Supplies", iconName: "lightbulb", mainCategoryId: 6)
    static let paycheque = Category(id: 701, name: "Paycheque", iconName: "giftcard", mainCategoryId: 7)
    static let software = Category(id: 801, name: "Software", iconName: "server.rack", mainCategoryId: 8)
    static let creditCardPayment = Category(id: 901, name: "Credit Card Payment", iconName: "creditcard", mainCategoryId: 9)
}

extension Category {
    static let categories: [Category] = [
        .autoAndTransport,
        .billsAndUtilities,
        .entertainment,
        .feeAndCharges,
        .foodAndDining,
        .home,
        .income,
        .shopping,
        .transfer
    ]
    
    static let subcategroreis: [Category] = [
        .publicTransportation,
        .taxi,
        .mobilePhone,
        .movieAndDVDs,
        .bankFee,
        .groceries,
        .restaurants,
        .rent,
        .homeSupplies,
        .paycheque,
        .software,
        .creditCardPayment
    ]
    
    static let all: [Category] = categories + subcategroreis
}
