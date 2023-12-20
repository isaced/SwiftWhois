# SwiftWhois <a href="https://github.com/isaced/SwiftWhois/actions/workflows/test.yml"><img src="https://github.com/isaced/SwiftWhois/actions/workflows/test.yml/badge.svg"></a> <a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat"></a> <a href="https://raw.githubusercontent.com/isaced/SwiftWhois/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-black"></a>

SwiftWhois is a Swift library for retrieving WHOIS information of domains.

## Features

- [x] Automatically select WHOIS server, no need to specify the WHOIS server
- [x] Structured WHOIS data, easy to use
- [x] Async/await support

## Requirements

iOS 13.0+ / macOS 10.15+ / tvOS 12.0+ / watchOS 7.0+

## Installation

### SPM

```swift
.package(url: "https://github.com/isaced/SwiftWhois.git", from: "0.0.1")
```

## Usage

```swift
import SwiftWhois

let result = SwiftWhois.lookup(domain: "google.com")
print(result.domainName) // google.com
print(result.registrar) // MarkMonitor, Inc.
print(result.nameServers) // ["ns1.google.com", "ns2.google.com", "ns3.google.com", "ns4.google.com"]
print(result.creationDate) // 1997-09-15T00:00:00Z
print(result.expirationDate) // 2028-09-14T00:00:00Z
print(result.updatedDate) // 2021-08-17T17:32:39Z
print(result.raw) // Raw WHOIS data
```

## License

MIT
