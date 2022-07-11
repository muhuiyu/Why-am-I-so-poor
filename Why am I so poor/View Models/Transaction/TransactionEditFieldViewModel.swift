//
//  TransactionEditViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import UIKit

class TransactionEditFieldViewModel {

    var options: [String] = []
    
    private let transactionId: String
    private let field: Transaction.EditableFields
    private var selectedOption: String = ""

    init(transactionId: String, field: Transaction.EditableFields) {
        self.transactionId = transactionId
        self.field = field
        configureOptionsData()
    }
}

extension TransactionEditFieldViewModel {
    func didSelect(_ option: String) {
        selectedOption = option
    }
    func updateField() {
        Database.shared.updateData(at: transactionId, field, to: selectedOption) { result in
            switch result {
            case .success:
                return
            case .failure(let error):
                print(error)
            }
        }
    }
    private func configureOptionsData() {
        switch field {
        case .paymentBy:
            options = PaymentMethod.allCases.map { $0.rawValue }
        case .merchant:
            options = Database.shared.getAllMerchants()
        case .category:
            options = Category.allToString
        case .tag:
            options = TransactionTag.allCases.map { $0.rawValue }
        default:
            // do something here
            return
        }
    }
}

