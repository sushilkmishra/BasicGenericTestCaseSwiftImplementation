//
//  MovieListService.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import Foundation
class MovieListService {
    
    var session: URLSession!
    
    var path: String = APIEndPoints.Movie.List
    
    func getMovieList(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        APIClient.shared.httpRequest(path: path, method: .GET) { (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let response):
                let movieArray = response.results
                completion(.success(movieArray))
            case .failure(let error):
                print("error")
                completion(.failure(error))
            }
        }
    }
}
