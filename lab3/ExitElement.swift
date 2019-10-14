//
//  ExitElement.swift
//  lab3
//
//  Created by Max Rozhnov on 10/13/19.
//  Copyright © 2019 Max Rozhnov. All rights reserved.
//


class ExitElement: SequenceElement {
    var addCallback: (() -> Void)?
    var workCallback: (() -> Void)?

    override func add() {
        super.add()
        addCallback?()
    }

    override func work() {
        super.work()
        workCallback?()
    }
}
