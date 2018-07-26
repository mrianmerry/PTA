//
//  WBTabBarController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 09/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import UIKit

class WBTabBarController: UITabBarController {

//    let randomiser: WBRandomPokémonViewController
    
    convenience init() {
        let randomiser = WBRandomPokémonViewController(with: WBRandomPokémonViewModel())
        // TODO: Fix Icon size being WAAAAY too large
        let unselected = UIImage(named: "tabbar-items/pokeball-unselected")
        let selected = UIImage(named: "tabbar-items/pokeball-selected")
        
        let tabBarItem = UITabBarItem(title: nil, image: unselected, selectedImage: selected)
        randomiser.tabBarItem = tabBarItem
        
        let blankVC = UIViewController()
        blankVC.view.backgroundColor = .white
        blankVC.title = "blank"

        self.init(with: [randomiser, blankVC])
    }
    
    init(with viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        
        setup(with: viewControllers)
    }
    
    private func setup(with viewControllers: [UIViewController]) {
        let tabNavigationControllers = viewControllers.map { return UINavigationController(rootViewController: $0) }
        self.viewControllers = tabNavigationControllers
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\"init?(coder aDecoder: NSCoder)\" not implemented; check your code structure to see how this is being called!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
