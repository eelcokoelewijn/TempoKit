import Foundation

public protocol TempoKit {
    func worklogs(dateFrom: String,
                 dateTo: String?,
                 username: String?,
                 projectKey: String?,
                 accountKey: String?,
                 teamId: String?,
                 completion: (([WorklogBean]) -> Void))
}

public protocol UsesTempoKit {
    var tempoKit: TempoKit { get }
}

public class MixinTempoKit: TempoKit, UsesTempoNetworkService {
    internal let tempoNetworkService: TempoNetworkService
    private let baseURL: URL
    
    public init(baseURL: URL, networkService: TempoNetworkService) {
        tempoNetworkService = networkService
        self.baseURL = baseURL
    }
    
    public func worklogs(dateFrom: String,
                         dateTo: String? = nil,
                         username: String? = nil,
                         projectKey: String? = nil,
                         accountKey: String? = nil,
                         teamId: String? = nil,
                         completion: (([WorklogBean]) -> Void)) {
        let worklogRequest = Worklog(dateFrom: dateFrom,
                       dateTo: dateTo,
                       username: username,
                       projectKey: projectKey,
                       accountKey: accountKey,
                       teamId: teamId,
                       baseURL: baseURL)
        tempoNetworkService.load(worklog: worklogRequest) { json in
            completion(parse(jsonLogs: json))            
        }
    }
    
    private func parse(jsonLogs: [[String: Any]]) -> [WorklogBean] {
        return jsonLogs.flatMap { log in
            WorklogBean(json: log)
        }
    }
}
