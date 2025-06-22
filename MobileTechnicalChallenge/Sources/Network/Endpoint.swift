import Foundation


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Endpoint {
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var url: URL { get }
}

struct AdsEndpoint: Endpoint {
    var method: HTTPMethod = .get
    var headers: [String: String]? = ["Accept": "application/json"]

    var url: URL {
        URL(string: "https://gist.githubusercontent.com/baldermork/6a1bcc8f429dcdb8f9196e917e5138bd/raw/discover.json")!
    }
}

