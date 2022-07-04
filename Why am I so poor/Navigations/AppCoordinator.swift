//
//  AppCoordinator.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class AppCoordinator: Coordinator {
    private let window: UIWindow
    
    var childCoordinators = [Coordinator]()
    private(set) var navigationController: UINavigationController?
    private(set) var mainTabBarController: MainTabBarController?
    private(set) var loadingScreenController: LoadingScreenViewController?
    
    // TODO: - Add some managers here (userSessionManager, cacheManager)
    private let cacheManager = CacheManager.shared
    
    private var homeCoordinator: HomeCoordinator?
    private var budgetCoordinator: BudgetCoordinator?
    private var meCoordinator: MeCoordinator?

    init?(window: UIWindow?) {
        guard let window = window else { return nil }
        self.window = window
    }

    func start() {
        window.rootViewController = rootViewController()
        window.makeKeyAndVisible()
        
        mainTabBarController = MainTabBarController()
        mainTabBarController?.appCoordinator = self
        configureCoordinators()
    }
}

// MARK: - UI Setup
extension AppCoordinator {
    private func rootViewController() -> UINavigationController {
        // TODO: - Add LoadingScreenViewController
        let viewController = LoadingScreenViewController()
        viewController.appCoordinator = self
        self.loadingScreenController = viewController
        
        let navigationViewController = UINavigationController()
        navigationViewController.pushViewController(viewController, animated: false)
//        navigationViewController.setNavigationBarHidden(true, animated: false)
        self.navigationController = navigationViewController
        return navigationViewController
    }
    private func configureCoordinators() {
        guard let navigationController = navigationController else { return }
        
        self.homeCoordinator = HomeCoordinator(navigationController: navigationController,
                                               parentCoordinator: self)
        
        self.budgetCoordinator = BudgetCoordinator(navigationController: navigationController,
                                                   parentCoordinator: self)
        
        self.meCoordinator = MeCoordinator(navigationController: navigationController,
                                           parentCoordinator: self)
    }
    private func configureMainTabBar() {
        mainTabBarController?.appCoordinator = self
        mainTabBarController?.homeCoordinator = homeCoordinator
        mainTabBarController?.budgetCoordinator = budgetCoordinator
        mainTabBarController?.meCoordinator = meCoordinator
        mainTabBarController?.configureTabBarItems()
    }
}

// MARK: - Generic Navigation
extension AppCoordinator {
    private func shouldRefreshRoot(with viewController: UIViewController) -> Bool {
        guard let navigationController = navigationController else { return false }
        
        // Handles the transition when searching contents
        if let presentedViewController = navigationController.presentationController,
           (type(of: presentedViewController) == UINavigationController.self) {
            return true
        }
        
        // TODO: - Handles the transition when the visible screen is (1) a UITabViewController
        
        return false
    }
    private func handleRootchange(navigationController: UINavigationController, viewController: UIViewController, animated: Bool) {
        if let tabBarController = viewController as? MainTabBarController {
            mainTabBarController = tabBarController
//            navigationController.setNavigationBarHidden(true, animated: false)
            configureMainTabBar()
        }
        navigationController.setViewControllers([viewController], animated: animated)
    }
    func show(_ viewController: UIViewController, forceReplace: Bool = false, animated: Bool = true) {
        guard let navigationViewController = navigationController else { return }
        
        if forceReplace || shouldRefreshRoot(with: viewController) {
            handleRootchange(navigationController: navigationViewController,
                             viewController: viewController,
                             animated: animated)
        }
    }
}

// MARK: - Navigation
extension AppCoordinator {
    func showHome(forceReplace: Bool = false, animated: Bool = true) {
        show(mainTabBarController ?? MainTabBarController(), forceReplace: forceReplace, animated: animated)
    }
    func showLoadingScreen(forceReplace: Bool = false) {
        
    }
    func showLogin() {
        
    }
}
