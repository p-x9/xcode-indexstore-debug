import Foundation
import ArgumentParser
import SwiftIndexStore
import Yams
import SourceReporter
import XcodeIndexStoreDebugCore

struct xcode_indexstore_debug: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: "xcode-indexstore-debug",
        abstract: "Reports the contents of the IndexStore in the specified format.",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )

    @Option(help: "Report as `error` or `warning` (default: error)")
    var reportType: ReportType?

    @Option(
        help: "Config",
        completion: .file(extensions: ["yml", "yaml"])
    )
    var config: String = ".xcode-indexstore-debug.yml"

    @Option(
        help: "Path for IndexStore",
        completion: .directory
    )
    var indexStorePath: String?

    var filters: [Filter] = []
    var excludedFiles: [String] = []

    lazy var indexStore: IndexStore? = {
        if let indexStorePath = indexStorePath ?? environmentIndexStorePath,
           FileManager.default.fileExists(atPath: indexStorePath) {
            let url = URL(fileURLWithPath: indexStorePath)
            return try? .open(store: url, lib: .open())
        } else {
            return nil
        }
    }()

    mutating func run() throws {
        guard let indexStore else {
            fatalError("No IndexStore found at specified path or in environment variable BUILD_DIR")
        }
        try readConfig()
        let reporter = IndexStoreReporter(
            reportType: reportType ?? .warning,
            reporter: XcodeReporter(),
            filters: filters,
            excludedFiles: excludedFiles,
            indexStore: indexStore
        )
        try reporter.run()
    }
}

extension xcode_indexstore_debug {
    private mutating func readConfig() throws {
        guard FileManager.default.fileExists(atPath: config) else {
            return
        }
        let url = URL(fileURLWithPath: config)
        let decoder = YAMLDecoder()

        let data = try Data(contentsOf: url)
        let config = try decoder.decode(Config.self, from: data)

        filters = config.filters ?? []
        excludedFiles = config.excludedFiles ?? []

        if reportType == nil {
            self.reportType = config.reportType
        }
    }
}

extension xcode_indexstore_debug {
    var environmentIndexStorePath: String? {
        let environment = ProcessInfo.processInfo.environment
        guard let buildDir = environment["BUILD_DIR"] else { return nil }
        let url = URL(fileURLWithPath: buildDir)
        return url
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appending(path: "Index.noindex/DataStore/")
            .path()
    }
}

xcode_indexstore_debug.main()
