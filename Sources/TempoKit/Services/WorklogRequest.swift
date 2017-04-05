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
    let credentials: JIRACredentials
    
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
    
    var headers: [String : String] {
        get {
            let basic = Data("\(credentials.username):\(credentials.password)".utf8).base64EncodedString()
            return ["Authorization": "Basic \(basic)"]
        }
    }
    
    init(dateFrom: String,
         dateTo: String? = nil,
         username: String? = nil,
         projectKey: String? = nil,
         accountKey: String? = nil,
         teamId: String? = nil,
         config: JIRAConfig) {
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.username = username
        self.projectKey = projectKey
        self.accountKey = accountKey
        self.teamId = teamId
        self.url = URL(string: url.absoluteString, relativeTo: config.url)!
        self.credentials = config.credentials
    }
}
