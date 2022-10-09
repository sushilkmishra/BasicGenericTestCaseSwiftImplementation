//
//  APIConstant.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import Foundation

//MARK:- HTTP Methods
enum ApiHTTPMethod: String {
    case GET  = "GET"
}

struct APIEndPoints {
    struct Movie {
        static let List = "movies/list";
        static let Favorite = "movies/favorites"
    }
}
