//
//  TrainSceneModel.swift
//  Neuron
//
//  Created by Mac on 07.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the MVI Xcode Templates so
//  you can apply MVI architecture to your iOS and Mac projects
//

import Foundation

enum TrainScene {
    
    // MARK: Use cases
    
    struct Test {
        let input: Double
    }
    
    struct TrainData {
        let input: Double
        let expectedResult: Double
        let smoothing: Double
    }

}
