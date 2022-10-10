//
//  TestMovieListVC.swift
//  MovieAssessmentTests
//
//  Created by Sushil K Mishra on 10/10/22.
//

import XCTest

final class TestMovieListVC: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func getMockMovieList() throws -> [MovieModel] {
        guard let path = Bundle(for: TestMovieListVC.self).url(forResource: "MovieList", withExtension: "json")
        else { fatalError("Can't find MovieList.json file") }
        let data = try Data(contentsOf: path)
        let mockMovieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return mockMovieResponse.results
    }
    
    func getMockFavMovieList() throws -> [FavoriteModel] {
        guard let favoritePath = Bundle(for: TestMovieListVC.self).url(forResource: "FavoriteMovie", withExtension: "json")
        else { fatalError("Can't find MovieList.json file") }
        let favoriteData = try Data(contentsOf: favoritePath)
        let mockFavoriteMovieResponse = try JSONDecoder().decode(FavoriteMovieResponse.self, from: favoriteData)
        return mockFavoriteMovieResponse.results
    }
    
    func testNextButtonFunction() throws {
        // Wrap ViewController into a Spy version of Navigation Controller
        let dataExpectation = expectation(description: "Navigation work")
        let vc = MovieListVC()
        let mockMovieResponse = try self.getMockMovieList()
        vc.navigateUserToDetail(movieData: mockMovieResponse[0])
        dataExpectation.fulfill()
        waitForExpectations(timeout: 2){ error in
            XCTAssertNotNil(dataExpectation)
        }
    }
    
    func testReloadData() throws {
        // Wrap ViewController into a Spy version of Navigation Controller
        let dataExpectation = expectation(description: "Reload data")
        let viewModel = MovieListViewModel()
        let mockMovieResponse = try self.getMockMovieList()
        let mockFavoriteMovieResponse = try self.getMockFavMovieList()
        let favoriteList =  viewModel.filterFavMovies(list: mockMovieResponse, idsArr: mockFavoriteMovieResponse)
        let (watched, towatch) = viewModel.filterMovies(list: mockMovieResponse)
        viewModel.selectedMovie = favoriteList[0]
        viewModel.watchedList = watched
        viewModel.toWatchList = towatch
        viewModel.favoriteMovieList = favoriteList
        let vc = MovieListVC()
        vc.reloadTableData(collectionIndex: [IndexPath(item: 0, section: 0)], tableIndexPath: [IndexPath(row: 0, section: 0)])
        dataExpectation.fulfill()
        waitForExpectations(timeout: 2){ error in
            XCTAssertNotNil(dataExpectation)
        }
    }
    
    
    func testSelectedMovieForCell() throws {
        let dataExpectation1 = expectation(description: "Data Exist for first index")
        let dataExpectation2 = expectation(description: "Data Exist for another index")
        let viewModel = MovieListViewModel()
        let mockMovieResponse = try self.getMockMovieList()
        let mockFavoriteMovieResponse = try self.getMockFavMovieList()
        let favoriteList =  viewModel.filterFavMovies(list: mockMovieResponse, idsArr: mockFavoriteMovieResponse)
        let (watched, _) = viewModel.filterMovies(list: mockMovieResponse)
        let indexPath1 = IndexPath(row: 0, section: 0)
        let indexPath2 = IndexPath(row: 6, section: 0)
        viewModel.lastSelectedMovie = mockMovieResponse[0]
        viewModel.selectedMovie = favoriteList[2]
        if viewModel.lastSelectedMovie != nil {
            if viewModel.lastSelectedMovie?.isWatched == true {
                if viewModel.lastSelectedMovie?.id == watched[indexPath1.row].id {
                    dataExpectation1.fulfill()
                }
            }
        }
        if viewModel.selectedMovie != nil {
            if viewModel.selectedMovie?.isWatched == true {
                if viewModel.selectedMovie?.id == watched[indexPath2.row].id {
                    dataExpectation2.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 2){ error in
            XCTAssertNotNil(dataExpectation1)
            XCTAssertNotNil(dataExpectation2)

        }
    }
    
}
