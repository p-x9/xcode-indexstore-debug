//
//  IndexStoreOccurrence.Property+.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/08
//  
//

import Foundation
import SwiftIndexStore

extension IndexStoreSymbol.Property {
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

extension IndexStoreSymbol.Property {
    public enum Bit: UInt8, CaseIterable, Codable {
        case generic
        case templatePartialSpecialization
        case templateSpecialization
        case unittest
        case ibAnnotated
        case ibOutletCollection
        case gkinspectable
        case local
        case protocolInterface
        case swiftAsync = 16
    }
}

extension IndexStoreSymbol.Property.Bit: StringConvertible {
    public init?(string value: String) {
        switch value {
        case "generic": self = .generic
        case "templatePartialSpecialization": self = .templatePartialSpecialization
        case "templateSpecialization": self = .templateSpecialization
        case "unittest": self = .unittest
        case "ibAnnotated": self = .ibAnnotated
        case "ibOutletCollection": self = .ibOutletCollection
        case "gkinspectable": self = .gkinspectable
        case "local": self = .local
        case "protocolInterface": self = .protocolInterface
        case "swiftAsync": self = .swiftAsync
        default:
            return nil
        }
    }
}

extension IndexStoreSymbol.Property.Bit {
    public var string: String {
        switch self {
        case .generic: "generic"
        case .templatePartialSpecialization: "templatePartialSpecialization"
        case .templateSpecialization: "templateSpecialization"
        case .unittest: "unittest"
        case .ibAnnotated: "ibAnnotated"
        case .ibOutletCollection: "ibOutletCollection"
        case .gkinspectable: "gkinspectable"
        case .local: "local"
        case .protocolInterface: "protocolInterface"
        case .swiftAsync: "swiftAsync"
        }
    }
}
