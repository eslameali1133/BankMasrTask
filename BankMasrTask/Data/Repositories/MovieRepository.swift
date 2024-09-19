//
//  MovieRepository.swift
//  BankNasrMovieApp
//
//  Created by Eslam ALi on 18/09/2024.
//
import Foundation
protocol MovieRepository {
    func fetchNowPlayingMovies() async throws -> [Movie]
    func fetchPopularMovies() async throws -> [Movie]
    func fetchUpcomingMovies() async throws -> [Movie]
    func fetchMovieDetails(for movieID: Int) async throws -> Movie
}


class MovieRepositoryImpl: MovieRepository {
    private var api = TMDbAPI()
  

   

    // Fetch Now Playing Movies
    func fetchNowPlayingMovies() async throws -> [Movie] {
        let movies = try await api.fetchNowPlayingMovies()
      
        return movies
    }

    // Fetch Popular Movies
    func fetchPopularMovies() async throws -> [Movie] {
        let movies = try await api.fetchPopularMovies()
      
        return movies
    }

    // Fetch Upcoming Movies
    func fetchUpcomingMovies() async throws -> [Movie] {
        let movies = try await api.fetchUpcomingMovies()
  
        return movies
    }

    // Fetch Detailed Movie Information
    func fetchMovieDetails(for movieID: Int) async throws -> Movie {
        // Try fetching from the cache first


        // If not cached, fetch from the API
        let movieDetails = try await api.fetchMovieDetails(for: movieID)

        // Save the fetched movie details to cache


        return movieDetails
    }
}
