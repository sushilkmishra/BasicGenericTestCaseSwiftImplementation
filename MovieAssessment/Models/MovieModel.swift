//
//  MovieModel.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import Foundation
struct MovieResponse: Codable {
    let results: [MovieModel]
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct MovieModel: Codable {
    let backdrop_path: String
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let release_date: String
    let title: String
    let rating: Float
    let isWatched: Bool
    
    enum CodingKeys: String, CodingKey {
        case backdrop_path
        case id
        case original_language
        case original_title
        case overview
        case popularity
        case poster_path
        case release_date
        case title
        case rating
        case isWatched
    }
}
