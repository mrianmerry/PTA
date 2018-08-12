//
//  WBPokédexViewController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 10/08/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import SnapKit
import UIKit

class WBPokédexViewController: WBBaseViewController {
    /* Need to add label at the bottom to indicate logo author. HTML for this:
    <div>
        Icons made by <a href="https://www.flaticon.com/authors/those-icons" title="Those Icons">Those Icons</a> from <a
        href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a
        href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a>
     </div>
     */
    private let pokédexTableView = UITableView(frame: .zero, style: .grouped)

    var pokédexViewModel: WBPokédexViewModel

    override init(with viewModel: WBBaseViewModel) {
        let pokédexViewModel = viewModel as? WBPokédexViewModel ?? WBPokédexViewModel()
        self.pokédexViewModel = pokédexViewModel

        super.init(with: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("\"\(#function)\" not implemented; check your code structure to see how this is being called!")
    }

    override func setupViews() {
        super.setupViews()

        setupNavigationView()
        setupTableView()
    }

    private func setupNavigationView() {
        navigationItem.title = "Pokédex"
    }

    private func setupTableView() {
        pokédexTableView.backgroundColor = .white
        pokédexTableView.estimatedRowHeight = 44.0
        pokédexTableView.rowHeight = UITableViewAutomaticDimension
        pokédexTableView.dataSource = pokédexViewModel.tableManager
        pokédexTableView.delegate = pokédexViewModel.tableManager

        view.addSubview(pokédexTableView)
        pokédexTableView.snp.makeConstraints { make in
            make.topMargin.left.right.bottomMargin.equalToSuperview()
        }
    }
}
