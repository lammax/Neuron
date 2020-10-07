//
//  TrainSceneIntent.swift
//  Neuron
//
//  Created by Mac on 07.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the MVI Xcode Templates so
//  you can apply MVI architecture to your iOS and Mac projects
//

import Combine
import SwiftUI

class TrainSceneIntent: ObservableObject {
    
    static let shared = TrainSceneIntent()
    
    @Published var currentError: Double = 1000.0
    @Published var currentWeight: Double = 0.5
    @Published var testResult: Double = .zero

    private var neuron: Neuron!
    private var iter: Int64 = 0
    private var smoothing: Double = .zero

    func setup() {
        neuron = Neuron()
    }
    
    func train(trainData: TrainScene.TrainData) {
        
        self.currentError = 1000.0
        self.currentWeight = 0.5
        neuron.set(weight: self.currentWeight)
        
        DispatchQueue.global().async {
            self.smoothing = trainData.smoothing
            self.neuron.set(smoothing: trainData.smoothing)
            let uiUpdateStep = Int64((1.0 / self.smoothing) / 2.0)
            while self.currentError > self.smoothing  || self.currentError < -self.smoothing {
                self.iter += 1
                let (error, weight) = self.neuron.train(input: trainData.input, expectedResult: trainData.expectedResult)
                if self.iter % uiUpdateStep == 0 {
                    DispatchQueue.main.async {
                        self.currentError = error
                        self.currentWeight = weight
                    }
                }
            }
        }
    }
    
    func test(testInputValue: Double) {
        testResult = neuron.process(input: testInputValue)
    }
    
}
