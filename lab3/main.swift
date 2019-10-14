//
//  main.swift
//  lab3
//
//  Created by Max Rozhnov on 10/7/19.
//  Copyright © 2019 Max Rozhnov. All rights reserved.
//

import Foundation

typealias Solution = [String: Double]

let tickAmount = 100000

let source = SourceElement(notGenerateProbability: 0.75, isBlockable: true)
let processor1 = ProcessorElement(notProcessProbability: 0.7, isBlockable: true)
let queue = QueueElement(length: 2)
let processor2 = ProcessorElement(notProcessProbability: 0.65, isBlockable: false)
let exit = ExitElement()

let analyzer = StateAnalyzer(sourceElement: source, exitElement: exit)

let solution: Solution = [
    "0.00.0.0" : 0.106,
    "0.01.0.0" : 0.137,
    "0.00.0.1" : 0.118,
    "1.01.0.0" : 0.156,
    "0.01.0.1" : 0.153,
    "1.01.0.1" : 0.055,
    "0.00.1.1" : 0.068,
    "0.01.1.1" : 0.047,
    "1.01.1.1" : 0.040,
    "0.00.2.1" : 0.028,
    "0.01.2.1" : 0.049,
    "0.11.2.1" : 0.014,
    "1.01.2.1" : 0.010,
    "1.11.2.1" : 0.019
]

source.subelements = [processor1]
processor1.subelements = [queue]
queue.subelements = [processor2]
processor2.subelements = [exit]

for _ in 1...tickAmount {
    analyzer.analyze()
    source.tick()
}

analyzer.printProbabilities()

print("Lс (средняя длина очереди) = " + String(queue.averageQueue))
print("P бл ист (блокировки источника) = " + String(Double(source.totalTickBlocked) / Double(tickAmount)))
print("Wc (среднее время нахождения заявки)  = " + String(analyzer.averageLifespan))
