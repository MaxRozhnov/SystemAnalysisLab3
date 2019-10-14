//
//  SourceElement.swift
//  lab3
//
//  Created by Max Rozhnov on 10/7/19.
//  Copyright © 2019 Max Rozhnov. All rights reserved.
//

class SourceElement: SequenceElement {

    var totalGenerated = 0
    var totalDropped = 0
    var notGenerateProbability: Double
    var timers = [Int]()

    init(notGenerateProbability: Double, isBlockable: Bool) {
        self.notGenerateProbability = notGenerateProbability
        super.init()
        self.isBlockable = isBlockable
    }

    func stopTimer() -> Int {
        return timers.remove(at: 0)
    }

    override func work() {
        if isBlockable {
            if isFull {
                if didAddToNext() {
                    isFull = false
                }
            }
            if !isFull {
                if generated() {
                    if !didAddToNext() {
                        isFull = true
                    }
                }
            }
            isBlocked = isFull
        } else {
            if generated() {
                if !didAddToNext() {
                    totalDropped += 1
                }
            }
        }
        timers = timers.map { $0 + 1 }
        
    }

    //Non-blockable sources don't have a state.
    //Blockable ones return "1" if they're blocked and "0" otherwise.
    override var state: String {
        if isBlockable {
            return isBlocked ? "1" : "0"
        } else {
            return ""
        }
    }

    private func generated() -> Bool {
        let didGenerate = Double.random > notGenerateProbability ? true : false
        if didGenerate {
            totalGenerated += 1
            timers.append(0)
        }
        return didGenerate
    }
}
