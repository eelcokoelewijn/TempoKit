import Foundation
@testable import TempoKit

struct EntitiesStubs {
    var authorDic: [String: Any]
    var author: Author
    var issueType: IssueType
    var issueTypeDic: [String: Any]
    var issueDic: [String: Any]
    var issue: Issue
    var worklogBeanDic: [String: Any]
    var worklogBean: WorklogBean

    init() {
        authorDic = ["name": "Jan",
                     "displayName": "Jan de Man",
                     "avatar": "http://avatar",
                     "self": "http://url"]
        author = Author(name: "Jan",
                        displayName: "Jan de Man",
                        avatar: URL(string: "http://avatar")!,
                        url: URL(string: "http://url")!)
        issueTypeDic = ["name": "task",
                        "iconUrl": "http://icon"]
        issueType = IssueType(name: "task", iconURL: URL(string: "http://icon")!)

        issueDic = ["key": "xxx",
                    "id": 2,
                    "self": "http://issue",
                    "remainingEstimateSeconds": 1000,
                    "summary": "issue summary",
                    "projectId": 1000,
                    "issueType": issueTypeDic]
        issue = Issue(key: "xxx",
                      issueId: 2,
                      url: URL(string: "http://issue")!,
                      remainingEstimateSeconds: 1000,
                      summary: "issue summary",
                      projectId: 1000,
                      issueType: issueType)

        worklogBeanDic = ["id": 1,
                          "comment": "comment",
                          "timeSpentSeconds": 1000,
                          "billedSeconds": 1000,
                          "dateStarted": "2017-02-28",
                          "author": authorDic,
                          "issue": issueDic]

        worklogBean = WorklogBean(worklogId: 1,
                                  comment: "comment",
                                  timeSpentSeconds: 1000,
                                  billedSeconds: 1000,
                                  dateStarted: "2017-02-28",
                                  author: author,
                                  issue: issue)
    }
}
