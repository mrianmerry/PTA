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

    let dummyLabel = UILabel(frame: .zero)

    var pokédexViewModel: WBPokédexViewModel

    override init(with viewModel: WBBaseViewModel) {
        let pokédexViewModel = viewModel as? WBPokédexViewModel ?? WBPokédexViewModel()
        self.pokédexViewModel = pokédexViewModel

        super.init(with: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("\"\(#function)\" not implemented; check your code structure to see how this is being called!")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        dummyLabel.text = "Fuck yeah"
    }

    override func setupViews() {
        super.setupViews()

        setupDummyLabel()
    }

    private func setupDummyLabel() {
        dummyLabel.backgroundColor = .clear
        dummyLabel.textAlignment = .center
        dummyLabel.numberOfLines = 0
        dummyLabel.textColor = .white

        view.addSubview(dummyLabel)
        dummyLabel.snp.makeConstraints { make in
            make.topMargin.left.right.equalToSuperview().inset(50)
        }
    }
}
