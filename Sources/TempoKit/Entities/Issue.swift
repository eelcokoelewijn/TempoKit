import Foundation

//    issue:
//    {
//      key:string
//      id:number
//      self:url
//      remainingEstimateSeconds:number
//      summary:string
//      issueType:
//      {
//          name:string
//          iconUrl:string
//      }
//      projectId:number
//    }

// MARK: Issue

public struct Issue {
    public let key: String
    public let issueId: Int
    public let url: URL
    public let remainingEstimateSeconds: Int
    public let summary: String
    public let projectId: Int
    public let issueType: IssueType
}

extension Issue {
    public init?(json: [String: Any]) {
        guard let key = json["key"] as? String else { return nil }
        self.key = key
        guard let issueId = json["id"] as? Int else { return nil }
        self.issueId = issueId
        guard let url = json["self"] as? String,
            let selfURL = URL(string: url) else { return nil }
        self.url = selfURL
        guard let remainingEstimateSeconds = json["remainingEstimateSeconds"] as? Int else { return nil }
        self.remainingEstimateSeconds = remainingEstimateSeconds
        guard let summary = json["summary"] as? String else { return nil }
        self.summary = summary
        guard let projectId = json["projectId"] as? Int else { return nil }
        self.projectId = projectId
        guard let issueTypeJSON = json["issueType"] as? [String: Any],
            let issueType = IssueType(json: issueTypeJSON) else { return nil }
        self.issueType = issueType
    }
}

extension Issue: Equatable {
    public static func == (lhs: Issue, rhs: Issue) -> Bool {
        return lhs.key == rhs.key &&
            lhs.issueId == rhs.issueId &&
            lhs.url == rhs.url &&
            lhs.remainingEstimateSeconds == rhs.remainingEstimateSeconds &&
            lhs.summary == rhs.summary &&
            lhs.projectId == rhs.projectId &&
            lhs.issueType == rhs.issueType
    }
}

// MARK: Issue type

public struct IssueType {
    public let name: String
    public let iconURL: URL
}

extension IssueType {
    public init?(json: [String: Any]) {
        guard let name = json["name"] as? String else { return nil }
        self.name = name

        guard let url = json["iconUrl"] as? String,
            let iconURL = URL(string: url) else { return nil }
        self.iconURL = iconURL
    }
}

extension IssueType: Equatable {
    public static func == (lhs: IssueType, rhs: IssueType) -> Bool {
            return lhs.name == rhs.name &&
                lhs.iconURL == rhs.iconURL
    }
}
