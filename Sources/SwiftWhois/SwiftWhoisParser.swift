//
//  SwiftWhoisParser.swift
//  
//
//  Created by isaced on 2023/12/20.
//

import Foundation

struct SwiftWhoisParser {
    /// Extract the Whois server from the IANA response
    static func extractWhoisServer(from response: String) -> String? {
        let lines = response.split(separator: "\n")
        
        for line in lines {
            if line.lowercased().starts(with: "whois:") {
                let server = line.split(separator: ":")
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    .last
                return server
            }
        }
        
        return nil
    }
    
    /// Parse the raw Whois response into a WhoisData object
    static func parseWhoisResponse(_ response: String) -> WhoisData {
        var whoisData = WhoisData()
        let standardizedResponse = response.replacingOccurrences(of: "\r\n", with: "\n")
        let lines = standardizedResponse.split(separator: "\n")
        for line in lines {
            let parts = line.split(separator: ":", maxSplits: 1).map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            guard parts.count == 2 else { continue }
            
            let key = parts[0].lowercased()
            let value = parts[1]
            
            switch key {
            case "domain name":
                if whoisData.domainName == nil { whoisData.domainName = value }
            case "registrant":
                if whoisData.registrant == nil { whoisData.registrant = value }
            case "registrant contact email", "registrant email":
                if whoisData.registrantContactEmail == nil { whoisData.registrantContactEmail = value }
            case "registrar whois server":
                if whoisData.registrarWhoisServer == nil { whoisData.registrarWhoisServer = value }
            case "registrar", "sponsoring registrar":
                if whoisData.registrar == nil { whoisData.registrar = value }
            case "creation date", "created", "registration time":
                if whoisData.creationDate == nil { whoisData.creationDate = value }
            case "expiration date", "expires on", "registry expiry date", "registrar registration expiration date", "expiration time":
                if whoisData.expirationDate == nil { whoisData.expirationDate = value }
            case "updated date", "last updated":
                if whoisData.updateDate == nil { whoisData.updateDate = value }
            case "name server":
                var nameServers = whoisData.nameServers ?? []
                nameServers.append(value.lowercased())
                whoisData.nameServers = nameServers
            case "domain status":
                var domainStatus = whoisData.domainStatus ?? []

                // "clientDeleteProhibited https://icann.org/epp#clientDeleteProhibited"
                if let status = value.split(separator: " ").first, !status.isEmpty {
                    domainStatus.append(String(status))
                }

                whoisData.domainStatus = domainStatus
            default:
                break
            }
        }
        whoisData.rawData = response
        return whoisData
    }
}
