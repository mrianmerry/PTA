//
//  TableManager.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 10/08/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import UIKit

class TableManager: NSObject {

    var publicIdentifierKey: String

    private var rowCount: RowCount
    private var sectionCount: SectionCount
    private var cellConfiguration: CellConfiguration

    init(with publicIdentifierKey: String,
         rowCount: @escaping RowCount,
         sectionCount: @escaping SectionCount,
         cellConfiguration: @escaping CellConfiguration) {
        self.publicIdentifierKey = publicIdentifierKey
        self.cellConfiguration = cellConfiguration
        self.sectionCount = sectionCount
        self.rowCount = rowCount
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
        let identifier = reuseIdentifier(for: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
            UITableViewCell(style: .value2, reuseIdentifier: identifier)

        cell.selectionStyle = .none
        cellConfiguration(cell, indexPath.row)

        return cell
    }

    typealias RowCount = (Int) -> Int
    typealias SectionCount = () -> Int
    typealias CellConfiguration = (UITableViewCell, Int) -> Void
}
