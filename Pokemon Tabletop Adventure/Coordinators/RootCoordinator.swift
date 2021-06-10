//
//  RootCoordinator.swift
//  PTA Companion
//
//  Created by Ian Merryweather on 10/06/2021.
//  Copyright © 2021 Undersea Love. All rights reserved.
//

import UIKit

class RootCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var router: UINavigationController
    
    init(router: UINavigationController) {
        self.router = router
    }
    
    func start() {
        launch(rootViewController)
    }
}

private extension RootCoordinator {
    func launch(_ viewController: UIViewController) {
        if router.viewControllers.contains(viewController) {
            router.popToViewController(viewController, animated: true)
        } else {
            router.pushViewController(viewController, animated: true)
        }
    }
    
    var rootViewController: RootViewController {
        RootViewController()
    }
}
