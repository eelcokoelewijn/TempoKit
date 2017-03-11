import Foundation

public struct JIRACredentials {
    public let username: String
    public let password: String
}

extension JIRACredentials: Equatable {
    static public func == (lhs: JIRACredentials, rhs: JIRACredentials) -> Bool {
            return lhs.username == rhs.username &&
                lhs.password == rhs.password
    }
}
