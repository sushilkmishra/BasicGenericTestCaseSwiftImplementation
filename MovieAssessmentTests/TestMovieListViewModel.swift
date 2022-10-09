//
//  TestMovieListViewModel.swift
//  MovieAssessmentTests
//
//  Created by Sushil K Mishra on 09/10/22.
//

import XCTest

final class TestMovieListViewModel: XCTestCase {

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
        guard let path = Bundle(for: TestMovieListViewModel.self).url(forResource: "MovieList", withExtension: "json")
        else { fatalError("Can't find MovieList.json file") }
        let data = try Data(contentsOf: path)
        let mockMovieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return mockMovieResponse.results
    }
    
    func getMockFavMovieList() throws -> [FavoriteModel] {
        guard let favoritePath = Bundle(for: TestMovieListViewModel.self).url(forResource: "FavoriteMovie", withExtension: "json")
        else { fatalError("Can't find MovieList.json file") }
        let favoriteData = try Data(contentsOf: favoritePath)
        let mockFavoriteMovieResponse = try JSONDecoder().decode(FavoriteMovieResponse.self, from: favoriteData)
        return mockFavoriteMovieResponse.results
    }
    
    func testFilterFavMovies() throws {
        let viewModel = MovieListViewModel()
        let mockMovieResponse = try self.getMockMovieList()
        let mockFavoriteMovieResponse = try self.getMockFavMovieList()
        let favoriteList =  viewModel.filterFavMovies(list: mockMovieResponse, idsArr: mockFavoriteMovieResponse)
        XCTAssertEqual(favoriteList.count, mockFavoriteMovieResponse.count)
    }
    
    func testFiterForWatchAndToWatch() throws {
        let viewModel = MovieListViewModel()
        let mockMovieResponse = try self.getMockMovieList()
        let (watched, toWatch) = viewModel.filterMovies(list: mockMovieResponse)
        XCTAssertEqual(watched.count, 10)
        XCTAssertEqual(toWatch.count, 10)
    }
    
    func testForUpdateIndexForSecondTime() throws {
        // test for update index for second time where last selected in fav but new selected not in fav list
        let viewModel = MovieListViewModel()
        let mockMovieResponse = try self.getMockMovieList()
        let mockFavoriteMovieResponse = try self.getMockFavMovieList()
        let favoriteList =  viewModel.filterFavMovies(list: mockMovieResponse, idsArr: mockFavoriteMovieResponse)
        let (watched, toWatch) = viewModel.filterMovies(list: mockMovieResponse)
        let selected = favoriteList[0]
        let current = mockMovieResponse[1]
        let (collectionIndexpath, tableIndexpath) = viewModel.checkIndexForUpdate(favList: favoriteList, watched: watched, toWatch: toWatch, lastSelected: selected, currentSelected: current)
        XCTAssertEqual(tableIndexpath.count, 2)
        XCTAssertEqual(collectionIndexpath.count, 1)
    }
    
    func testForUpdateIndexFirstTime() throws {
        // test for update index for Fisrt time where selcted in both list
        let viewModel = MovieListViewModel()
        let mockMovieResponse = try self.getMockMovieList()
        let mockFavoriteMovieResponse = try self.getMockFavMovieList()
        let favoriteList =  viewModel.filterFavMovies(list: mockMovieResponse, idsArr: mockFavoriteMovieResponse)
        let (watched, toWatch) = viewModel.filterMovies(list: mockMovieResponse)
        let current = mockMovieResponse[0]
        let (collectionIndexpath, tableIndexpath) = viewModel.checkIndexForUpdate(favList: favoriteList, watched: watched, toWatch: toWatch, lastSelected: nil, currentSelected: current)
        XCTAssertEqual(tableIndexpath.count, 1)
        XCTAssertEqual(collectionIndexpath.count, 1)
        
    }
    
    func testForUpdateIndexSecondTimeWithFavChange() throws {
        // test for update index for Second time where selcted and last from fav list
        let viewModel = MovieListViewModel()
        let mockMovieResponse = try self.getMockMovieList()
        let mockFavoriteMovieResponse = try self.getMockFavMovieList()
        let favoriteList =  viewModel.filterFavMovies(list: mockMovieResponse, idsArr: mockFavoriteMovieResponse)
        let (watched, toWatch) = viewModel.filterMovies(list: mockMovieResponse)
        let selected = favoriteList[0]
        let current = favoriteList[1]
        let (collectionIndexpath, tableIndexpath) = viewModel.checkIndexForUpdate(favList: favoriteList, watched: watched, toWatch: toWatch, lastSelected: selected, currentSelected: current)
        XCTAssertEqual(tableIndexpath.count, 2)
        XCTAssertEqual(collectionIndexpath.count, 2)
        
    }
    
    func testForUpdateIndexSecondTimeNotInFav() throws {
        // test for update index for Second time where selcted and last is not available in fav list
        let viewModel = MovieListViewModel()
        let mockMovieResponse = try self.getMockMovieList()
        let mockFavoriteMovieResponse = try self.getMockFavMovieList()
        let favoriteList =  viewModel.filterFavMovies(list: mockMovieResponse, idsArr: mockFavoriteMovieResponse)
        let (watched, toWatch) = viewModel.filterMovies(list: mockMovieResponse)
        let selected = mockMovieResponse[1]
        let current = mockMovieResponse[2]
        let (collectionIndexpath, tableIndexpath) = viewModel.checkIndexForUpdate(favList: favoriteList, watched: watched, toWatch: toWatch, lastSelected: selected, currentSelected: current)
        XCTAssertEqual(tableIndexpath.count, 2)
        XCTAssertEqual(collectionIndexpath.count, 0)
        
    }

}
