//
//  MovieListViewModel.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import Foundation

protocol MovieListDelegate: AnyObject {
    func updateTableData()
    func updateCollectionData()
    func updateSelectedItem(collectionIndex: [IndexPath], tableIndexPath: [IndexPath])
}


class MovieListViewModel: ViewModel {
    weak var movieDelegate: MovieListDelegate?
    
    private var movieList: [MovieModel] = []
    var watchedList: [MovieModel] = []
    var toWatchList: [MovieModel] = []
    var favoriteMovieList: [MovieModel] = []
    var selectedMovie: MovieModel? = nil
    var lastSelectedMovie: MovieModel? = nil
    
    func fetchMovieList() {
        self.state = .loading
        MovieListService().getMovieList {[weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                print("movies", movies)
                self.separatedList(list: movies)
                self.state = .success
                self.fetchFavoriteMovieList()
            case let .failure(error):
                self.state = .error(error)
                print("Error", error.localizedDescription)
            }
        }
    }
    
    func fetchFavoriteMovieList() {
        self.state = .loading
        FavoriteMovieListService().getFavoriteMovieList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(idsArr):
                print("movies", idsArr)
                self.updateFavList(list: self.movieList, favIds: idsArr)
                self.state = .success
            case let .failure(error):
                self.state = .error(error)
                print("Error", error.localizedDescription)
            }
        }
    }
    
    func updateSelectedIndex() {
        let (collectionIndexPaths, tableIndexPaths) = self.checkIndexForUpdate(favList: self.favoriteMovieList, watched: self.watchedList, toWatch: self.toWatchList, lastSelected: self.lastSelectedMovie, currentSelected: self.selectedMovie)
        self.movieDelegate?.updateSelectedItem(collectionIndex: collectionIndexPaths, tableIndexPath: tableIndexPaths)
    }
    
    func separatedList(list: [MovieModel]) {
        self.movieList = list
        let (watched, toWatch) = self.filterMovies(list: list)
        self.watchedList = watched
        self.toWatchList = toWatch
        self.movieDelegate?.updateTableData()
    }
    
    func updateFavList(list: [MovieModel], favIds:[FavoriteModel]) {
        self.favoriteMovieList = self.filterFavMovies(list: list, idsArr: favIds)
        self.movieDelegate?.updateCollectionData()
    }
}
// MARK: - update data after fav or other selection
extension MovieListViewModel {
    
    func actionOnFavSelection(movieData: MovieModel){
        if self.selectedMovie != nil {
            self.lastSelectedMovie = self.selectedMovie
        }
        self.selectedMovie = movieData
        self.updateSelectedIndex()
    }
    
    func actionOnTableSelection(indexPath: IndexPath){
        if indexPath.section == 0 {
            if self.selectedMovie != nil {
                self.lastSelectedMovie = self.selectedMovie
            }
            self.selectedMovie = self.watchedList[indexPath.row]
        } else {
            if self.selectedMovie != nil {
                self.lastSelectedMovie = self.selectedMovie
            }
            self.selectedMovie = self.toWatchList[indexPath.row]
        }
        self.updateSelectedIndex()
    }
    
}
// MARK: - Filter Data
extension MovieListViewModel {
    func filterMovies(list : [MovieModel]) -> ([MovieModel], [MovieModel]) {
        let watchedListArr = list.filter { $0.isWatched == true }.sorted(by: { leftItem, rightItem in
            if leftItem.rating == rightItem.rating {
                return leftItem.title < rightItem.title
            }
            return leftItem.rating > rightItem.rating
        })
        let toWatchListArr = list.filter { $0.isWatched == false }.sorted(by: { leftItem, rightItem in
            if leftItem.rating == rightItem.rating {
                return leftItem.title < rightItem.title
            }
            return leftItem.rating > rightItem.rating
        })
        
        return (watchedListArr, toWatchListArr)
    }
    
    func filterFavMovies(list : [MovieModel], idsArr: [FavoriteModel]) -> [MovieModel] {
        let arr = list.filter { movie in
            idsArr.contains(where: { $0.id == movie.id }
            )}
        return arr
    }
    
    func checkIndexForUpdate(favList: [MovieModel], watched: [MovieModel], toWatch: [MovieModel], lastSelected: MovieModel? = nil, currentSelected: MovieModel? = nil) -> ([IndexPath], [IndexPath]) {
        var lastSelectedFvrtIndex = -1
        var currentSelectedFvrtIndex = -1
        if lastSelected != nil {
            if let index = favList.firstIndex(where: {$0.id == lastSelected?.id}) {
                lastSelectedFvrtIndex = index
            }
        }
        if let index = favList.firstIndex(where: {$0.id == currentSelected?.id}) {
            currentSelectedFvrtIndex = index
        }
        var arr = [IndexPath]()
        if lastSelectedFvrtIndex != -1 {
            let indexPath = IndexPath(item: lastSelectedFvrtIndex, section: 0)
            arr.append(indexPath)
        }
        if currentSelectedFvrtIndex != -1 {
            let indexPath = IndexPath(item: currentSelectedFvrtIndex, section: 0)
            arr.append(indexPath)
        }
        
        var lastSelectedTableIndex = -1
        var currentSelectedTableIndex = -1
        if lastSelected != nil {
            if lastSelected?.isWatched == true {
                if let index = watched.firstIndex(where: {$0.id == lastSelected?.id}) {
                    lastSelectedTableIndex = index
                }
            } else {
                if let index = toWatch.firstIndex(where: {$0.id == lastSelected?.id}) {
                    lastSelectedTableIndex = index
                }
            }
        }
        
        if currentSelected?.isWatched == true {
            if let index = watched.firstIndex(where: {$0.id == currentSelected?.id}) {
                currentSelectedTableIndex = index
            }
        } else {
            if let index = toWatch.firstIndex(where: {$0.id == currentSelected?.id}) {
                currentSelectedTableIndex = index
            }
        }
        
        var arrForTable = [IndexPath]()
        if lastSelectedTableIndex != -1 {
            var section = 0
            if lastSelected?.isWatched == false {
                section = 1
            }
            let indexPath = IndexPath(item: lastSelectedTableIndex, section: section)
            arrForTable.append(indexPath)
        }
        if currentSelectedTableIndex != -1 {
            var section = 0
            if currentSelected?.isWatched == false {
                section = 1
            }
            let indexPath = IndexPath(item: currentSelectedTableIndex, section: section)
            arrForTable.append(indexPath)
        }
        
        return (arr, arrForTable)
    }
    
}
