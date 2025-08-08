//
//  StringConvertible.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/08
//  
//

public protocol StringConvertible {
    var string: String { get }

    init?(string value: String)
}
