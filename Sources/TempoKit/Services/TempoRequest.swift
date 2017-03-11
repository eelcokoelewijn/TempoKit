import Foundation

public protocol TempoRequest {
    var params: [String: String] { get }
    var method: String { get }
    var url: URL { get }
    var headers: [String: String] { get }
}
