//
//  SwiftWhoisTests.swift
//
//
//  Created by isaced on 2023/12/20.
//

import XCTest
@testable import SwiftWhois

final class SwiftWhoisTests: XCTestCase {
    func testFindWhoisServer() async throws {
        let whoisServer = try await SwiftWhois.findWhoisServer(for: "google.com")
        XCTAssert(whoisServer == "whois.verisign-grs.com")
    }
    
    func testIANAQuery() async throws {
        let response = try await SwiftWhois.queryIANA(for: "google.com")
        XCTAssert(((response?.starts(with: "% IANA WHOIS server")) != nil))
    }
    
    func testComQuery() async throws {
        let whoisInfo = try await SwiftWhois.lookup(domain: "google.com")
        XCTAssert(whoisInfo?.domainName?.lowercased() == "google.com")
        XCTAssert(whoisInfo?.registrar?.lowercased() == "markmonitor inc.")
        XCTAssert(whoisInfo?.creationDate?.description == "1997-09-15T04:00:00Z")
        XCTAssert(whoisInfo?.nameServers?.count ?? 0 > 0)
    }
    
    func testOrgDomainQuery() async throws {
        let whoisInfo = try await SwiftWhois.lookup(domain: "google.org")
        XCTAssert(whoisInfo?.domainName?.lowercased() == "google.org")
    }
    
    func testCnDomainQuery() async throws {
        let whoisInfo = try await SwiftWhois.lookup(domain: "google.cn")
        XCTAssert(whoisInfo?.domainName?.lowercased() == "google.cn")
    }
    
    func testIngDomainQuery() async throws {
        let whoisInfo = try await SwiftWhois.lookup(domain: "google.ing")
        XCTAssert(whoisInfo?.domainName?.lowercased() == "google.ing")
    }
    
    func testChineseDomainQuery() async throws {
        let whoisInfo = try await SwiftWhois.lookup(domain: "你好.中国")
        XCTAssert(whoisInfo?.domainName?.lowercased() == "你好.中国")
    }
    
    func testWrongDomainQuery() async throws {
        let whoisInfo = try await SwiftWhois.lookup(domain: "abc.defghijkerror")
        XCTAssertNil(whoisInfo)
    }
}
      
