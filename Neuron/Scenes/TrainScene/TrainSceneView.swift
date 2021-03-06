//
//  TrainSceneView.swift
//  Neuron
//
//  Created by Mac on 07.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the MVI Xcode Templates so
//  you can apply MVI architecture to your iOS and Mac projects
//


import SwiftUI

struct TrainSceneView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var intent = TrainSceneIntent.shared
    
    @State private var input: String = ""
    @State private var testInput: String = ""
    @State private var expectedResult: String = ""
    @State private var accuracy: String = ""

    var body: some View {
        ZStack {
            
            BackView()
            
            VStack(alignment: .center, spacing: 5) {
                
                Text("Train Neuron")
                    .foregroundColor(textColor)
                    .padding()
                
                TrainingBlockView(intent: intent, input: $input, expectedResult: $expectedResult, accuracy: $accuracy)
                
                Spacer()
                
                TestingBlockView(intent: intent, testInput: $testInput)

            }
            .padding()


        }
        .onAppear {
            self.intent.setup()
        }
    }
    
    var textColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    
    
}

struct TrainSceneView_Previews: PreviewProvider {
    static var previews: some View {
        TrainSceneView()
    }
}

struct BackView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        backColor
            .onTapGesture(perform: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
    }
    
    var backColor: Color {
        colorScheme == .dark ? Color.black : Color.white
    }
    
}

struct TrainingBlockView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var intent: TrainSceneIntent
    
    @Binding var input: String
    @Binding var expectedResult: String
    @Binding var accuracy: String

    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("Training")
                .padding()
                .background(Color.red.opacity(0.7))
            
            HStack {
                Text("Input value")
                TextField("", text: $input)
                    .background(Color.gray.opacity(0.7))
            }
            
            HStack {
                Text("Expected result")
                TextField("", text: $expectedResult)
                    .background(Color.gray.opacity(0.7))
            }
            
            HStack {
                Text("Accuracy (> 0)")
                TextField("", text: $accuracy)
                    .background(Color.gray.opacity(0.7))
            }
            
            Text("Current error: \(intent.currentError)")
            Text("Current weight: \(intent.currentWeight)")

            Button {
                let trainData = TrainScene.TrainData(
                    input: Double(input) ?? .zero,
                    expectedResult: Double(Float(expectedResult) ?? .zero),
                    smoothing: Double(accuracy) ?? .zero
                )
                intent.train(trainData: trainData)
            } label: {
                Text("Start training")
                    .foregroundColor(textColor)
                    .padding()
                    .background(Color.gray)
            }
            .disabled(input.isEmpty || expectedResult.isEmpty || accuracy.isEmpty || (Double(accuracy) ?? .zero) < 0)
            
        }
    }
    
    var textColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }

}

struct TestingBlockView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var intent: TrainSceneIntent
    
    @Binding var testInput: String

    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("Testing")
                .foregroundColor(textColor)
                .padding()
                .background(Color.green.opacity(0.7))
            
            HStack {
                Text("Test input value")
                TextField("", text: $testInput)
                    .background(Color.gray.opacity(0.7))
            }
            
            Text("Test result = \(intent.testResult)")
                .onTapGesture {
                    intent.test(testInputValue: Double(testInput) ?? .zero)
                }
                .disabled(testInput.isEmpty)
            
            
            Button {
                intent.test(testInputValue: Double(testInput) ?? .zero)
            } label: {
                Text("Start test")
                    .foregroundColor(textColor)
                    .padding()
                    .background(Color.gray)
            }
            .disabled(testInput.isEmpty)
            
        }
    }
    
    var textColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }

}
