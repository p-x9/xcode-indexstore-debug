//
//  String+.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/09
//  
//

import Foundation

extension String {
    package func matches(pattern: String) -> Bool {
        self.range(of: pattern, options: .regularExpression) != nil
    }
}
