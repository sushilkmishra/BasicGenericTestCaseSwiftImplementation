//
//  APIClient.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 09/10/22.
//

import Foundation
class APIClient {
    
    static let shared = APIClient();
    private init () {}
    
    let baseEndPointURL = AppConfig.shared.getAPIBaseURL();
    
    //MARK:- Complete EndPoint URL
    private func endPoint(path: String) -> String {
        return baseEndPointURL + path;
    }
    
    func httpRequest<T: Decodable>(for: T.Type = T.self, path: String, method: ApiHTTPMethod, headers: [String: String]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        //URL
        let url = endPoint(path: path);
        //Method
        let httpMethod = method.rawValue;
        //Headers
        guard Reachability.isConnectedToNetwork(), let url = URL(string: url) else {
            completion(.failure(CustomError.noConnection))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(#function, "🧨 Request: \(request)\nError: \(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(CustomError.noData))
                return
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch let error {
                print(#function, "🧨 Request: \(request)\nError: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
