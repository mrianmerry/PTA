//
//  RootCoordinator.swift
//  PTA Companion
//
//  Created by Ian Merryweather on 10/06/2021.
//  Copyright © 2021 Undersea Love. All rights reserved.
//

import UIKit

final class RootCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var router: UINavigationController
    
    init(router: UINavigationController) {
        router.setNavigationBarHidden(true, animated: false)
        self.router = router
    }
    
    func start() {
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
    func preliminaryLoadingCompleted() {
        router.crossDissolveViewController(tabBarController, replaceOldViewControllers: true)
    }
    
    var preliminaryLoadingViewController: PreliminaryLoadingViewController {
        let viewModel = PreliminaryLoadingViewModel(actionDelegate: self)
        let controller = PreliminaryLoadingViewController(loadable: viewModel)
        controller.actionDelegate = self
        
        return controller
    }
    
    var tabBarController: TabBarController {
        TabBarController()
    }
}
