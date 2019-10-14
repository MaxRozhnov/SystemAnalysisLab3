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
    var queryLifespans = [Int]()
    var probabilities: [String: Double] {
        return states.mapValues({ value in Double(value) / Double(totalTicks)})
    }
    var averageLifespan: Double {
        return Double(queryLifespans.reduce(0) { sum, value in sum + value }) / Double(queryLifespans.count)
    }


    private let sourceElement: SourceElement
    private let exitElement: ExitElement

    init(sourceElement: SourceElement, exitElement: ExitElement) {
        self.sourceElement = sourceElement
        self.exitElement = exitElement
        exitElement.addCallback = { [weak self] in self?.queryLifespans.append(sourceElement.stopTimer())  }
    }

    func analyze() {
        totalTicks += 1
        let currentState = state(element: sourceElement)
        if let count = states[currentState] {
            states[currentState] = count + 1
        } else {
            states[currentState] = 1
        }
    }

    func deviation(from solution: Solution) -> Solution {
        return probabilities.merging(solution) { (statisticsProbability, solutionProbability) in
            abs(statisticsProbability - solutionProbability)
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
                let elementState = state(element: subelement)
                if elementState != "" {
                    subelementStates.append("." + state(element: subelement))
                }
            }
        return element.state + subelementStates
    }
}
