//
//  SequenceElement.swift
//  lab3
//
//  Created by Max Rozhnov on 10/7/19.
//  Copyright © 2019 Max Rozhnov. All rights reserved.
//

class SequenceElement {
    var totalTicks = 0
    var totalTickBlocked = 0
    var totalTicksFull = 0

    var isBlockable = false
    var isBlocked = false
    var isFull = false
    
    var subelements: [SequenceElement] = []

    var state: String {
        return ""
    }

    func tick() {
        for subelement in subelements {
            subelement.tick()
        }
        work()
        logStats()
    }

    func add() { }
    func work() { }

    private func logStats() {
        totalTicks += 1
        if isBlocked {
            totalTickBlocked += 1
        }
        if isFull {
            totalTicksFull += 1
        }
    }
}
