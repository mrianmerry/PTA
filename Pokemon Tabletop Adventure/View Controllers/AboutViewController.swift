//
//  AboutViewController.swift
//  P:TA Companion
//
//  Created by Ian Merryweather on 01/04/2019.
//  Copyright © 2019 Undersea Love. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {
    private let tableView = UITableView(frame: .zero, style: .plain)
    private lazy var tableManager = TableManager(with: "AboutTheApp", rowCount: { _ in
        return 5
    }, sectionCount: {
        return 1
    }, cellConfiguration: { cell, row in
        self.configure(cell, at: row)
    }, cellInitialisation: { row, identifier in
        return self.cell(for: row, with: identifier)
    })

    override func setupViews() {
        super.setupViews()

        navigationItem.title = "About"

        view.addSubview(tableView)
        let layoutGuide = view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
             tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
             tableView.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor),
             tableView.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor)]
        )

        tableView.dataSource = tableManager
        tableView.delegate = tableManager
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .lightGray
        tableView.estimatedRowHeight = 44.0
        tableView.tableFooterView = UIView()
    }
}

private extension AboutViewController {
    func configure(_ cell: UITableViewCell, at row: Int) {
        if (cell as? CreditAttributionTableViewCell).isNone {
            cell.textLabel?.updateAttributedText(title(for: row))
            cell.detailTextLabel?.updateAttributedText(message(for: row))
        }
    }

    func title(for row: Int) -> String {
        switch row {
        case 0: return "Build"
        case 1: return "P:TA Author"
        case 2: return "Pokedex Icon"
        case 3: return "Pokeball Icon"
        case 4: return "About Icon"
        default: fatalError("Be more careful when generating table views!")
        }
    }

    func message(for row: Int) -> String {
        var message: String
        switch row {
        case 0: return """
            Number: \(UIApplication.buildVersion)
            App Version: \(UIApplication.appVersion)
            """
        case 1: message = """
            Pokémon Tabletop Adventures was written by DrMrStark, sourced from the PTA
            <a href=\"https://discord.gg/UgWJaH8\">Discord Server</a>
            """
        case 2, 4: message = """
            The icon used was made by <a href=\"https://www.flaticon.com/authors/those-icons\" title=\"Those Icons\">Those Icons</a>
            from <a href=\"https://www.flaticon.com/\" title=\"Flaticon\">www.flaticon.com</a>, and is licensed by <a href=\"http://creative
            commons.org/licenses/by/3.0/\" title=\"Creative Commons BY 3.0\" target=\"_blank\">CC 3.0 BY</a>
            """
        case 3: message = """
            The icon used was made by <a href=\"https://www.flaticon.com/authors/nikita-golubev" title="Nikita Golubev">Nikita Golubev
            </a> from <a href=\"https://www.flaticon.com/\" title=\"Flaticon\">www.flaticon.com</a>, and is licensed by <a href=\"http://
            creativecommons.org/licenses/by/3.0/\" title=\"Creative Commons BY 3.0\" target=\"_blank\">CC 3.0 BY</a>
            """
        default: fatalError("Be more careful when generating table views!")
        }
        let html = """
        <html><head><style type=\"text/css\">body{font-family: '-apple-system'; font-size: 10;
        color:\(UIColor.bodyHex);}</style></head><body>\(message)</body></html>
        """
        return html
    }

    func cell(for row: Int, with identifier: String) -> UITableViewCell {
        switch row {
        case 1, 2, 3, 4:
            return CreditAttributionTableViewCell(author: title(for: row),
                                                  credits: message(for: row),
                                                  reuseIdentifier: identifier)
        default:
            return UITableViewCell(style: .value2, reuseIdentifier: identifier)
        }
    }
}
