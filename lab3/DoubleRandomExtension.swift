//
//  DoubleRandomExtension.swift
//  lab3
//
//  Created by Max Rozhnov on 10/7/19.
//  Copyright © 2019 Max Rozhnov. All rights reserved.
//

import Foundation

public extension Double {

    static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }

    static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
}
