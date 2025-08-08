//
//  Config.swift
//  xcode-indexstore-debug
//
//  Created by p-x9 on 2025/08/09
//  
//

import Foundation
import XcodeIndexStoreDebugCore

struct Config: Codable {
    var reportType: ReportType?
    var filters: [Filter]?
    var excludedFiles: [String]?
}
