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
        case editTransactionField(Transaction, Transaction.EditableFields)
        case addTransaction
        case editBudgets
        case viewBudgetDetail(Budget)
    }
    
    init(navigationController: UINavigationController,
         parentCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        
    }
    
    private func navigate(to destination: Destination, presentModally: Bool, options: ModalOptions? = nil) {
        guard let viewController = makeViewController(for: destination) else { return }
        if presentModally {
            if let options = options {
                viewController.modalPresentationStyle = options.modalPresentationStyle
                viewController.isModalInPresentation = options.isModalInPresentation
                if options.isEmbedInNavigationController {
                    navigationController?.present(viewController.embedInNavgationController(), animated: true)
                } else {
                    navigationController?.present(viewController, animated: true)
                }
            } else {
                navigationController?.present(viewController, animated: true)
            }
        } else {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    struct ModalOptions {
        let isEmbedInNavigationController: Bool
        let modalPresentationStyle: UIModalPresentationStyle
        let isModalInPresentation: Bool
        
        init(isEmbedInNavigationController: Bool = false,
             modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
             isModalInPresentation: Bool = false) {
            self.isEmbedInNavigationController = isEmbedInNavigationController
            self.modalPresentationStyle = modalPresentationStyle
            self.isModalInPresentation = isModalInPresentation
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
        case .editTransactionField(let transaction, let field):
            let viewController = TransactionEditFieldViewController()
            viewController.homeCoordinator = self
            // TODO: - set viewModel value
            return viewController
        case .addTransaction:
            let viewController = AddTransactionViewController()
            viewController.homeCoordinator = self
            return viewController
        case .editBudgets:
            let viewController = EditBudgetViewController()
            viewController.homeCoordinator = self
            return viewController
        case .viewBudgetDetail(let budget):
            let viewController = BudgetDetailViewController()
            viewController.viewModel.budget.accept(budget)
            viewController.homeCoordinator = self
            return viewController
        }
    }

}

// MARK: - Navigation
extension HomeCoordinator {
    func dismissCurrentModal() {
        navigationController?.dismiss(animated: true)
    }
    // MARK: - Transaction List
    func showTransactionList() {
        self.navigate(to: .viewTransactionList, presentModally: false)
    }
    func showTransactionDetail(_ transaction: Transaction) {
        self.navigate(to: .viewTransactionDetail(transaction), presentModally: false)
    }
    // MARK: - Edit Transaction List
    func showEditTransactionFieldOptionList(_ transaction: Transaction, field: Transaction.EditableFields) {
        self.navigate(to: .editTransactionField(transaction, field), presentModally: false)
    }
    // MARK: - Add Transactions
    func showAddTransaction() {
        let options = ModalOptions(isEmbedInNavigationController: true, isModalInPresentation: true)
        self.navigate(to: .addTransaction, presentModally: true, options: options)
    }
    // MARK: - Budget
    func showEditBudget() {
        self.navigate(to: .editBudgets, presentModally: false)
    }
    func showBudgetDetail(_ budget: Budget) {
        self.navigate(to: .viewBudgetDetail(budget), presentModally: false)
    }
}
