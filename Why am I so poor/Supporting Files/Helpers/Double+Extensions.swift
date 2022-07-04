//
//  Double+Extensions.swift
//  Fastiee
//
//  Created by Mu Yu on 6/27/22.
//

import Foundation

extension Double {
    func roundOff(to numberOfDecimalPlaces: Double) -> Double {
        let base = pow(10, numberOfDecimalPlaces)
        return (self * base).rounded() / base
    }
    mutating func roundedOff(to numberOfDecimalPlaces: Double) {
        self = self.roundOff(to: numberOfDecimalPlaces)
    }
    
    func roundedToTwoDigits() -> Double {
        return (self * 100).rounded() / 100
    }
    func toCurrencyString(code: String? = nil) -> String {
        if let code = code {
            return self.formatted(.currency(code: code))
        }
        return self.formatted(.currency(code: CacheManager.shared.preferredCurrency))
    }
}
