import Foundation

public protocol TempoNetworkService {
    func load(worklog: TempoRequest, completion: @escaping ([[String: Any]]) -> Void)
}

protocol UsesTempoNetworkService {
    var tempoNetworkService: TempoNetworkService { get }
}
