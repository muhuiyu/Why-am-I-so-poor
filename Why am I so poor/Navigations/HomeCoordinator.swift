//
//  HomeCoordinator.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class HomeCoordinator: Coordinator {
    private weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    enum Destination {
        case viewTransactionList
        case viewTransactionDetail(Transaction)
        case editTransactionPaymentMethod(Transaction)
        case editTransactionCategory(Transaction)
        case editTransactionTag(Transaction)
        case editTransactionNote(Transaction)
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
extension HomeCoordinator {
    private func makeViewController(for destination: Destination) -> ViewController? {
        // TODO: - Configure Navigation Bar
        
        switch destination {
        case .viewTransactionList:
            let viewController = TransactionListViewController()
            viewController.homeCoordinator = self
            return viewController
        case .viewTransactionDetail(let transaction):
            let viewController = TransactionDetailViewController()
            viewController.homeCoordinator = self
            viewController.viewModel.transaction.accept(transaction)
            return viewController
        case .editTransactionPaymentMethod(let transaction):
            let viewController = TransactionEditTextPropertyViewController()
            viewController.homeCoordinator = self
            // TODO: - set viewModel value
            return viewController
        case .editTransactionCategory(let transaction):
            let viewController = TransactionEditTextPropertyViewController()
            viewController.homeCoordinator = self
            // TODO: - set viewModel value
            return viewController
        case .editTransactionTag(let transaction):
            let viewController = TransactionEditTextPropertyViewController()
            viewController.homeCoordinator = self
            // TODO: - set viewModel value
            return viewController
        case .editTransactionNote(let transaction):
            let viewController = TransactionEditTextPropertyViewController()
            viewController.homeCoordinator = self
            // TODO: - set viewModel value
            return viewController
        }
    }

}

// MARK: - Navigation
extension HomeCoordinator {
    func showTransactionList() {
        self.navigate(to: .viewTransactionList, presentModally: false)
    }
    func showTransactionDetail(_ transaction: Transaction) {
        self.navigate(to: .viewTransactionDetail(transaction), presentModally: false)
    }
    func editTransactionPaymentMethod(_ transaction: Transaction) {
        self.navigate(to: .editTransactionPaymentMethod(transaction), presentModally: true)
    }
    func editTransactionCategory(_ transaction: Transaction) {
        self.navigate(to: .editTransactionCategory(transaction), presentModally: true)
    }
    func editTransactionTag(_ transaction: Transaction) {
        self.navigate(to: .editTransactionTag(transaction), presentModally: true)
    }
    func editTransactionNote(_ transaction: Transaction) {
        self.navigate(to: .editTransactionNote(transaction), presentModally: true)
    }
}
