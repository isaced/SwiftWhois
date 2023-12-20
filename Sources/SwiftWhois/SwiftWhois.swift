import Foundation

/**
    The main class for SwiftWhois. Use this to query the Whois server for a domain.
*/
public struct SwiftWhois {

    /**
        Cache of TLDs and their Whois servers
        - Note: This list is not exhaustive, more will be auto-discovered   
    */
    static let cacheTldWhoisServer: [String: String] = [
        "com": "whois.verisign-grs.com",
        "net": "whois.verisign-grs.com",
        "org": "whois.publicinterestregistry.org",
        "cn": "whois.cnnic.cn",
        "ai": "whois.nic.ai",
        "au": "whois.auda.org.au",
        "co": "whois.nic.co",
        "ca": "whois.cira.ca",
        "do": "whois.nic.do",
        "gl": "whois.nic.gl",
        "in": "whois.registry.in",
        "io": "whois.nic.io",
        "it": "whois.nic.it",
        "me": "whois.nic.me",
        "ro": "whois.rotld.ro",
        "rs": "whois.rnids.rs",
        "so": "whois.nic.so",
        "us": "whois.nic.us",
        "ws": "whois.website.ws",
        "agency": "whois.nic.agency",
        "app": "whois.nic.google",
        "biz": "whois.nic.biz",
        "dev": "whois.nic.google",
        "house": "whois.nic.house",
        "info": "whois.nic.info",
        "link": "whois.uniregistry.net",
        "live": "whois.nic.live",
        "nyc": "whois.nic.nyc",
        "one": "whois.nic.one",
        "online": "whois.nic.online",
        "shop": "whois.nic.shop",
        "site": "whois.nic.site",
        "xyz": "whois.nic.xyz"
    ]
    
    /**
        Lookup the Whois data for the domain
        - Parameter domain: The domain to query, e.g. "google.com"
        - Parameter server: The Whois server to use, will be found automatically if not provided
        - Returns: The Whois data
     */
    public static func lookup(domain: String, server: String? = nil) async throws -> WhoisData? {
        var whoisServer = server

        // Find the Whois server if not provided
        if whoisServer == nil { 
            if let cachedWhoisServer = findCachedWhoisServer(for: domain) {
                whoisServer = cachedWhoisServer
            }else{
                whoisServer = try await findWhoisServer(for: domain) 
            }
        }

        // Return nil if no Whois server was found
        guard let whoisServer = whoisServer else { return nil }
        
        // Query the Whois server
        if let whoisRawData = try await SwiftWhoisNetwork.whoisQuery(domain: domain, server: whoisServer) {
            return SwiftWhoisParser.parseWhoisResponse(whoisRawData)
        }
        return nil
    }
    
    /**
        Query the IANA server for the domain
        - Parameter domain: The domain to query
        - Returns: The raw IANA data
    */
    static func queryIANA(for domain: String) async throws -> String? {
        return try await SwiftWhoisNetwork.whoisQuery(domain: domain, server: "whois.iana.org")
    }
    
    /**
        Find the Whois server for the domain
        - Parameter domain: The domain to query
        - Returns: The Whois server for the domain
    */
    static func findWhoisServer(for domain: String) async throws -> String? {
        if let ianaResponse = try await queryIANA(for: domain) {
            return SwiftWhoisParser.extractWhoisServer(from: ianaResponse)
        }
        return nil
    }

    static func findCachedWhoisServer(for domain: String) -> String? {
        let tld = domain.components(separatedBy: ".").last ?? ""
        return cacheTldWhoisServer[tld]
    }
}
