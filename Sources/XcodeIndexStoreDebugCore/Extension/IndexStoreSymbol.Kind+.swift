//
//  IndexStoreSymbol.Kind+.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/08
//  
//

import Foundation
import SwiftIndexStore

extension IndexStoreSymbol.Kind: StringConvertible {
    public init?(string: String) {
        switch string {
        case "unknown": self = .unknown
        case "module": self = .module
        case "namespace": self = .namespace
        case "namespaceAlias": self = .namespaceAlias
        case "macro": self = .macro
        case "enum": self = .enum
        case "struct": self = .struct
        case "class": self = .class
        case "protocol": self = .protocol
        case "extension": self = .extension
        case "union": self = .union
        case "typealias": self = .typealias
        case "function": self = .function
        case "variable": self = .variable
        case "field": self = .field
        case "enumConstant": self = .enumConstant
        case "instanceMethod": self = .instanceMethod
        case "classMethod": self = .classMethod
        case "staticMethod": self = .staticMethod
        case "instanceProperty": self = .instanceProperty
        case "classProperty": self = .classProperty
        case "staticProperty": self = .staticProperty
        case "constructor": self = .constructor
        case "destructor": self = .destructor
        case "conversionFunction": self = .conversionFunction
        case "parameter": self = .parameter
        case "using": self = .using
        case "concept": self = .concept
        case "commentTag": self = .commentTag
        default:
            return nil
        }
    }

    public var string: String {
        switch self {
        case .unknown: return "unknown"
        case .module: return "module"
        case .namespace: return "namespace"
        case .namespaceAlias: return "namespaceAlias"
        case .macro: return "macro"
        case .enum: return "enum"
        case .struct: return "struct"
        case .class: return "class"
        case .protocol: return "protocol"
        case .extension: return "extension"
        case .union: return "union"
        case .typealias: return "typealias"
        case .function: return "function"
        case .variable: return "variable"
        case .field: return "field"
        case .enumConstant: return "enumConstant"
        case .instanceMethod: return "instanceMethod"
        case .classMethod: return "classMethod"
        case .staticMethod: return "staticMethod"
        case .instanceProperty: return "instanceProperty"
        case .classProperty: return "classProperty"
        case .staticProperty: return "staticProperty"
        case .constructor: return "constructor"
        case .destructor: return "destructor"
        case .conversionFunction: return "conversionFunction"
        case .parameter: return "parameter"
        case .using: return "using"
        case .concept: return "concept"
        case .commentTag: return "commentTag"
        }
    }
}

extension IndexStoreSymbol.Kind: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        guard let kind = Self(string: string) else {
            throw DecodingError
                .dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Invalid kind string \(string)"
                    )
                )
        }
        self = kind
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }
}

extension IndexStoreSymbol.Kind: @retroactive CaseIterable {
    public static var allCases: [IndexStoreSymbol.Kind] {
        [
            .unknown,
            .module,
            .namespace,
            .namespaceAlias,
            .macro,
            .`enum`,
            .`struct`,
            .`class`,
            .`protocol`,
            .`extension`,
            .union,
            .`typealias`,
            .function,
            .variable,
            .field,
            .enumConstant,
            .instanceMethod,
            .classMethod,
            .staticMethod,
            .instanceProperty,
            .classProperty,
            .staticProperty,
            .constructor,
            .destructor,
            .conversionFunction,
            .parameter,
            .using,
            .concept,
            .commentTag,
        ]
    }
}
