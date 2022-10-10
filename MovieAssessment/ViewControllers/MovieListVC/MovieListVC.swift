//
//  MovieListVC.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import UIKit

class MovieListVC: ViewController<MovieListViewModel> {
    
    // MARK: UIComponent
    
    private let verticalUIView: UIView = {
        let verticalUIView = UIView()
        verticalUIView.translatesAutoresizingMaskIntoConstraints = false
        return verticalUIView
    }()
    
    private let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 20
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackView
    }()
    
    let nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.layer.cornerRadius = 8
        nextButton.layer.borderWidth = 2
        nextButton.layer.borderColor = UIColor.black.cgColor
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        return nextButton
    }()
    
    private let favoriteLabel: UILabel = {
        let favoriteLabel = UILabel()
        favoriteLabel.text = "Favorites"
        favoriteLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.semibold)
        favoriteLabel.textColor = .gray
        favoriteLabel.translatesAutoresizingMaskIntoConstraints = false
        return favoriteLabel
    }()
    
    private let favoriteCollection: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let favoriteCollection = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        favoriteCollection.translatesAutoresizingMaskIntoConstraints = false
        return favoriteCollection
    }()
    
    private let movieTable: UITableView = {
        let movieTable = UITableView()
        movieTable.separatorColor = .clear
        movieTable.translatesAutoresizingMaskIntoConstraints = false
        return movieTable
    }()
    
    // MARK: Life cycle method

    func addViewsAndConstraint(){
        verticalStackView.addSubview(favoriteLabel)
        verticalStackView.addSubview(favoriteCollection)
        verticalStackView.addSubview(movieTable)
        NSLayoutConstraint.activate([
            favoriteLabel.topAnchor.constraint(equalTo: verticalStackView.topAnchor, constant: 0.0),
            favoriteLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 0.0),
            favoriteLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: 0.0),
            favoriteLabel.heightAnchor.constraint(equalToConstant:30),
            
            favoriteCollection.topAnchor.constraint(equalTo: favoriteLabel.bottomAnchor, constant: 0.0),
            favoriteCollection.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 0.0),
            favoriteCollection.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: 0.0),
            favoriteCollection.heightAnchor.constraint(equalToConstant: 150),
            
            movieTable.topAnchor.constraint(equalTo: favoriteCollection.bottomAnchor, constant: 10.0),
            movieTable.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 0.0),
            movieTable.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: 0.0),
            movieTable.bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 0.0),
        ])
        
        verticalUIView.addSubview(verticalStackView)
        verticalUIView.addSubview(nextButton)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: verticalUIView.topAnchor, constant: 15.0),
            verticalStackView.leadingAnchor.constraint(equalTo: verticalUIView.leadingAnchor, constant: 15.0),
            verticalStackView.trailingAnchor.constraint(equalTo: verticalUIView.trailingAnchor, constant: -15.0),
            verticalStackView.bottomAnchor.constraint(equalTo: verticalUIView.bottomAnchor, constant: -88.0),
            
            nextButton.centerXAnchor.constraint(equalTo: verticalUIView.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200.0),
            nextButton.heightAnchor.constraint(equalToConstant: 44.0),
            nextButton.bottomAnchor.constraint(equalTo: verticalUIView.bottomAnchor, constant: -28.0)
        ])
        view.addSubview(verticalUIView)
        
        let g = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            verticalUIView.topAnchor.constraint(equalTo: g.topAnchor, constant: 0.0),
            verticalUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            verticalUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            verticalUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movies App"
        
        favoriteCollection.register(FavoritesCell.self, forCellWithReuseIdentifier: String(describing: FavoritesCell.self))
        favoriteCollection.dataSource = self
        favoriteCollection.delegate = self
        
        movieTable.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
        movieTable.dataSource = self
        movieTable.delegate = self
        addViewsAndConstraint()
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        // Do any additional setup after loading the view.
        actionAfterLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchMovieList()
    }
    func actionAfterLoad(){
        self.viewModel = MovieListViewModel()
        self.viewModel.delegate = self
        self.viewModel.movieDelegate = self
    }
    @objc func nextAction(){
        if let movieData = self.viewModel.selectedMovie {
            self.navigateUserToDetail(movieData: movieData)
        }
    }
    func navigateUserToDetail(movieData: MovieModel) {
        let viewModel = DetailViewModel()
        viewModel.movieData = movieData
        let detailScreen = DetailVC(viewModel: viewModel)
        self.navigationController?.pushViewController(detailScreen, animated: true)
    }
}
// MARK: table view datasource and delegate
extension MovieListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Watched"
        } else {
            return "To Watch"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.viewModel.watchedList.count
        } else {
            return self.viewModel.toWatchList.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as! MovieCell
        cell.configureCellData(viewModel: self.viewModel, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.actionOnTableSelection(indexPath: indexPath)
    }
}

// MARK: Collection view datasource and delegate

extension MovieListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.favoriteMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavoritesCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavoritesCell.self), for: indexPath) as! FavoritesCell
        cell.configureCellData(viewModel: self.viewModel, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.actionOnFavSelection(movieData: viewModel.favoriteMovieList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 120)
    }
}

extension MovieListVC: MovieListDelegate{
    func updateTableData() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.movieTable.reloadData()
        }
    }
    func updateCollectionData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.favoriteCollection.reloadData()
        }
    }
    func updateSelectedItem(collectionIndex: [IndexPath], tableIndexPath: [IndexPath]) {
       reloadTableData(collectionIndex: collectionIndex, tableIndexPath: tableIndexPath, selected: self.viewModel.selectedMovie)
    }
    
    func reloadTableData(collectionIndex: [IndexPath], tableIndexPath: [IndexPath], selected: MovieModel? = nil) {
        if collectionIndex.count > 0 {
            favoriteCollection.reloadItems(at: collectionIndex)
        }
        if tableIndexPath.count > 0 {
            movieTable.reloadRows(at: tableIndexPath, with: .fade)
        }
        if selected != nil {
            self.nextButton.backgroundColor = UIColor(red: 53.0/255, green: 123.0/255, blue: 181.0/255, alpha: 1.0)
            self.nextButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
}
