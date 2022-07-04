//
//  MeCoordinator.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class MeCoordinator: Coordinator {
    private weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController,
         parentCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        
    }
}
