//
//  IndexStoreOccurrence+.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/09
//  
//

import Foundation
import SwiftIndexStore

extension IndexStoreOccurrence {
    public func matches(filter: Filter) -> Bool {
        switch filter {
        case .usr(let pattern):
            guard symbol.name != nil else { return false }
            return symbol.usr?.range(of: pattern, options: .regularExpression) != nil

        case .name(let pattern):
            guard self.symbol.name != nil else { return false }
            return symbol.name?.range(of: pattern, options: .regularExpression) != nil

        case .role(let roles):
            return roles.allSatisfy {
                self.roles.bits.contains($0)
            }

        case .kind(let kind):
            return self.symbol.kind == kind

        case .subKind(let subKind):
            return self.symbol.subKind == subKind

        case .language(let language):
            return self.symbol.language == language
        }
    }
}

extension IndexStoreOccurrence {
    public func matches(filters: [Filter]) -> Bool {
        filters.allSatisfy(matches(filter:))
    }
}
