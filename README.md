# SwiftWhois <a href="https://github.com/isaced/SwiftWhois/actions/workflows/test.yml"><img src="https://github.com/isaced/SwiftWhois/actions/workflows/test.yml/badge.svg"></a> <a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat"></a> <a href="https://raw.githubusercontent.com/isaced/SwiftWhois/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-black"></a>

SwiftWhois is a Swift package that provides a straightforward mechanism for querying Whois information using Apple's Network framework via [NWConnection](https://developer.apple.com/documentation/network/nwconnection). The package aims to abstract the complexity of network communication and parsing to give developers an easy way to implement Whois lookup functionality.

## Features

- [x] Automatically select WHOIS server, no need to specify the WHOIS server
- [x] Structured WHOIS data, easy to use
- [x] Async/await support
- [x] Support for custom WHOIS server

## Requirements

iOS 13.0+ / macOS 10.15+

## Installation

### SPM

```swift
.package(url: "https://github.com/isaced/SwiftWhois.git", from: "0.0.1")
```

## Usage

### Basic

```swift
import SwiftWhois

let result = SwiftWhois.lookup(domain: "google.com")
print(result.domainName) // google.com
print(result.registrar) // MarkMonitor, Inc.
print(result.nameServers) // ["ns1.google.com", "ns2.google.com", "ns3.google.com", "ns4.google.com"]
print(result.creationDate) // 1997-09-15T00:00:00Z
print(result.expirationDate) // 2028-09-14T00:00:00Z
print(result.updatedDate) // 2021-08-17T17:32:39Z
print(result.domainStatus) // ["clientDeleteProhibited", "clientTransferProhibited", ...]
print(result.raw) // Raw WHOIS data
```

### Custom WHOIS server

Usually, you don't need to specify the WHOIS server, SwiftWhois will automatically select the WHOIS server for you. But if you want to specify the WHOIS server, you can do it like this:

```swift
SwiftWhois.lookup(domain: "google.com", server: "whois.verisign-grs.com")
```

## Principle

SwiftWhois leverages NWConnection to perform network operations for Whois protocol interactions. It simplifies the process of fetching and interpreting Whois data, encapsulating the logic required to manage network connectivity and data handling.

### How it works

1. Server Discovery: Determines the appropriate Whois server for a given domain or IP address by querying `whois.iana.org` by default, unless an alternative Whois server is specified.
2. Connection: Initiates an NWConnection to the determined Whois server, typically on port 43.
   Query Assembly: Creates a properly formatted Whois query for the given domain or IP address based on the server's requirements.
3. Dispatch: Sends the assembled query asynchronously to the Whois server and awaits a response.
4. Reception & Parsing: Receives the server's response, which is a textual Whois record, and parses it to extract meaningful data into a structured representation.
5. Closure: Completes the operation by delivering the parsed Whois information or an error, if encountered, then terminates the network connection.

## TODO

- [ ] WHOIS server cache (in-memory, for speed up)
- [ ] More TLDs (Top-Level Domains) test and support

## Contributing & Support

- Any TLDs (Top-Level Domains) that are not supported, please open an [issue](https://github.com/isaced/SwiftWhois/issues/new) or [PR](https://github.com/isaced/SwiftWhois/pulls).
- Any bugs or feature requests, please open an [issue](https://github.com/isaced/SwiftWhois/issues/new).

## License

MIT
