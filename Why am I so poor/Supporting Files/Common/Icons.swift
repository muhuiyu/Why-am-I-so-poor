//
//  Icons.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import UIKit

class Icons {
    static func get(_ name: IconName, isFilled: Bool = false) -> UIImage? {
        let systemName: String = name.rawValue + ( isFilled ? ".fill" : "" )
        return UIImage(systemName: systemName)
    }
    
    enum IconName: String {
        case plus = "plus"
        case plusCircle = "plus.circle"
        case home = "house"
        case creditcard = "creditcard"
        case creditcardCircle = "creditcard.circle"
        case pencil = "pencil"
        case cart = "cart"
        case giftcard = "giftcard"
        case questionmark = "questionmark"
        case dollarsignCircle = "dollarsign.circle"
        case person = "person"
        case plusminus = "plusminus"
        case plusminusCircle = "plusminus.circle"
        case bellbadge = "bellbadge"
        case tag = "tag"
        case xmark = "xmark"
    }
}
