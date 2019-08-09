//
//  TableManager.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 10/08/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import UIKit

class TableManager: NSObject {

    var publicIdentifierKey: String

    private var rowCount: RowCount
    private var sectionCount: SectionCount
    private var cellConfiguration: CellConfiguration
    private var cellInitialisation: CellInitialisation?

    init(with publicIdentifierKey: String,
         rowCount: @escaping RowCount,
         sectionCount: @escaping SectionCount,
         cellConfiguration: @escaping CellConfiguration,
         cellInitialisation: CellInitialisation? = nil) {
        self.publicIdentifierKey = publicIdentifierKey
        self.cellConfiguration = cellConfiguration
        self.sectionCount = sectionCount
        self.rowCount = rowCount
        self.cellInitialisation = cellInitialisation
    }

    private func reuseIdentifier(for index: Int) -> String {
        return String(format: "tablemanager_reuseidentifier_%@_%i", publicIdentifierKey, index)
    }
}

extension TableManager: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let identifier = reuseIdentifier(for: row)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
            cellInitialisation?(row, identifier) ??
            UITableViewCell(style: .value2, reuseIdentifier: identifier)

        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.textColor = .body
        cell.selectionStyle = .none
        cell.tintColor = .logo
        cellConfiguration(cell, row)

        return cell
    }

    typealias RowCount = (Int) -> Int
    typealias SectionCount = () -> Int
    typealias CellConfiguration = (UITableViewCell, Int) -> Void
    typealias CellInitialisation = (Int, String) -> UITableViewCell
}
