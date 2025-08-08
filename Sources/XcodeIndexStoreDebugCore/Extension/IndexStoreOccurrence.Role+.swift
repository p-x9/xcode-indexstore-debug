//
//  IndexStoreOccurrence.Role+.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/08
//  
//

import Foundation
import SwiftIndexStore

extension IndexStoreOccurrence.Role {
    public var bits: [Bit] {
        Bit.allCases
            .filter {
                rawValue & (1 << $0.rawValue) != 0
            }
    }

    public init(bits: [Bit]) {
        self.init(
            rawValue: bits.reduce(0, { partialResult, bit in
                partialResult + (1 << bit.rawValue)
            })
        )
    }
}

extension IndexStoreOccurrence.Role {
    public enum Bit: UInt8, CaseIterable, Codable {
        case declaration
        case definition
        case reference
        case read
        case write
        case call
        case dynamic
        case addressOf
        case implicit
        case childOf
        case baseOf
        case overrideOf
        case receivedBy
        case calledBy
        case extendedBy
        case accessorOf
        case containedBy
        case ibTypeOf
        case specializationOf
    }
}

extension IndexStoreOccurrence.Role.Bit: StringConvertible {
    public init?(string value: String) {
        switch value {
        case "declaration": self = .declaration
        case "definition": self = .definition
        case "reference": self = .reference
        case "read": self = .read
        case "write": self = .write
        case "call": self = .call
        case "dynamic": self = .dynamic
        case "addressOf": self = .addressOf
        case "implicit": self = .implicit
        case "childOf": self = .childOf
        case "baseOf": self = .baseOf
        case "overrideOf": self = .overrideOf
        case "receivedBy": self = .receivedBy
        case "calledBy": self = .calledBy
        case "extendedBy": self = .extendedBy
        case "accessorOf": self = .accessorOf
        case "containedBy": self = .containedBy
        case "ibTypeOf": self = .ibTypeOf
        case "specializationOf": self = .specializationOf
        default:
            return nil
        }
    }
}

extension IndexStoreOccurrence.Role.Bit {
    public var string: String {
        switch self {
        case .declaration: "declaration"
        case .definition: "definition"
        case .reference: "reference"
        case .read: "read"
        case .write: "write"
        case .call: "call"
        case .dynamic: "dynamic"
        case .addressOf: "addressOf"
        case .implicit: "implicit"
        case .childOf: "childOf"
        case .baseOf: "baseOf"
        case .overrideOf: "overrideOf"
        case .receivedBy: "receivedBy"
        case .calledBy: "calledBy"
        case .extendedBy: "extendedBy"
        case .accessorOf: "accessorOf"
        case .containedBy: "containedBy"
        case .ibTypeOf: "ibTypeOf"
        case .specializationOf: "specializationOf"
        }
    }
}
