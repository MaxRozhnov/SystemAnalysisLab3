//
//  StateAnalyzer.swift
//  lab3
//
//  Created by Max Rozhnov on 10/8/19.
//  Copyright © 2019 Max Rozhnov. All rights reserved.
//

import Foundation

class StateAnalyzer {

    var totalTicks = 0
    var states = [String: Int]()

    func analyze(element: SequenceElement) {
        totalTicks += 1
        let currentState = state(element: element)
        if let count = states[currentState] {
            states[currentState] = count + 1
        } else {
            states[currentState] = 1
        }
    }

    func printStates() {
        for state in states {
            print(state.key + " : " + String(state.value))
        }
    }

    func printProbabilities() {
        for state in states {
            print(state.key + " : " + String(Double(state.value) / Double(totalTicks)))
        }
    }

    private func state(element: SequenceElement) -> String {
        var subelementStates = ""
               for subelement in element.subelements {
                   subelementStates.append("." + state(element: subelement))
               }
        return element.state + subelementStates
    }
}
