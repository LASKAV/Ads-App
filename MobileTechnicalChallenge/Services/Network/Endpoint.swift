import Foundation


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol Endpoint {
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var url: URL { get }
}
