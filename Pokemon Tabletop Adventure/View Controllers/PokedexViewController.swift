//
//  PokedexViewController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 10/08/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

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
        // I'm not sure why this is needed to get rid of the red tint coming through from RootViewController :/
        view.backgroundColor = .white

        setupNavigationView()
        setupTableView()
    }

    private func setupNavigationView() {
        navigationItem.title = pokedexViewModel.pokemonSorting.sortTitle
    }

    private func setupTableView() {
        pokedexTableView.translatesAutoresizingMaskIntoConstraints = false
        pokedexTableView.dataSource = pokedexViewModel.tableManager
        pokedexTableView.delegate = pokedexViewModel.tableManager
        pokedexTableView.rowHeight = UITableView.automaticDimension
        pokedexTableView.backgroundColor = .lightGray
        pokedexTableView.estimatedRowHeight = 44.0
        pokedexTableView.tableFooterView = UIView()

        view.addSubview(pokedexTableView)
        let layoutGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate(
            [pokedexTableView.heightAnchor.constraint(equalTo: layoutGuide.heightAnchor),
             pokedexTableView.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
             pokedexTableView.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor),
             pokedexTableView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor)]
        )
    }
}
