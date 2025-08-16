# xcode-indexstore-debug

A build tool plugin for reporting the contents of Xcode's IndexStore in a customizable format.

This project is designed for developers who want to analyze, filter, and report symbol and occurrence data from Xcode projects.

## Features

- Reports IndexStore contents as errors or warnings for integration with Xcode and CI workflows
- Supports YAML-based configuration for flexible filtering and exclusion
- Provides a SwiftPM build tool plugin for easy integration

## Requirements

- macOS 13 or later
- Swift 6.0 or later

## Usage

### Plugin

Add the plugin to your `Package.swift`:

```swift
.plugins([
    .plugin(name: "IndexStoreDebugBuildToolPlugin", package: "xcode-indexstore-debug")
])
```

### Command Line

Run the tool with:

```sh
.build/release/xcode-indexstore-debug --index-store-path <path-to-IndexStore> [--config <config.yml>] [--report-type error|warning]
```

- `--index-store-path`: Path to the IndexStore directory (optional if `BUILD_DIR` is set)
- `--config`: Path to a YAML config file (default: `.xcode-indexstore-debug.yml`)
- `--report-type`: Output as `error` or `warning` (default: error)

### Example Config File (`.xcode-indexstore-debug.yml`)

A config file that can be customized with only comment-outs is available in [.xcode-indexstore-debug.yml](./.xcode-indexstore-debug.yml).

```yaml
reportType: warning
filters:
  - conditions:
      - usr: ".*"
      - name: ".*"
      - system: false
      - role: ["definition", "reference"]
      - kind: ["class", "struct"]
      - subKind: []
      - language: ["swift"]
excludedFiles:
  - ".*/DerivedData/.*"
```

## License

xcode-indexstore-debug is released under the MIT License. See [LICENSE](./LICENSE)
