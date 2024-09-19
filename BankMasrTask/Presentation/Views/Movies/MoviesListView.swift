//
//  MoviesListView.swift
//  BankNasrMovieApp
//
//  Created by Eslam ALi on 19/09/2024.
//
import SwiftUI


struct MoviesListView: View {
    let movies: [Movie]
    let title: String
    let errorMessage: String?
    @ObservedObject var viewModel: MoviesViewModel  // Use the shared view model

    var body: some View {
        NavigationStack {
            List {
                if let errorMessage = errorMessage {
                    // Display error message if any
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .font(.headline)
                } else {
                    // Display the list of movies
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
                            HStack {
                                // Display the poster image in the list
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(movie.posterPath ?? "")")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 75)
                                } placeholder: {
                                    ProgressView()
                                }

                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                        .font(.headline)
                                    Text(movie.releaseDate)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(title)
        }
    }
}
