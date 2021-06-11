//
//  Coordinator.swift
//  PTA Companion
//
//  Created by Ian Merryweather on 10/06/2021.
//  Copyright © 2021 Undersea Love. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    var router: Router { get }
    
    func start()
}

extension Coordinator {
    func launch(_ viewController: UIViewController) {
        if router.viewControllers.contains(viewController) {
            router.popToViewController(viewController, animated: true)
        } else {
            router.pushViewController(viewController, animated: true)
        }
    }
}
