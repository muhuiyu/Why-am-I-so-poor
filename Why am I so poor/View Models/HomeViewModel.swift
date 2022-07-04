//
//  HomeViewModel.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class HomeViewModel {
    private let disposeBag = DisposeBag()
    
    init() {
        
    }
}

extension HomeViewModel {
    // TODO: - Add localized string
    var displayTitle: String { "Home" }
}

// MARK: - Delegate
extension HomeViewModel {
    @objc
    func didTapOnNotification() {
        
    }
}
