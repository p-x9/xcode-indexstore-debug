//
//  Filter.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/09
//  
//

import Foundation
import SwiftIndexStore

public struct Filter: Codable {
    public var conditions: [FilterCondition]

    public init(conditions: [FilterCondition]) {
        self.conditions = conditions
    }
}
