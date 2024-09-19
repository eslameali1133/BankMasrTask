//
//  MoviesTabView.swift
//  BankNasrMovieApp
//
//  Created by Eslam ALi on 19/09/2024.
//
import SwiftUI

struct MoviesTabView: View {
    @StateObject private var viewModel: MoviesViewModel

    init(viewModel: MoviesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            // Main content: TabView
            VStack {
                TabView {
                    MoviesListView(movies: viewModel.nowPlayingMovies, title: "Now Playing", errorMessage: viewModel.errorMessage, viewModel: viewModel)
                        .tabItem {
                            Label("Now Playing", systemImage: "film")
                        }
                        .onAppear {
                            Task{
                                await viewModel.fetchNowPlayingMovies()
                            }
                        }

                    MoviesListView(movies: viewModel.popularMovies, title: "Popular", errorMessage: viewModel.errorMessage, viewModel: viewModel)
                        .tabItem {
                            Label("Popular", systemImage: "star.fill")
                        }
                        .onAppear {
                            Task{
                                await  viewModel.fetchPopularMovies()
                            }
                        }

                    MoviesListView(movies: viewModel.upcomingMovies, title: "Upcoming", errorMessage: viewModel.errorMessage, viewModel: viewModel)
                        .tabItem {
                            Label("Upcoming", systemImage: "calendar")
                        }
                        .onAppear {
                            Task{
                                await viewModel.fetchUpcomingMovies()
                            }
                        }
                }
            }

            // Error banner at the top
            if let errorMessage = viewModel.errorMessage {
                VStack {
                    ErrorBannerView(errorMessage: errorMessage)
                    Spacer()
                }
                .transition(.move(edge: .top))  // Animate from the top
                .animation(.easeInOut, value: viewModel.errorMessage)
            }
        }
    }
}
