//
//  WBBaseViewController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 06/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import UIKit
import SnapKit

class WBBaseViewController: UIViewController {
    
    let temporaryButton: UIButton
    
    init() {
        temporaryButton = UIButton(type: .roundedRect)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\"init?(coder aDecoder: NSCoder)\" not implemented; check your code structure to see how this is being called!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomPokemon = UIBarButtonItem(title: "Show Random Pokémon", style: .plain, target: self, action: #selector(showRandomPokemon))
        navigationItem.rightBarButtonItem = randomPokemon
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func showRandomPokemon() {
        // JSON currently only has 9 pokemon detailed, so we limit our random to 9
        let pokedexScore: Int = 9
        
        let chosen = Int(arc4random_uniform(UInt32(pokedexScore)))
        
        print("Choosing pokémon #\(chosen + 1)")
    }
    
    private func setupViews() {
        navigationItem.title = "Base View Controller"
        view.backgroundColor = .white
        
        setupButtons()
    }
    
    private func setupButtons() {
        temporaryButton.setTitle("Random Pokémon", for: .normal)
        
        prepare(temporaryButton, forDisplayIn:view)
    }
    
    private func prepare(_ button: UIButton, forDisplayIn superview: UIView) {
        superview.addSubview(button)
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalToSuperview().inset(100)
            make.left.right.equalToSuperview().inset(100)
        }
    }
}
