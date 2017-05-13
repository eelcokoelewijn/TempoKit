import Foundation

public struct WorklogBean {
    public let worklogId: Int
    public let comment: String
    public let timeSpentSeconds: Int
    public let billedSeconds: Int
    public let dateStarted: String //YYYY-MM-ddT00:00:00.000+0000
    public let author: Author
    public let issue: Issue
}

extension WorklogBean {
    public init?(json: [String: Any]) {
        guard let worklogId = json["id"] as? Int else { return nil }
        self.worklogId = worklogId
        guard let comment = json["comment"] as? String else { return nil }
        self.comment = comment
        guard let timeSpentSeconds = json["timeSpentSeconds"] as? Int else { return nil }
        self.timeSpentSeconds = timeSpentSeconds
        guard let billedSeconds = json["billedSeconds"] as? Int else { return nil }
        self.billedSeconds = billedSeconds
        guard let dateStarted = json["dateStarted"] as? String else { return nil }
        self.dateStarted = dateStarted
        guard let authorJSON = json["author"] as? [String: Any],
            let author = Author(json: authorJSON) else { return nil }
        self.author = author

        guard let issueJSON = json["issue"] as? [String: Any],
            let issue = Issue(json: issueJSON) else { return nil }
        self.issue = issue
    }
}

extension WorklogBean: Equatable {
    public static func == (lhs: WorklogBean, rhs: WorklogBean) -> Bool {
            return lhs.worklogId == rhs.worklogId &&
                lhs.comment == rhs.comment &&
                lhs.timeSpentSeconds == rhs.timeSpentSeconds &&
                lhs.billedSeconds == rhs.billedSeconds &&
                lhs.dateStarted == rhs.dateStarted &&
                lhs.author == rhs.author
    }
}
