//
//  NetworkManager.swift
//  BankNasrMovieApp
//
//  Created by Eslam ALi on 17/09/2024.
//

import Foundation


//  network errors
import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func request<T: Decodable>(
        from urlString: String,
        method: HTTPMethod = .get,
        params: [String: String]? = nil,
        body: Data? = nil,
        headers: [String: String]? = nil,
        decodeType: T.Type
    ) async throws -> T {
        // Construct URL with parameters if any
        guard var urlComponents = URLComponents(string: urlString) else {
            throw NetworkError.invalidURL
        }

        if let params = params {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        // Create URL request and set method, headers, and body
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        if let body = body {
            request.httpBody = body
        }

        do {
            // Perform network request
            let (data, response) = try await URLSession.shared.data(for: request)

            // Check for HTTP response status codes
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299:
                    break // Success case, do nothing
                case 401:
                    throw NetworkError.unauthorized // Handle unauthorized requests
                case 400...499:
                    throw NetworkError.serverError // Handle client errors
                case 500...599:
                    throw NetworkError.serverError // Handle server errors
                default:
                    throw NetworkError.unknownError
                }
            }

            // Decode response data
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData

        } catch is DecodingError {
            throw NetworkError.decodingFailed
        } catch {
            throw error
        }
    }
}
