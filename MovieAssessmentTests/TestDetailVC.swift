//
//  TestDetailVC.swift
//  MovieAssessmentTests
//
//  Created by Sushil K Mishra on 10/10/22.
//

import XCTest

final class TestDetailVC: XCTestCase {

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
        guard let path = Bundle(for: TestDetailVC.self).url(forResource: "MovieList", withExtension: "json")
        else { fatalError("Can't find MovieList.json file") }
        let data = try Data(contentsOf: path)
        let mockMovieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return mockMovieResponse.results
    }
    
    
    func testUpdateUIData() throws {
        let mockMovieResponse = try self.getMockMovieList()
        let viewModel = DetailViewModel()
        viewModel.movieData = mockMovieResponse[0]
        let vc = DetailVC(viewModel: viewModel)
        if let movieData = viewModel.movieData {
            vc.updateUIData(movieData: movieData)
        }
        XCTAssertEqual(viewModel.movieData?.id, 1)
        XCTAssertEqual(viewModel.movieData?.rating, 8.0)

    }

}
