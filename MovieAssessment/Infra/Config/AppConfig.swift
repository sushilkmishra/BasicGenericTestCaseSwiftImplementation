//
//  AppConfig.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import Foundation
public class AppConfig {
    static let shared = AppConfig();
    private init() {}
    //MARK:-
    func getAPIBaseURL () -> String {
        return "https://61efc467732d93001778e5ac.mockapi.io/";
    }
    
    func imageUrl (imgName: String) -> String {
        return "https://image.tmdb.org/t/p/w500\(imgName)"
    }
}

