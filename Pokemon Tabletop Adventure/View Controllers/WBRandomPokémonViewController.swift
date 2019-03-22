//
//  WBRandomPokémonViewController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 09/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import SnapKit
import UIKit

class WBRandomPokémonViewController: WBBaseViewController {
    /* Need to add label at the bottom to indicate logo author. HTML for this:
     <div>
        Icons made by <a href="https://www.flaticon.com/authors/nikita-golubev" title="Nikita Golubev">Nikita Golubev</a> from <a
        href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a
        href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a>
     </div>
     */
    let descriptionLabel: UILabel
    
    var randomViewModel: WBRandomPokémonViewModel
    
    override init(with viewModel: WBBaseViewModel, credits: String? = nil) {
        let randomViewModel = viewModel as? WBRandomPokémonViewModel ?? WBRandomPokémonViewModel()
        self.randomViewModel = randomViewModel
        self.descriptionLabel = UILabel(frame: .zero)
        
        super.init(with: viewModel, credits: credits)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\"\(#function)\" not implemented; check your code structure to see how this is being called!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        descriptionLabel.text = randomViewModel.describeCurrentPokémon
    }
    
    override func setupViews() {
        super.setupViews()
        
        setupNavigationBar()
        setupLabel()
    }
    
    private func setupNavigationBar() {
        let randomPokémon = UIBarButtonItem(title: "Next 'mon", style: .plain, target: self, action: #selector(showRandomPokémon))
        navigationItem.rightBarButtonItem = randomPokémon
        navigationItem.title = "Randomiser"
    }
    
    private func setupLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.topMargin.left.right.equalToSuperview().inset(50)
        }
    }
    
    @objc private func showRandomPokémon() {
        let chosenPokémon: Pokémon = randomViewModel.getRandomPokémon()
        descriptionLabel.text = chosenPokémon.basicDescription()
    }
}
