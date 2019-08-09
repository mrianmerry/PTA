//
//  RootViewController.swift
//  P:TA Companion
//
//  Created by Ian Merryweather on 27/03/2019.
//  Copyright © 2019 Undersea Love. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    required init?(coder aDecoder: NSCoder) {
        fatalError("Please check your implementation, \(#function) should not be called.")
    }

    var currentContext: UIViewController
    var contexts: [UIViewController]

    init() {
        currentContext = PreliminaryLoadingViewController()
        contexts = []

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(currentContext)
        view.addSubview(currentContext.view)

        updateAppearance()
        currentContext.willMove(toParent: self)
    }

    private func updateAppearance() {
        let backgroundColor: UIColor = .logo
        view.backgroundColor = backgroundColor
        children.forEach { $0.view.backgroundColor = backgroundColor }
    }

    func splashDidFinish() {
        let target = TabBarController()
        contexts = [target]

        let animationOptions: UIView.AnimationOptions = [.curveEaseOut, .transitionCrossDissolve]
        currentContext.willMove(toParent: nil)
        addChild(target)
        transition(from: currentContext, to: target, duration: 0.3, options: animationOptions, animations: nil) { [weak self] completed in
            guard completed, let self = self else { return }

            self.currentContext.removeFromParent()
            self.currentContext = target
            target.didMove(toParent: self)
        }
    }
}
