//
//  WBBaseViewController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 06/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {
    
    let viewModel: WBBaseViewModel
    
    convenience init() {
        self.init(with: WBBaseViewModel())
    }
    
    init(with viewModel: WBBaseViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\"init?(coder aDecoder: NSCoder)\" not implemented; check your code structure to see how this is being called!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        view.backgroundColor = .white
    }
}
