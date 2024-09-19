//
//  TMDbAPI.swift
//  BankNasrMovieApp
//
//  Created by Eslam ALi on 17/09/2024.
//

import Foundation

// Model to decode the movie list from TMDb API
struct MovieResponse: Decodable {
    let results: [Movie]
}

enum MovieCategory: String {
    case nowPlaying = "now_playing"
    case popular = "popular"
    case upcoming = "upcoming"
}

class TMDbAPI {
    private let apiKey = "35efdde9a4081d134b9f3aa0924ebfe6" // Replace with your TMDb API key
    private let baseURL = "https://api.themoviedb.org/3/movie/"
    

    // General method to fetch movies by category using NetworkManager
    private func fetchMovies(for category: MovieCategory) async throws -> [Movie] {
        let endpoint = "\(baseURL)\(category.rawValue)"
        let params = ["api_key": apiKey]  // Add query parameters such as API key
        
        return try await NetworkManager.shared.request(
            from: endpoint,
            params: params,
            decodeType: MovieResponse.self
        ).results
    }
    
    // Fetch detailed movie information by movie ID
       func fetchMovieDetails(for movieID: Int) async throws -> Movie {
           let endpoint = "\(baseURL)\(movieID)"
           let params = ["api_key": apiKey]  // Add query parameters such as API key

           return try await NetworkManager.shared.request(
               from: endpoint,
               params: params,
               decodeType: Movie.self
           )
       }

    // Fetch Now Playing Movies
    func fetchNowPlayingMovies() async throws -> [Movie] {
        return try await fetchMovies(for: .nowPlaying)
    }

    // Fetch Popular Movies
    func fetchPopularMovies() async throws -> [Movie] {
        return try await fetchMovies(for: .popular)
    }

    // Fetch Upcoming Movies
    func fetchUpcomingMovies() async throws -> [Movie] {
        return try await fetchMovies(for: .upcoming)
    }
}
