import Foundation

public struct JIRACredentials {
    public let username: String
    public let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension JIRACredentials: Equatable {
    static public func == (lhs: JIRACredentials, rhs: JIRACredentials) -> Bool {
            return lhs.username == rhs.username &&
                lhs.password == rhs.password
    }
}
