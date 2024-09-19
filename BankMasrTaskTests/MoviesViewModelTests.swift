//
//  MoviesViewModelTests.swift
//  BankNasrMovieAppTests
//
//  Created by Eslam ALi on 19/09/2024.
//

import XCTest
@testable import BankMasrTask


final class MoviesViewModelTests: XCTestCase {
    var viewModel: MoviesViewModel!
    var mockRepository: MockMovieRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        viewModel = MoviesViewModel(movieRepository: mockRepository)  // Inject the mock repository
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    // Test error case for fetching now playing movies
    func testFetchNowPlayingMoviesFailure() async throws {
        // Given
        mockRepository.nowPlayingMoviesResult = .failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Network Error"]))

        // Create an expectation
        let expectation = XCTestExpectation(description: "Fetch now playing movies failure")

        // When
        Task {
            await viewModel.fetchNowPlayingMovies()
            expectation.fulfill()
        }

        // Await fulfillment
        await fulfillment(of: [expectation], timeout: 2.0)

        // Then
        XCTAssertTrue(viewModel.nowPlayingMovies.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Network Error")
    }

    // Test success case for fetching popular movies
    func testFetchPopularMoviesSuccess() async throws {
        // Given
        let mockMovies = [
            Movie(id: 1, title: "Movie 1", releaseDate: "2024-01-01", posterPath: nil, overview: "Overview 1", runtime: 120, genres: nil)
        ]
        mockRepository.popularMoviesResult = .success(mockMovies)

        // Create an expectation
        let expectation = XCTestExpectation(description: "Fetch popular movies success")

        // When
        Task {
            await viewModel.fetchPopularMovies()
            expectation.fulfill()
        }

        // Await fulfillment
        await fulfillment(of: [expectation], timeout: 2.0)

        // Then
        XCTAssertEqual(viewModel.popularMovies.count, 1)
        XCTAssertEqual(viewModel.popularMovies[0].title, "Movie 1")
        XCTAssertNil(viewModel.errorMessage)
    }

    // Test error case for fetching popular movies
    func testFetchPopularMoviesFailure() async throws {
        // Given
        mockRepository.popularMoviesResult = .failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch popular movies"]))

        // Create an expectation
        let expectation = XCTestExpectation(description: "Fetch popular movies failure")

        // When
        Task {
            await viewModel.fetchPopularMovies()
            expectation.fulfill()
        }

        // Await fulfillment
        await fulfillment(of: [expectation], timeout: 2.0)

        // Then
        XCTAssertTrue(viewModel.popularMovies.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Failed to fetch popular movies")
    }

    // Test success case for fetching upcoming movies
    func testFetchUpcomingMoviesSuccess() async throws {
        // Given
        let mockMovies = [
            Movie(id: 1, title: "Upcoming Movie", releaseDate: "2024-03-01", posterPath: nil, overview: "Upcoming Overview", runtime: 120, genres: nil)
        ]
        mockRepository.upcomingMoviesResult = .success(mockMovies)

        // Create an expectation
        let expectation = XCTestExpectation(description: "Fetch upcoming movies success")

        // When
        Task {
            await viewModel.fetchUpcomingMovies()
            expectation.fulfill()
        }

        // Await fulfillment
        await fulfillment(of: [expectation], timeout: 2.0)

        // Then
        XCTAssertEqual(viewModel.upcomingMovies.count, 1)
        XCTAssertEqual(viewModel.upcomingMovies[0].title, "Upcoming Movie")
        XCTAssertNil(viewModel.errorMessage)
    }

    // Test error case for fetching upcoming movies
    func testFetchUpcomingMoviesFailure() async throws {
        // Given
        mockRepository.upcomingMoviesResult = .failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch upcoming movies"]))

        // Create an expectation
        let expectation = XCTestExpectation(description: "Fetch upcoming movies failure")

        // When
        Task {
            await viewModel.fetchUpcomingMovies()
            expectation.fulfill()
        }

        // Await fulfillment
        await fulfillment(of: [expectation], timeout: 2.0)

        // Then
        XCTAssertTrue(viewModel.upcomingMovies.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Failed to fetch upcoming movies")
    }

    // Test success case for fetching movie details
    func testFetchMovieDetailsSuccess() async throws {
        // Given
        let mockMovie = Movie(id: 1, title: "Movie 1", releaseDate: "2024-01-01", posterPath: nil, overview: "Overview 1", runtime: 120, genres: nil)
        mockRepository.movieDetailsResult = .success(mockMovie)

        // Create an expectation
        let expectation = XCTestExpectation(description: "Fetch movie details success")

        // When
        Task {
            await viewModel.fetchMovieDetails(for: 1)
            expectation.fulfill()
        }

        // Await fulfillment
        await fulfillment(of: [expectation], timeout: 2.0)

        // Then
        XCTAssertEqual(viewModel.movieDetails?.title, "Movie 1")
        XCTAssertNil(viewModel.errorMessage)
    }

    // Test error case for fetching movie details
    func testFetchMovieDetailsFailure() async throws {
        // Given
        mockRepository.movieDetailsResult = .failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch details"]))

        // Create an expectation
        let expectation = XCTestExpectation(description: "Fetch movie details failure")

        // When
        Task {
            await viewModel.fetchMovieDetails(for: 1)
            expectation.fulfill()
        }

        // Await fulfillment
        await fulfillment(of: [expectation], timeout: 2.0)

        // Then
        XCTAssertNil(viewModel.movieDetails)
        XCTAssertEqual(viewModel.errorMessage, "Failed to fetch details")
    }
}
