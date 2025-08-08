//
//  IndexStoreSymbol.Language+.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/08
//  
//

import Foundation
import SwiftIndexStore

extension IndexStoreSymbol.Language: StringConvertible {
    public init?(string: String) {
        switch string {
        case "c": self = .c
        case "objc": self = .objc
        case "cxx": self = .cxx
        case "swift": self = .swift
        default:
            return nil
        }
    }

    public var string: String {
        switch self {
        case .c: return "c"
        case .objc: return "objc"
        case .cxx: return "cxx"
        case .swift: return "swift"
        }
    }
}

extension IndexStoreSymbol.Language: Codable {
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
