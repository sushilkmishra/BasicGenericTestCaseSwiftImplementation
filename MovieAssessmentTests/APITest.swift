//
//  APITest.swift
//  MovieAssessmentTests
//
//  Created by Sushil K Mishra on 08/10/22.
//

import XCTest

final class APITest: XCTestCase {
        
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
    
    //for failure test if changing URL for path
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
        waitForExpectations(timeout: 2){ error in
            XCTAssertNotNil(errorExpectation)
        }
    }
}
