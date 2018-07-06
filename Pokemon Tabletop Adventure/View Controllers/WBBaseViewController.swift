//
//  WBBaseViewController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merry on 06/07/2018.
//  Copyright © 2018 WeatherBear. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\"init?(coder aDecoder: NSCoder)\" not implemented; check your code structure to see how this is being called!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Base View Controller"
        view.backgroundColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
