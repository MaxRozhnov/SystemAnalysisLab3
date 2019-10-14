//
//  QueueElement.swift
//  lab3
//
//  Created by Max Rozhnov on 10/7/19.
//  Copyright © 2019 Max Rozhnov. All rights reserved.
//

import Foundation

class QueueElement: SequenceElement {

    let length: Int
    var tasksInQueue: Int = 0
    var totalQueued: Int = 0
    var isEmpty: Bool {
        return tasksInQueue == 0
    }
    var averageQueue: Double {

        print(totalTicks)
        return Double(totalQueued) / Double(totalTicks)
    }
    var isNextEmpty: Bool {
        return subelements.filter { element in !element.isFull }.count > 0 && isEmpty
    }

    init(length: Int) {
        self.length = length
    }

    //State of Queue Element is the amount of tasks in queue
    override var state: String {
        return String(tasksInQueue)
    }

    override func work() {
        for emptySubelement in subelements.filter({ element in !element.isFull }) {
            if tasksInQueue > 0 {
                emptySubelement.add()
                tasksInQueue -= 1
            } else {
                break
            }
        }
        if tasksInQueue < length {
            isFull = false
        }
        totalQueued += tasksInQueue
    }

    override func add() {
        tasksInQueue += 1
        work()
        if tasksInQueue == length {
            isFull = true
        }
    }
}
