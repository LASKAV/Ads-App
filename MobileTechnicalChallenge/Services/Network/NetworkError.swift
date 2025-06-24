import Foundation

enum NetworkError: Error, LocalizedError, Equatable {
    case invalidResponse
    case invalidURL
    case noInternet
    case timeout
    case decodingError
    case serverError(statusCode: Int)
    case unauthorized
    case forbidden
    case notFound
    case custom(message: String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .noInternet:
            return "No internet connection."
        case .timeout:
            return "The request timed out."
        case .decodingError:
            return "Failed to decode response."
        case .serverError(let statusCode):
            return "Server returned error with status code: \(statusCode)."
        case .unauthorized:
            return "You are not authorized to perform this action."
        case .forbidden:
            return "Access is forbidden."
        case .notFound:
            return "Requested resource not found."
        case .custom(let message):
            return message
        }
    }
}

