import Foundation

public protocol TempoNetworkService {
    func load(worklog: TempoRequest, completion: (([[String: Any]]) -> Void))
}

protocol UsesTempoNetworkService {
    var tempoNetworkService: TempoNetworkService { get }
}
