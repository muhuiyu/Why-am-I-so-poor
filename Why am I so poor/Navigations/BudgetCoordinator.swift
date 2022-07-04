//
//  BudgetCoordinator.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit

class BudgetCoordinator: Coordinator {
    private weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    enum Destination {
        case viewBudgetDetail
    }
    
    init(navigationController: UINavigationController,
         parentCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        
    }
    
    private func navigate(to destination: Destination, presentModally: Bool) {
        guard let viewController = makeViewController(for: destination) else { return }
        if presentModally {
            navigationController?.present(viewController, animated: true)
        } else {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - ViewController List
extension BudgetCoordinator {
    private func makeViewController(for destination: Destination) -> ViewController? {
        // TODO: - Configure Navigation Bar
        
        switch destination {
        case .viewBudgetDetail:
            // TODO: - Add ViewController
            return ViewController()
        }
    }

}

// MARK: - Navigation
extension BudgetCoordinator {
    func showBudgetDetail() {
        self.navigate(to: .viewBudgetDetail, presentModally: false)
    }
}
