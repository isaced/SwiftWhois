# SwiftWhois

SwiftWhois is a Swift library for retrieving WHOIS information of domains.

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
