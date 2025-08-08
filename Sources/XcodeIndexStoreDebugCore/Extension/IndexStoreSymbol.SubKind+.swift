//
//  IndexStoreSymbol+SubKind.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/08
//  
//

import Foundation
import SwiftIndexStore

extension IndexStoreSymbol.SubKind: StringConvertible {
    public init?(string: String) {
        switch string {
        case "none": self = .none
        case "cxxCopyConstructor": self = .cxxCopyConstructor
        case "cxxMoveConstructor": self = .cxxMoveConstructor
        case "accessorGetter": self = .accessorGetter
        case "accessorSetter": self = .accessorSetter
        case "usingTypeName": self = .usingTypeName
        case "usingValue": self = .usingValue
        case "usingEnum": self = .usingEnum
        case "swiftAccessorWillSet": self = .swiftAccessorWillSet
        case "swiftAccessorDidSet": self = .swiftAccessorDidSet
        case "swiftAccessorAddressor": self = .swiftAccessorAddressor
        case "swiftAccessorMutableAddressor": self = .swiftAccessorMutableAddressor
        case "swiftExtensionOfStruct": self = .swiftExtensionOfStruct
        case "swiftExtensionOfClass": self = .swiftExtensionOfClass
        case "swiftExtensionOfEnum": self = .swiftExtensionOfEnum
        case "swiftExtensionOfProtocol": self = .swiftExtensionOfProtocol
        case "swiftPrefixOperator": self = .swiftPrefixOperator
        case "swiftPostfixOperator": self = .swiftPostfixOperator
        case "swiftInfixOperator": self = .swiftInfixOperator
        case "swiftSubscript": self = .swiftSubscript
        case "swiftAssociatedtype": self = .swiftAssociatedtype
        case "swiftGenericTypeParam": self = .swiftGenericTypeParam
        case "swiftAccessorRead": self = .swiftAccessorRead
        case "swiftAccessorModify": self = .swiftAccessorModify
        case "swiftAccessorInit": self = .swiftAccessorInit
        default:
            return nil
        }
    }

    public var string: String {
        switch self {
        case .none: "none"
        case .cxxCopyConstructor: "cxxCopyConstructor"
        case .cxxMoveConstructor: "cxxMoveConstructor"
        case .accessorGetter: "accessorGetter"
        case .accessorSetter: "accessorSetter"
        case .usingTypeName: "usingTypeName"
        case .usingValue: "usingValue"
        case .usingEnum: "usingEnum"
        case .swiftAccessorWillSet: "swiftAccessorWillSet"
        case .swiftAccessorDidSet: "swiftAccessorDidSet"
        case .swiftAccessorAddressor: "swiftAccessorAddressor"
        case .swiftAccessorMutableAddressor: "swiftAccessorMutableAddressor"
        case .swiftExtensionOfStruct: "swiftExtensionOfStruct"
        case .swiftExtensionOfClass: "swiftExtensionOfClass"
        case .swiftExtensionOfEnum: "swiftExtensionOfEnum"
        case .swiftExtensionOfProtocol: "swiftExtensionOfProtocol"
        case .swiftPrefixOperator: "swiftPrefixOperator"
        case .swiftPostfixOperator: "swiftPostfixOperator"
        case .swiftInfixOperator: "swiftInfixOperator"
        case .swiftSubscript: "swiftSubscript"
        case .swiftAssociatedtype: "swiftAssociatedtype"
        case .swiftGenericTypeParam: "swiftGenericTypeParam"
        case .swiftAccessorRead: "swiftAccessorRead"
        case .swiftAccessorModify: "swiftAccessorModify"
        case .swiftAccessorInit: "swiftAccessorInit"
        }
    }
}

extension IndexStoreSymbol.SubKind: Codable {
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
