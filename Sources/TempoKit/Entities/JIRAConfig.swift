import Foundation

public struct JIRAConfig {
    let url: URL
    let credentials: JIRACredentials
    
    public init(url: URL, credentials: JIRACredentials) {
        self.url = url
        self.credentials = credentials
    }
}

extension JIRAConfig {
    public func toJSON() -> [String: Any] {
        return ["url": url.absoluteString,
                "username": credentials.username,
                "password": credentials.password]
    }
    
    public init?(json: [String: Any]) {
        guard let urlString = json["url"] as? String,
            let url = URL(string: urlString) else { return nil }
        
        guard let username = json["username"] as? String else { return nil }
        guard let password = json["password"] as? String else { return nil }
        
        self.url = url
        credentials = JIRACredentials(username: username, password: password)
    }
}

extension JIRAConfig: Equatable {
    public static func == (lhs: JIRAConfig, rhs: JIRAConfig) -> Bool {
        return lhs.url == rhs.url &&
            lhs.credentials == rhs.credentials
    }
}
