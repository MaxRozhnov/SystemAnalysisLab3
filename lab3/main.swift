//
//  main.swift
//  lab3
//
//  Created by Max Rozhnov on 10/7/19.
//  Copyright © 2019 Max Rozhnov. All rights reserved.
//

import Foundation

let source = SourceElement(notGenerateProbability: 0.3, isBlockable: true)
let processor1 = ProcessorElement(notProcessProbability: 0.5, isBlockable: true)
let queue = QueueElement(length: 2)
let processor2 = ProcessorElement(notProcessProbability: 0.7, isBlockable: false)
let exit = SequenceElement()

let analyzer = StateAnalyzer()


source.subelements = [processor1]
processor1.subelements = [queue]
queue.subelements = [processor2]
processor2.subelements = [exit]


for _ in 1...100000 {
    analyzer.analyze(element: source)
    source.tick()
}

analyzer.printProbabilities()

