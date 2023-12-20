//
//  WhoisData.swift
//
//
//  Created by isaced on 2023/12/20.
//

import Foundation

/// The data returned from a Whois query
public struct WhoisData {
    /// The domain name, e.g. example.com
    public var domainName: String?

    /// The registrar
    public var registrar: String?

    /// The registrar Whois server
    public var registrarWhoisServer: String?

    /// The registrant contact email
    public var registrantContactEmail: String?

    /// The registrant
    public var registrant: String?

    /// The creation date
    public var creationDate: String?

    /// The expiration date
    public var expirationDate: String?

    /// The last updated date
    public var updateDate: String?

    /// The name servers, e.g. ns1.google.com
    public var nameServers: [String]?

    /// The domain status, e.g. clientTransferProhibited
    public var domainStatus: [String]?

    /// The raw Whois data
    public var rawData: String?
}
