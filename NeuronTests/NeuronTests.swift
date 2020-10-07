//
//  NeuronTests.swift
//  NeuronTests
//
//  Created by Mac on 07.10.2020.
//

import XCTest
@testable import Neuron

class NeuronTests: XCTestCase {
    
    let neuron = Neuron()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        neuron.set(weight: 0.5)
        assert(neuron.process(input: 100) == 50.0, "100 * 0.5 = 50")
        assert(neuron.restore(output: 50) == 100.0, "50 / 0.5 = 100")
    }

    func testPerformanceExample() throws {
        neuron.set(weight: 0.5)
        // This is an example of a performance test case.
        self.measure {
            neuron.train(input: 3, expectedResult: 23)
        }
    }

}
