import Foundation

//    author
//    {
//      name:string
//      displayName:string
//      avatar:url
//      self:url
//    }

public struct Author {
    public let name: String
    public let displayName: String
    public let avatar: URL
    public let url: URL
}

extension Author {
    public init?(json: [String: Any]) {
        guard let name = json["name"] as? String else { return nil }
        self.name = name
        guard let displayName = json["displayName"] as? String else { return nil }
        self.displayName = displayName
        guard let aurl = json["avatar"] as? String,
            let avatarURL = URL(string: aurl) else { return nil }
        self.avatar = avatarURL
        guard let surl = json["self"] as? String,
            let selfURL = URL(string: surl) else { return nil }
        self.url = selfURL
    }
}

extension Author: Equatable {
    public static func == (lhs: Author, rhs: Author) -> Bool {
            return lhs.name == rhs.name &&
                lhs.displayName == rhs.displayName &&
                lhs.avatar == rhs.avatar &&
                lhs.url == rhs.url
    }
}
