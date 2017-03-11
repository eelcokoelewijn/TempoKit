import Foundation

public protocol TempoKit {
    func worklogs(dateFrom: String,
                 dateTo: String?,
                 username: String?,
                 projectKey: String?,
                 accountKey: String?,
                 teamId: String?,
                 completion: @escaping ([WorklogBean]) -> Void)
}

public protocol UsesTempoKit {
    var tempoKit: TempoKit { get }
}

public class MixinTempoKit: TempoKit, UsesTempoNetworkService {
    internal let tempoNetworkService: TempoNetworkService
    private let baseURL: URL
    private let credentials: JIRACredentials
    
    public init(baseURL: URL, networkService: TempoNetworkService, credentials: JIRACredentials) {
        tempoNetworkService = networkService
        self.baseURL = baseURL
        self.credentials = credentials
    }
    
    public func worklogs(dateFrom: String,
                         dateTo: String? = nil,
                         username: String? = nil,
                         projectKey: String? = nil,
                         accountKey: String? = nil,
                         teamId: String? = nil,
                         completion: @escaping ([WorklogBean]) -> Void) {
        let worklogRequest = Worklog(dateFrom: dateFrom,
                       dateTo: dateTo,
                       username: username,
                       projectKey: projectKey,
                       accountKey: accountKey,
                       teamId: teamId,
                       baseURL: baseURL,
                       credentials: credentials)
        tempoNetworkService.load(worklog: worklogRequest) { json in
            completion(self.parse(jsonLogs: json))            
        }
    }
    
    private func parse(jsonLogs: [[String: Any]]) -> [WorklogBean] {
        return jsonLogs.flatMap { log in
            WorklogBean(json: log)
        }
    }
}
