//
//  IndexStoreReporter.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/09
//  
//

import Foundation
import SwiftIndexStore

public final class IndexStoreReporter {
    public let reportType: ReportType
    public let reporter: any ReporterProtocol
    public let filters: [Filter]
    public let excludedFiles: [String]
    public let indexStore: IndexStore

    public init(
        reportType: ReportType,
        reporter: any ReporterProtocol,
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
            try indexStore.forEachRecordDependencies(for: unit) { dependency in
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
}

extension IndexStoreReporter {
    private func reportIfNeeded(for occurrence: IndexStoreOccurrence) {
        if shoudlReport(for: occurrence) {
            report(for: occurrence)
        }
    }
}

extension IndexStoreReporter {
    private func report(for occurrence: IndexStoreOccurrence) {
        reporter.report(
            file: occurrence.location.path,
            line: numericCast(occurrence.location.line),
            column: numericCast(occurrence.location.column),
            type: reportType,
            content: "usr: \(occurrence.symbol.usr!)"
        )
    }

    private func shoudlReport(for occurrence: IndexStoreOccurrence) -> Bool {
        if let path = occurrence.location.path,
           excludedFiles.contains(where: { path.matches(pattern: $0) }) {
            return false
        }
        return occurrence.matches(filters: filters)
    }
}
