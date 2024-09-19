//
//  MockMovieRepository.swift
//  BankNasrMovieAppTests
//
//  Created by Eslam ALi on 19/09/2024.
//

import Foundation
import XCTest
@testable import BankMasrTask


class MockMovieRepository: MovieRepository {
    var nowPlayingMoviesResult: Result<[Movie], Error> = .success([])
    var popularMoviesResult: Result<[Movie], Error> = .success([])
    var upcomingMoviesResult: Result<[Movie], Error> = .success([])
    var movieDetailsResult: Result<Movie, Error> = .success(Movie(id: 0, title: "Mock Movie", releaseDate: "2024-01-01", posterPath: nil, overview: "Overview", runtime: 120, genres: nil))
    
    func fetchNowPlayingMovies() async throws -> [Movie] {
        return try nowPlayingMoviesResult.get()
    }

    func fetchPopularMovies() async throws -> [Movie] {
        return try popularMoviesResult.get()
    }

    func fetchUpcomingMovies() async throws -> [Movie] {
        return try upcomingMoviesResult.get()
    }

    func fetchMovieDetails(for movieID: Int) async throws -> Movie {
        return try movieDetailsResult.get()
    }
}
