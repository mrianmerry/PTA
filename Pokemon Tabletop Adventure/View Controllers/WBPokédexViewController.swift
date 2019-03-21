//
//  WBPokédexViewController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 10/08/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import SafariServices
import UIKit

class WBPokédexViewController: WBBaseViewController {
    // Need to add a label at the bottom to indicate logo author. HTML for this:
    private static let iconCredits = "Icons made by <a href=\"https://www.flaticon.com/authors/those-icons\" title=\"Those Icons\">Those Icons</a> from <a href=\"https://www.flaticon.com/\" title=\"Flaticon\">www.flaticon.com</a> is licensed by <a href=\"http://creativecommons.org/licenses/by/3.0/\" title=\"Creative Commons BY 3.0\" target=\"_blank\">CC 3.0 BY</a>" // swiftlint:disable:this line_length
    let credits = UITextView(frame: .zero)
    
    private let pokédexTableView = UITableView(frame: .zero, style: .grouped)

    var pokédexViewModel: WBPokédexViewModel

    override init(with viewModel: WBBaseViewModel, credits: String? = nil) {
        let pokédexViewModel = viewModel as? WBPokédexViewModel ?? WBPokédexViewModel()
        self.pokédexViewModel = pokédexViewModel

        self.credits.attributedText = (credits ?? WBPokédexViewController.iconCredits).html
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
        pokédexTableView.translatesAutoresizingMaskIntoConstraints = false
        pokédexTableView.dataSource = pokédexViewModel.tableManager
        pokédexTableView.delegate = pokédexViewModel.tableManager
        pokédexTableView.rowHeight = UITableViewAutomaticDimension
        pokédexTableView.backgroundColor = .lightGray
        pokédexTableView.estimatedRowHeight = 44.0

        view.addSubview(pokédexTableView)
        let layoutGuide = view.layoutGuide

        pokédexTableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 4).isActive = true
        pokédexTableView.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor).isActive = true
        pokédexTableView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor).isActive = true
    }

    private func setupCreditation() {
        credits.translatesAutoresizingMaskIntoConstraints = false
        credits.isEditable = false
        credits.isSelectable = true
        credits.delegate = self

        view.addSubview(credits)
        let layoutGuide = view.layoutGuide
        let height: CGFloat = credits.attributedText.value.isEmpty ? 0 : 32
        credits.topAnchor.constraint(equalTo: pokédexTableView.bottomAnchor, constant: 4).isActive = true
        credits.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        credits.heightAnchor.constraint(equalToConstant: height).isActive = true
        credits.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor).isActive = true
        credits.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor).isActive = true
    }
}

extension WBPokédexViewController: UITextViewDelegate {
    // swiftlint:disable:next line_length
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        guard textView == credits else { return false }
        
        let safariController = SFSafariViewController(url: URL, entersReaderIfAvailable: true)
        present(safariController, animated: true, completion: nil)
        return false
    }
}
