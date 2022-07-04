//
//  Budget.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit

struct Budget {
    var category: Category
    var categoryId: Int
    var amount: Double
}

extension Budget: Codable {
    private enum CodingKeys: String, CodingKey {
        case category
        case categoryId
        case amount
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        category = try container.decode(Category.self, forKey: .category)
        categoryId = try container.decode(Int.self, forKey: .categoryId)
        amount = try container.decode(Double.self, forKey: .amount)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(category, forKey: .category)
        try container.encode(categoryId, forKey: .categoryId)
        try container.encode(amount, forKey: .amount)
    }
}

extension Budget {
    var icon: UIImage? {
        if let category = Category.all.first(where: { $0.id == categoryId }) {
            return UIImage(systemName: category.iconName)
        }
        return UIImage(systemName: "questionmark")
    }
    
    var total: Double { return 0 }
    var monthlyAverage: Double { return 452.05 }
    var remainingAmount: Double { return 201.40 }
    var status: BudgetState { return .budget }
    
    func getTransactions() -> [Transaction] {
        return []
    }
}

enum BudgetState {
    case under
    case budget
    case over
}

extension Budget {
    static let testEntries: [Budget] = [
        Budget(category: .foodAndDining, categoryId: 5, amount: 200),
        Budget(category: .home, categoryId: 6, amount: 1030),
        Budget(category: .billsAndUtilities, categoryId: 2, amount: 50),
    ]
}
