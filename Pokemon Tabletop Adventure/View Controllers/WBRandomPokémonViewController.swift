//
//  WBRandomPokémonViewController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 09/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import UIKit
import SnapKit

class WBRandomPoke_monViewController: WBBaseViewController {
    
    var randomViewModel: WBRandomPokémonViewModel? {
        return viewModel as? WBRandomPokémonViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupViews() {
        super.setupViews()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let randomPokémon = UIBarButtonItem(title: "Random 'mon", style: .plain, target: self, action: #selector(showRandomPokémon))
        navigationItem.rightBarButtonItem = randomPokémon
        navigationItem.title = "Base View Controller"
    }
    
    @objc private func showRandomPokémon() {
        guard let chosenPokémon: Pokémon = randomViewModel?.getRandomPokémon() else {
            print("Unable to get pokémon data.")
            return
        }
        
        print("Choosing pokémon #\(chosenPokémon.dexNumber) - \(chosenPokémon.name)")
    }
}
