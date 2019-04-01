//
//  TabBarController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 09/07/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    convenience init() {
        let pokedex = PokedexViewController()
        var icon = UIImage(named: "tabbar-items/pokedex")
        var tabBarItem = UITabBarItem(title: "Pokedex", image: icon, selectedImage: icon)
        pokedex.tabBarItem = tabBarItem

        let randomiser = RandomPokemonViewController(with: RandomPokemonViewModel())
        icon = UIImage(named: "tabbar-items/pokeball")
        tabBarItem = UITabBarItem(title: "Randomiser", image: icon, selectedImage: icon)
        randomiser.tabBarItem = tabBarItem

        self.init(with: [
            pokedex,
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
