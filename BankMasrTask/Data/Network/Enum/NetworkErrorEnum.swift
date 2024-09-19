//
//  NetworkErrorEnum.swift
//  BankNasrMovieApp
//
//  Created by Eslam ALi on 17/09/2024.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case serverError
    case unauthorized
    case dataNotFound
    case decodingFailed
    case unknownError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .serverError:
            return "The server encountered an error."
        case .unauthorized:
            return "Unauthorized request."
        case .dataNotFound:
            return "The data could not be found."
        case .decodingFailed:
            return "Failed to decode the data."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
