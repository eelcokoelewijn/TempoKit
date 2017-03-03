import Foundation

public protocol Request {
    var params: [String: String] { get }
    var method: String { get }
    var url: URL { get }
}
