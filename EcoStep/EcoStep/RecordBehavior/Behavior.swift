//
//  Behavior.swift
//  EcoStep
//
//  Created by admin on 2024/11/19.
//

import Foundation

struct Behavior: Identifiable {
    var id: String = UUID().uuidString
    var type: String
    var points: Int
    var timestamp: Date
}
