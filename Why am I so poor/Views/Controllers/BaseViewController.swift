//
//  BaseViewController.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class BaseViewController: ViewController {
    
    // MARK: - Coordinators
    weak var appCoordinator: AppCoordinator?
    weak var homeCoordinator: HomeCoordinator?
    weak var budgetCoordinator: BudgetCoordinator?
    weak var meCoordinator: MeCoordinator?
    
    private lazy var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - View Config
extension BaseViewController {
    
}
