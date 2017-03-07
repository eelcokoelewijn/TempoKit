import Foundation

struct Worklog: TempoRequest {
    var url: URL = URL(string: "/rest/tempo-timesheets/3/worklogs/")!
    let method: String = "GET"
    let dateFrom: String
    let dateTo: String?
    let username: String?
    let projectKey: String?
    let accountKey: String?
    let teamId: String?
    
    var params: [String : String] {
        get {
            return ["dateFrom": dateFrom,
                    "dateTo": dateTo ?? "",
                    "username": username ?? "",
                    "projectKey": projectKey ?? "",
                    "accountKey": accountKey ?? "",
                    "teamId": teamId ?? ""]
        }
    }
    
    init(dateFrom: String,
         dateTo: String? = nil,
         username: String? = nil,
         projectKey: String? = nil,
         accountKey: String? = nil,
         teamId: String? = nil,
         baseURL: URL) {
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.username = username
        self.projectKey = projectKey
        self.accountKey = accountKey
        self.teamId = teamId
        self.url = URL(string: url.absoluteString, relativeTo: baseURL)!
    }
}
