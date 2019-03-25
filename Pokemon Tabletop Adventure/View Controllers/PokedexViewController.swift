//
//  PokedexViewController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 10/08/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import SafariServices
import UIKit

class PokedexViewController: BaseViewController {
    // Need to add a label at the bottom to indicate logo author. HTML for this:
    private static let iconCredits = "Icons made by <a href=\"https://www.flaticon.com/authors/those-icons\" title=\"Those Icons\">Those Icons</a> from <a href=\"https://www.flaticon.com/\" title=\"Flaticon\">www.flaticon.com</a> is licensed by <a href=\"http://creativecommons.org/licenses/by/3.0/\" title=\"Creative Commons BY 3.0\" target=\"_blank\">CC 3.0 BY</a>" // swiftlint:disable:this line_length
    let credits = UITextView(frame: .zero)
    
    private let pokedexTableView = UITableView(frame: .zero, style: .grouped)

    var pokedexViewModel: PokedexViewModel

    override init(with viewModel: BaseViewModel, credits: String? = nil) {
        let pokedexViewModel = viewModel as? PokedexViewModel ?? PokedexViewModel()
        self.pokedexViewModel = pokedexViewModel

        self.credits.attributedText = (credits ?? PokedexViewController.iconCredits).html
        super.init(with: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("\"\(#function)\" not implemented; check your code structure to see how this is being called!")
    }
    
    override func setupViews() {
        view.backgroundColor = .lightGray

        setupNavigationView()
        setupTableView()
        setupCreditation()
    }

    private func setupNavigationView() {
        navigationItem.title = "Pokédex"
    }

    private func setupTableView() {
        pokedexTableView.translatesAutoresizingMaskIntoConstraints = false
        pokedexTableView.dataSource = pokedexViewModel.tableManager
        pokedexTableView.delegate = pokedexViewModel.tableManager
        pokedexTableView.rowHeight = UITableView.automaticDimension
        pokedexTableView.backgroundColor = .lightGray
        pokedexTableView.estimatedRowHeight = 44.0

        view.addSubview(pokedexTableView)
        let layoutGuide = view.layoutGuide

        pokedexTableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 4).isActive = true
        pokedexTableView.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor).isActive = true
        pokedexTableView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor).isActive = true
    }

    private func setupCreditation() {
        credits.translatesAutoresizingMaskIntoConstraints = false
        credits.isEditable = false
        credits.isSelectable = true
        credits.delegate = self

        view.addSubview(credits)
        let layoutGuide = view.layoutGuide
        let height: CGFloat = credits.attributedText.value.isEmpty ? 0 : 32
        credits.topAnchor.constraint(equalTo: pokedexTableView.bottomAnchor, constant: 4).isActive = true
        credits.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        credits.heightAnchor.constraint(equalToConstant: height).isActive = true
        credits.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor).isActive = true
        credits.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor).isActive = true
    }
}

extension PokedexViewController: UITextViewDelegate {
    // swiftlint:disable:next line_length
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        guard textView == credits else { return false }

        let safariConfiguration = SFSafariViewController.Configuration()
        safariConfiguration.entersReaderIfAvailable = true
        safariConfiguration.barCollapsingEnabled = true
        let safariController = SFSafariViewController(url: URL, configuration: safariConfiguration)
        present(safariController, animated: true, completion: nil)
        return false
    }
}
