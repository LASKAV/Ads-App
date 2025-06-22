import Foundation


protocol APIClient {
    func request<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T
}


final class DefaultAPIClient: APIClient {
    func request<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.method.rawValue

        if let headers = endpoint.headers {
            headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        }

        Logger.log("Request to: \(request.url?.absoluteString ?? "nil")", level: .info)
        Logger.log("Method: \(request.httpMethod ?? "nil")", level: .debug)
        Logger.log("Headers: \(request.allHTTPHeaderFields ?? [:])", level: .debug)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                Logger.log("Invalid response received", level: .error)
                throw NetworkError.invalidResponse
            }

            Logger.log("Status Code: \(httpResponse.statusCode)", level: .info)

            guard 200..<300 ~= httpResponse.statusCode else {
                Logger.log("Server error: \(httpResponse.statusCode)", level: .error)
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }

            let decoded = try JSONDecoder().decode(T.self, from: data)

            return decoded
            
        } catch let error as NetworkError {
            Logger.log(error.localizedDescription, level: .error)

            throw error
            
        } catch {
            Logger.log("Unexpected error: \(error.localizedDescription)", level: .error)
            throw NetworkError.decodingError
        }
    }
}
