//
//  ProcessorElement.swift
//  lab3
//
//  Created by Max Rozhnov on 10/7/19.
//  Copyright © 2019 Max Rozhnov. All rights reserved.
//

import Foundation

class ProcessorElement: SequenceElement {

    var totalProcessed = 0
    var notProcessProbability: Double

    init(notProcessProbability: Double, isBlockable: Bool) {
        self.notProcessProbability = notProcessProbability
        super.init()
        self.isBlockable = isBlockable
    }

    private func processed() -> Bool {
        let didProcess = Double.random > notProcessProbability ? true : false
        if didProcess {
            totalProcessed += 1
        }
        return didProcess
    }

    /*
     -Blockable processors:

     First digit of the state is "1" if the processor is blocked, "0" otherwise.
     Second digit of the state is "0" if the processor is busy, "0" otherwise.

     -Non-Blockable processors:

     State is "0" if the processor is busy, "0" otherwise.
    */

    override var state: String {
        var blockedState = ""
        if isBlockable {
            blockedState = isBlocked ? "1" : "0"
        }
        let busyState = isFull ? "1" : "0"
        return blockedState + busyState
    }

    override func work() {
        if isBlocked {
            if let emptySubelement = subelements.first(where: { element in !element.isFull }) {
                emptySubelement.add()
                isFull = false
                isBlocked = false
            }
        }
        if !isBlocked && isFull {
            if processed() {
                if let emptySubelement = subelements.first(where: { element in !element.isFull }) {
                    emptySubelement.add()
                    isFull = false
                    isBlocked = false
                } else {
                    isBlocked = true
                }
            } else {
                isFull = true
            }
        }
    }

    override func add() {
        isFull = true
    }
}
