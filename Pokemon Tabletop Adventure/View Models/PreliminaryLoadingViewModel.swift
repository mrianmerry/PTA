//
//  PreliminaryLoadingViewModel.swift
//  PTA Companion
//
//  Created by pool on 10/06/2021.
//  Copyright © 2021 Undersea Love. All rights reserved.
//

import Foundation

final class PreliminaryLoadingViewModel: PreliminaryLoadable {
    private weak var actionDelegate: ActionDelegate?
    
    init(actionDelegate: ActionDelegate?) {
        self.actionDelegate = actionDelegate
    }
    
    func bind(_ inputs: PreliminaryLoadableInputs) -> PreliminaryLoadableOutputs {
        return .init()
    }
    
    func loadInitialData() {
        
    }
}

protocol PreliminaryLoadable {
    func bind(_ inputs: PreliminaryLoadableInputs) -> PreliminaryLoadableOutputs
    func loadInitialData()
}

struct PreliminaryLoadableInputs {
    
}

struct PreliminaryLoadableOutputs {
    
}
