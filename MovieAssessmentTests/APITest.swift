//
//  APITest.swift
//  MovieAssessmentTests
//
//  Created by Sushil K Mishra on 08/10/22.
//

import XCTest

class MockURLSession: URLSession {
  var cachedUrl: URL?
  override func dataTask(with url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    self.cachedUrl = url
      return URLSessionDataTask()
  }
}

final class APITest: XCTestCase {

//    func testGetMoviesWithExpectedURLHostAndPath() {
//      let service = MovieListService()
//        let mockURLSession = MockURLSession()
//        service.session = mockURLSession
//        service.getMovieList{(result: Result<[MovieModel], Error>) in }
//        XCTAssertEqual(mockURLSession.cachedUrl?.host, "61efc467732d93001778e5ac.mockapi.io")
//         XCTAssertEqual(mockURLSession.cachedUrl?.path, "/movies/list")
//    }
    
    
    func testGetMoviesSuccess() {
      let service = MovieListService()
        var movieResponse: [MovieModel]?
        let movieExpectation = expectation(description: "movies")
        service.getMovieList{(result: Result<[MovieModel], Error>) in
            switch result {
            case .success(let response):
                movieResponse = response
                movieExpectation.fulfill()
            case .failure(_):
                print("error")
            }
        }
        waitForExpectations(timeout: 2){ error in
            XCTAssertNotNil(movieResponse)
        }
    }
    
    
    func testGetFavoriteMoviesSuccess() {
      let service = FavoriteMovieListService()
        var movieResponse: [FavoriteModel]?
        let movieExpectation = expectation(description: "movies")
        service.getFavoriteMovieList{(result: Result<[FavoriteModel], Error>) in
            switch result {
            case .success(let response):
                movieResponse = response
                movieExpectation.fulfill()
            case .failure(_):
                print("error")
            }
        }
        waitForExpectations(timeout: 2){ error in
            XCTAssertNotNil(movieResponse)
        }
    }
    
    
    func testGetMoviesFailure() {
      let service = MovieListService()
        var errorResponse: Error?
        let errorExpectation = expectation(description: "error")
        service.getMovieList{(result: Result<[MovieModel], Error>) in
            switch result {
            case .success(_):
                print("success")
            case .failure(let error):
                print("error")
                errorResponse = error
                errorExpectation.fulfill()
            }
        }
    }
}
