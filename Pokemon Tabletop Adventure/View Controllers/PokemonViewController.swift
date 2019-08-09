//
//  PokemonViewController.swift
//  P:TA Companion
//
//  Created by Ian Merryweather on 09/08/2019.
//  Copyright © 2019 Undersea Love. All rights reserved.
//

import UIKit

class PokemonViewController: BaseViewController {

    private let pokemon: Pokemon
    private let viewModel: BaseViewModel

    init(pokemon: Pokemon, viewModel: BaseViewModel) {
        self.pokemon = pokemon
        self.viewModel = viewModel

        super.init(with: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("\"\(#function)\" not implemented; check your code structure to see how this is being called!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = pokemon.name
    }
}
