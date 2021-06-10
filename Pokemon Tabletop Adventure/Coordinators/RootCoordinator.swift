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
        router.setNavigationBarHidden(true, animated: false)
        launch(preliminaryLoadingViewController)
    }
}

extension RootCoordinator: ActionDelegate {
    func respondToAction(_ action: Action) {
        switch action {
        case .preliminaryLoadingCompleted:
            preliminaryLoadingCompleted()
        }
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
    
    func preliminaryLoadingCompleted() {
        print("PRELIMINARY LOADING COMPLETED! YEY!")
    }
    
    var preliminaryLoadingViewController: PreliminaryLoadingViewController {
        let viewModel = PreliminaryLoadingViewModel(actionDelegate: self)
        let controller = PreliminaryLoadingViewController(loadable: viewModel)
        controller.actionDelegate = self
        
        return controller
    }
    
    var rootViewController: RootViewController {
        RootViewController()
    }
}
