//
//  TransactionEditViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import UIKit

class TransactionEditFieldViewModel {
    
    var field: Transaction.EditableFields? {
        didSet {
            configureVariables()
        }
    }
    
    private var options: [String] = []
    private var placeholder: String = ""
    
    var displayOptions: [String] {
        guard let field = field else {
            return []
        }
        return options
    }
    var displayPlaceholder: String {
        guard let field = field else {
            return ""
        }
        return placeholder
    }
    
    init() {
        
    }
}

extension TransactionEditFieldViewModel {
    private func configureVariables() {
        guard let field = field else { return }
        
        switch field {
        case .paymentBy:
        }
    }

}

