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

        if traitCollection.forceTouchCapability == .available {
            // TODO: Find out how we can register _each cell_ for 3D Touch!
        }
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

        let toggleSort = UIBarButtonItem(title: "Tabletop 'dex", style: .plain, target: self, action: #selector(sortPokedex))
        navigationItem.rightBarButtonItem = toggleSort
    }

    @objc func sortPokedex() {
        pokedexViewModel.toggleSort()
        navigationItem.rightBarButtonItem?.title = pokedexViewModel.pokemonSorting.sortTitle
        pokedexTableView.reloadData()
    }

    private func setupTableView() {
        pokedexTableView.translatesAutoresizingMaskIntoConstraints = false
        pokedexTableView.dataSource = pokedexViewModel.tableManager
        pokedexTableView.delegate = pokedexViewModel.tableManager
        pokedexTableView.rowHeight = UITableView.automaticDimension
        pokedexTableView.backgroundColor = .lightGray
        pokedexTableView.estimatedRowHeight = 44.0

        view.addSubview(pokedexTableView)
        let layoutGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate(
            [pokedexTableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 4),
             pokedexTableView.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor),
             pokedexTableView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor)]
        )
    }

    private func setupCreditation() {
        credits.translatesAutoresizingMaskIntoConstraints = false
        credits.isEditable = false
        credits.isSelectable = true
        credits.delegate = self

        view.addSubview(credits)
        let layoutGuide = view.safeAreaLayoutGuide
        let height: CGFloat = credits.attributedText.value.isEmpty ? 0 : 32

        NSLayoutConstraint.activate(
            [credits.topAnchor.constraint(equalTo: pokedexTableView.bottomAnchor, constant: 4),
             credits.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
             credits.heightAnchor.constraint(equalToConstant: height),
             credits.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor),
             credits.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor)]
        )
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

extension PokedexViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let cell = previewingContext.sourceView as? UITableViewCell else { return nil }

        // TODO: Make a RandomPokemonViewController - probably rename it as PokemonDetailViewController - and display it with the right 'mon

        return nil
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.show(viewControllerToCommit, sender: nil)
    }
}
