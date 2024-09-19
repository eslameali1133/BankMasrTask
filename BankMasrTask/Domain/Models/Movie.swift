//
//  Movie.swift
//  BankNasrMovieApp
//
//  Created by Eslam ALi on 17/09/2024.
//

import Foundation


struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String?

    // Optional fields for movie details
    let overview: String?
    let runtime: Int?
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case overview
        case runtime
        case genres
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

