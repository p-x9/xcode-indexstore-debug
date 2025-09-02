//
//  IndexStoreReporter.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/09
//  
//

import Foundation
@preconcurrency import SwiftIndexStore
import SourceReporter

public final class IndexStoreReporter: Sendable {
    public let reportType: ReportType
    public let reporter: any (ReporterProtocol & Sendable)
    public let filters: [Filter]
    public let excludedFiles: [String]
    public let indexStore: IndexStore

    public init(
        reportType: ReportType,
        reporter: any (ReporterProtocol & Sendable),
        filters: [Filter],
        excludedFiles: [String],
        indexStore: IndexStore
    ) {
        self.reportType = reportType
        self.reporter = reporter
        self.filters = filters
        self.excludedFiles = excludedFiles
        self.indexStore = indexStore
    }
}

extension IndexStoreReporter {
    public func run() throws {
        try indexStore.forEachUnits(includeSystem: false) { unit in
            guard try shouldReport(for: unit) else { return true }
            try indexStore.forEachRecordDependencies(for: unit) { dependency in
                guard shouldReport(for: dependency) else {
                    return true
                }
                guard case let .record(record) = dependency else {
                    return true
                }
                try indexStore.forEachOccurrences(for: record) { occurrence in
                    reportIfNeeded(for: occurrence)
                    return true
                } // forEachOccurrences
                return true
            } // forEachRecordDependencies
            return true
        } // forEachUnits
    }

    public func runConcurrently() async throws {
        let units = indexStore.units(includeSystem: false)

        try await units.concurrentForEach { unit in
            guard try self.shouldReport(for: unit) else { return }
            try self.indexStore.forEachRecordDependencies(for: unit) { dependency in
                guard self.shouldReport(for: dependency) else {
                    return true
                }
                guard case let .record(record) = dependency else {
                    return true
                }
                try self.indexStore.forEachOccurrences(for: record) { occurrence in
                    self.reportIfNeeded(for: occurrence)
                    return true
                } // forEachOccurrences
                return true
            } // forEachRecordDependencies
        }
    }
}

extension IndexStoreReporter {
    private func reportIfNeeded(for occurrence: IndexStoreOccurrence) {
        if shouldReport(for: occurrence) {
            report(for: occurrence)
        }
    }
}

extension IndexStoreReporter {
    private func report(for occurrence: IndexStoreOccurrence) {
        let symbol = occurrence.symbol
        var contents: [String] = []
        if let usr = symbol.usr {
            contents.append("[indexstore] user: \(usr)")
        }

        if let name = symbol.name {
            contents.append("name: \(name)")
        }
        contents.append("roles: [\(occurrence.roles.bits.map(\.string).joined(separator: ", "))]")
        contents.append("kind: \(symbol.kind.string)")
        contents.append("subKind: \(symbol.subKind.string)")
        contents.append("lang: \(symbol.language.string)")

        reporter.report(
            file: occurrence.location.path,
            line: numericCast(occurrence.location.line),
            column: numericCast(occurrence.location.column),
            type: .warning,
            content: contents.joined(separator: ", ")
        )
    }

    private func shouldReport(for unit: IndexStoreUnit) throws -> Bool {
        let path = try indexStore.mainFilePath(for: unit)

        if excludedFiles.contains(
            where: { path?.matches(pattern: $0) ?? true }
        ) {
            return false
        }
        return true
    }

    private func shouldReport(for dependency: IndexStoreUnit.Dependency) -> Bool {
        !excludedFiles.contains(where: { dependency.filePath?.matches(pattern: $0) ?? true })
    }

    private func shouldReport(for occurrence: IndexStoreOccurrence) -> Bool {
        if filters.isEmpty { return true }
        return occurrence.matches(filters: filters)
    }
}

extension Array {
    fileprivate func concurrentForEach(
        _ body: @escaping @Sendable (Element) async throws -> Void
    ) async throws where Element: Sendable {
        try await withThrowingTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask {
                    try await body(element)
                }
            }
            try await group.waitForAll()
        }
    }
}
