//
//  FavoriteMovieListService.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import Foundation
class FavoriteMovieListService {
    var path: String = APIEndPoints.Movie.Favorite

     func getFavoriteMovieList(completion: @escaping (Result<[FavoriteModel], Error>) -> Void) {
         APIClient.shared.httpRequest(path: path, method: .GET) { (result: Result<FavoriteMovieResponse, Error>) in
             switch result {
             case .success(let response):
                 let favoriteArray = response.results
                 completion(.success(favoriteArray))
             case .failure(let error):
                 completion(.failure(error))
             }
         }
    }
}
