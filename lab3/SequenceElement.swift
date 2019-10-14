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
    func didAddToNext() -> Bool {
        var didAdd = false
        var possibleNexts = [SequenceElement]()
        for subelement in (subelements.filter { subelement in !subelement.isFull }) {
            if didAdd {
                break
            }
            if let queueElement = subelement as? QueueElement {
                if queueElement.isNextEmpty {
                    queueElement.add()
                    didAdd = true
                } else {
                    possibleNexts.append(subelement)
                }
            } else {
                possibleNexts.append(subelement)
            }
        }
        if !didAdd, let next = possibleNexts.first {
            next.add()
            didAdd = true
        }
        return didAdd
    }

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
