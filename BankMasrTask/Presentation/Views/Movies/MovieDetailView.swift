//
//  MovieDetailView.swift
//  BankNasrMovieApp
//
//  Created by Eslam ALi on 19/09/2024.
//

import SwiftUI


struct MovieDetailView: View {
    let movie: Movie
    @ObservedObject var viewModel: MoviesViewModel  // Use the shared view model

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Display the movie poster
                if let posterPath = movie.posterPath {
                    AsyncImage(
                        url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"),
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }

                if let movieDetails = viewModel.movieDetails {
                    // Movie Title
                    Text(movieDetails.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // Display Overview
                    if let overview = movieDetails.overview ?? movie.overview {
                        Text("Overview")
                            .font(.title2)
                            .padding(.top)
                        Text(overview)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                    }

                    // Display Genres
                    if let genres = movieDetails.genres ?? movie.genres {
                        Text("Genres")
                            .font(.title2)
                            .padding(.top)
                        Text(genres.map { $0.name }.joined(separator: ", "))
                            .font(.body)
                    }

                    // Display Runtime
                    if let runtime = movieDetails.runtime ?? movie.runtime {
                        Text("Runtime")
                            .font(.title2)
                            .padding(.top)
                        Text("\(runtime) minutes")
                            .font(.body)
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    // Show error message if fetching details fails
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.headline)
                } else {
                    // Show loading indicator while fetching details
                    ProgressView("Loading details...")
                }
            }
            .padding()
            .navigationTitle(movie.title)
            .onAppear {
                Task{
                  await  viewModel.fetchMovieDetails(for: movie.id)  // Fetch details when the view appears
                }
            }
        }
    }
}
