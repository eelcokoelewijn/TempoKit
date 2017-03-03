import Foundation

public protocol NetworkService {
    func load(worklog: Request, completion: (([[String: Any]]) -> Void))
}

protocol UsesNetworkService {
    var networkService: NetworkService { get }
}
