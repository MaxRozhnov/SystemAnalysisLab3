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

    init(notGenerateProbability: Double, isBlockable: Bool) {
        self.notGenerateProbability = notGenerateProbability
        super.init()
        self.isBlockable = isBlockable
    }

    override func work() {
        if isBlockable {
            if isFull {
                if let emptySubelement = subelements.first(where: { element in !element.isFull }) {
                    emptySubelement.add()
                    isFull = false
                }
            }
            if !isFull {
                if generated() {
                    if let emptySubelement = subelements.first(where: { element in !element.isFull }) {
                        emptySubelement.add()
                    } else {
                        isFull = true
                    }
                }
            }
            isBlocked = isFull
        } else {
            if generated() {
                if let emptySubelement = subelements.first(where: { element in !element.isFull }) {
                    emptySubelement.add()
                } else {
                    totalDropped += 1
                }
            }
        }
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
        }
        return didGenerate
    }
}
