//
//  MoviesListView.swift
//  BankNasrMovieApp
//
//  Created by Eslam ALi on 19/09/2024.
//

import Foundation

class MoviesViewModel: ObservableObject {
    @Published var nowPlayingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var movieDetails: Movie?
    @Published var errorMessage: String?

    private let movieRepository: MovieRepository

    // Inject MovieRepository via initializer
    init(movieRepository: MovieRepository = MovieRepositoryImpl()) {
        self.movieRepository = movieRepository
    }

    func fetchNowPlayingMovies() async {
        do {
            let movies = try await movieRepository.fetchNowPlayingMovies()
            DispatchQueue.main.async {
                self.nowPlayingMovies = movies
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.dismissErrorAfterDelay()
            }
        }
    }

    func fetchPopularMovies() async {
        do {
            let movies = try await movieRepository.fetchPopularMovies()
            DispatchQueue.main.async {
                self.popularMovies = movies
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.dismissErrorAfterDelay()
            }
        }
    }

    func fetchUpcomingMovies() async {
        do {
            let movies = try await movieRepository.fetchUpcomingMovies()
            DispatchQueue.main.async {
                self.upcomingMovies = movies
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.dismissErrorAfterDelay()
            }
        }
    }

    func fetchMovieDetails(for movieID: Int) async {
        do {
            let details = try await movieRepository.fetchMovieDetails(for: movieID)
            DispatchQueue.main.async {
                self.movieDetails = details
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.dismissErrorAfterDelay()
            }
        }
    }

    private func dismissErrorAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.errorMessage = nil
        }
    }
}
