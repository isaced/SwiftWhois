//
//  SwiftWhoisParserTest.swift
//
//
//  Created by isaced on 2023/12/20.
//

import XCTest
@testable import SwiftWhois

final class SwiftWhoisParserTests: XCTestCase {
    func testExtractWhoisServer() throws {
        let whoisServer = SwiftWhoisParser.extractWhoisServer(from: """

whois:        whois.verisign-grs.com

status:       ACTIVE
""")
        XCTAssert(whoisServer == "whois.verisign-grs.com")
    }
    
    func testWhoisParse() throws {
        let whoisResponse = """
        Domain Name: GOOGLE.COM
        Registry Domain ID: 2138514_DOMAIN_COM-VRSN
        Registrar WHOIS Server: whois.markmonitor.com
        Registrar URL: http://www.markmonitor.com
        Updated Date: 2019-09-09T15:39:04Z
        Creation Date: 1997-09-15T04:00:00Z
        Registry Expiry Date: 2028-09-14T04:00:00Z
        Registrar: MarkMonitor Inc.
        Name Server: NS1.GOOGLE.COM
        Name Server: NS2.GOOGLE.COM
        """

        let whoisInfo = SwiftWhoisParser.parseWhoisResponse(whoisResponse)
        XCTAssert(whoisInfo.domainName?.lowercased() == "google.com")
        XCTAssert(whoisInfo.registrar?.lowercased() == "markmonitor inc.")
        XCTAssert(whoisInfo.creationDate?.description == "1997-09-15T04:00:00Z")
        XCTAssert(whoisInfo.updateDate?.description == "2019-09-09T15:39:04Z")
        XCTAssert(whoisInfo.expirationDate?.description == "2028-09-14T04:00:00Z")
        XCTAssert(whoisInfo.nameServers?.count ?? 0 == 2)
        XCTAssert(whoisInfo.nameServers?[0] == "ns1.google.com")
        XCTAssert(whoisInfo.nameServers?[1] == "ns2.google.com")
    }
}
