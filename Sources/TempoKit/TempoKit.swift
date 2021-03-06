import Foundation

public protocol TempoKit {
    // swiftlint:disable function_parameter_count
    func worklogs(dateFrom: String,
                  dateTo: String?,
                  username: String?,
                  projectKey: String?,
                  accountKey: String?,
                  teamId: String?,
                  completion: @escaping ([WorklogBean]) -> Void)
    // swiftlint:enable function_parameter_count
}

public protocol UsesTempoKit {
    var tempoKit: TempoKit { get }
}

public class MixinTempoKit: TempoKit, UsesTempoNetworkService {
    internal let tempoNetworkService: TempoNetworkService
    private let config: JIRAConfig

    public init(networkService: TempoNetworkService, config: JIRAConfig) {
        tempoNetworkService = networkService
        self.config = config
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
                       config: config)
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
