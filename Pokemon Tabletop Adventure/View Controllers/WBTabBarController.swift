//
//  WBTabBarController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 09/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import UIKit

class WBTabBarController: UITabBarController {

    convenience init() {
        let pokédex = WBPokédexViewController()
        var icon = UIImage(named: "tabbar-items/pokédex")
        var tabBarItem = UITabBarItem(title: "Pokédex", image: icon, selectedImage: icon)
        pokédex.tabBarItem = tabBarItem

        let randomiser = WBRandomPokémonViewController(with: WBRandomPokémonViewModel())
        icon = UIImage(named: "tabbar-items/pokéball")
        tabBarItem = UITabBarItem(title: "Randomiser", image: icon, selectedImage: icon)
        randomiser.tabBarItem = tabBarItem

        self.init(with: [
            pokédex,
            randomiser
            ])
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
        fatalError("\"\(#function)\" not implemented; check your code structure to see how this is being called!")
    }
}
