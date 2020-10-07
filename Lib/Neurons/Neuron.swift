//
//  Neuron.swift
//  Neuron
//
//  Created by Mac on 07.10.2020.
//

import Foundation

class Neuron {
    
    private var weight: Double
    private var lastError: Double
    private var smoothing: Double
    
    init() {
        weight = 0.5
        lastError = .zero
        smoothing = 0.0000001
    }
    
    func set(smoothing: Double) {
        self.smoothing = smoothing
    }
    
    func set(weight: Double) {
        self.weight = weight
    }
    
    func process(input: Double) -> Double {
        input * weight
    }
    
    func restore(output: Double) -> Double {
        output / weight
    }
    
    func train(input: Double, expectedResult: Double) -> (Double, Double) {
        let actualResult = input * weight
        lastError = expectedResult - actualResult
        let correction = (lastError / actualResult) * smoothing
        weight += correction
        return (lastError, weight)
    }
    
}
