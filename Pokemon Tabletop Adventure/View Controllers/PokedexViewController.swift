//
//  PokedexViewController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 10/08/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import RxCocoa
import RxRelay
import SafariServices
import UIKit

class PokedexViewController: BaseViewController {
    private let pokedexTableView = UITableView(frame: .zero, style: .plain)

    var pokedexViewModel: PokedexViewModel

    override init(with viewModel: BaseViewModel) {
        let pokedexViewModel = viewModel as? PokedexViewModel ?? PokedexViewModel()
        self.pokedexViewModel = pokedexViewModel

        super.init(with: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("\"\(#function)\" not implemented; check your code structure to see how this is being called!")
    }
    
    override func setupViews() {
        super.setupViews()

        bindViewModel()
        setupNavigationView()
        setupTableView()
    }
}

// MARK: Setup
private extension PokedexViewController {
    func setupNavigationView() {
        navigationItem.title = pokedexViewModel.pokemonSorting.sortTitle

        let toggle = UIBarButtonItem(title: "Toggle 'dex", style: .plain, target: nil, action: nil)
        toggle.rx.tap.bind { self.sortPokedex() }.disposed(by: disposeBag)
        navigationItem.rightBarButtonItem = toggle
    }

    func setupTableView() {
        pokedexTableView.translatesAutoresizingMaskIntoConstraints = false
        pokedexTableView.dataSource = pokedexViewModel.tableManager
        pokedexTableView.delegate = pokedexViewModel.tableManager
        pokedexTableView.rowHeight = UITableView.automaticDimension
        pokedexTableView.backgroundColor = .lightGray
        pokedexTableView.estimatedRowHeight = 44.0
        pokedexTableView.tableFooterView = UIView()

        view.addSubview(pokedexTableView)
        let layoutGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            pokedexTableView.heightAnchor.constraint(equalTo: layoutGuide.heightAnchor),
            pokedexTableView.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
            pokedexTableView.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor),
            pokedexTableView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor)
        ])
    }
}

// MARK: Behaviour
private extension PokedexViewController {
    func bindViewModel() {
        pokedexViewModel.selectedPokemon.bind { selected in
            guard let selected = selected else { return }
            let pokemon = PokemonViewController(pokemon: selected, viewModel: BaseViewModel())

            self.navigationController?.pushViewController(pokemon, animated: true)
        }.disposed(by: disposeBag)
    }

    func sortPokedex() {
        pokedexViewModel.toggleSort()
        navigationItem.title = pokedexViewModel.pokemonSorting.sortTitle
        pokedexTableView.reloadData()
    }
}
