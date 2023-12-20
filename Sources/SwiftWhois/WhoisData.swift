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
    var domainName: String?

    /// The registrar
    var registrar: String?

    /// The registrar Whois server
    var registrarWhoisServer: String?

    /// The registrant contact email
    var registrantContactEmail: String?

    /// The registrant
    var registrant: String?

    /// The creation date
    var creationDate: String?

    /// The expiration date
    var expirationDate: String?

    /// The last updated date
    var updateDate: String?

    /// The name servers, e.g. ns1.google.com
    var nameServers: [String]?

    /// The domain status, e.g. clientTransferProhibited
    var domainStatus: [String]?

    /// The raw Whois data
    var rawData: String?
}
