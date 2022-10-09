//
//  FavoriteMovieModel.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import Foundation
import Foundation
struct FavoriteMovieResponse: Codable {
    let results: [FavoriteModel]
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct FavoriteModel: Codable {
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}
