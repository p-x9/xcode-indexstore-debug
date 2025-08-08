//
//  Filter.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/08
//  
//

import Foundation
import SwiftIndexStore

public enum Filter: Codable {
    case usr(pattern: String)
    case name(pattern: String)
    case system(Bool)
    case role([IndexStoreOccurrence.Role.Bit])
    case kind(IndexStoreSymbol.Kind)
    case subKind(IndexStoreSymbol.SubKind)
    case language(IndexStoreSymbol.Language)
}

extension Filter {
    enum CodingKeys: String, CodingKey {
        case user
        case name
        case system
        case role
        case kind
        case subKind
        case language
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .usr(let pattern):
            try container.encode(pattern, forKey: .user)
        case .name(let pattern):
            try container.encode(pattern, forKey: .name)
        case .system(let isSystem):
            try container.encode(isSystem, forKey: .system)
        case .role(let roles):
            try container.encode(roles, forKey: .role)
        case .kind(let kind):
            try container.encode(kind, forKey: .kind)
        case .subKind(let subKind):
            try container.encode(subKind, forKey: .subKind)
        case .language(let language):
            try container.encode(language, forKey: .language)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let pattern = try container.decodeIfPresent(String.self, forKey: .user) {
            self = .usr(pattern: pattern)
            return
        }
        if let pattern = try container.decodeIfPresent(String.self, forKey: .name) {
            self = .name(pattern: pattern)
            return
        }
        if let isSystem = try container.decodeIfPresent(Bool.self, forKey: .system) {
            self = .system(isSystem)
            return
        }
        if let roles = try container.decodeIfPresent([IndexStoreOccurrence.Role.Bit].self, forKey: .role) {
            self = .role(roles)
            return
        }
        if let kind = try container.decodeIfPresent(IndexStoreSymbol.Kind.self, forKey: .kind) {
            self = .kind(kind)
            return
        }
        if let subKind = try container.decodeIfPresent(IndexStoreSymbol.SubKind.self, forKey: .subKind) {
            self = .subKind(subKind)
            return
        }
        if let language = try container.decodeIfPresent(IndexStoreSymbol.Language.self, forKey: .language) {
            self = .language(language)
            return
        }

        throw DecodingError.dataCorrupted(
            .init(
                codingPath: [],
                debugDescription: "Unable to decode Filter"
            )
        )
    }
}
