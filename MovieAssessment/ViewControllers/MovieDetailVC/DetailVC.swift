//
//  DetailVC.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import UIKit
import Kingfisher

class DetailVC: ViewController<DetailViewModel> {
    
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
    
    private let movieImage : UIImageView = {
        let movieImage = UIImageView()
        movieImage.contentMode = .scaleAspectFill
        movieImage.backgroundColor = .systemGray6
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.layer.cornerRadius = 50
        movieImage.clipsToBounds = true
        return movieImage
    }()
    
    private let descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 16.0)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private let ratingLabel : UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.textColor = .black
        ratingLabel.font = UIFont.systemFont(ofSize: 16.0)
        ratingLabel.textAlignment = .left
        ratingLabel.numberOfLines = 0
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingLabel
    }()
    
    private let dateLabel : UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .black
        dateLabel.font = UIFont.systemFont(ofSize: 16.0)
        dateLabel.textAlignment = .left
        dateLabel.numberOfLines = 0
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private let languageLabel : UILabel = {
        let languageLabel = UILabel()
        languageLabel.textColor = .black
        languageLabel.font = UIFont.systemFont(ofSize: 16.0)
        languageLabel.textAlignment = .left
        languageLabel.numberOfLines = 0
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        return languageLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movie Detail"
        addUIConstraint()
        if let movieData = self.viewModel.movieData {
            updateUIData(movieData: movieData)
        }
    }
    
    init(viewModel: DetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUIConstraint() {
        
        verticalStackView.addSubview(movieImage)
        verticalStackView.addSubview(descriptionLabel)
        verticalStackView.addSubview(ratingLabel)
        verticalStackView.addSubview(dateLabel)
        verticalStackView.addSubview(languageLabel)
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: verticalStackView.topAnchor, constant: 10.0),
            movieImage.heightAnchor.constraint(equalToConstant: 100.0),
            movieImage.widthAnchor.constraint(equalToConstant: 100.0),
            movieImage.centerXAnchor.constraint(equalTo: verticalStackView.centerXAnchor, constant: 0.0),
            
            descriptionLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 10.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 5.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: 5.0),
            
            ratingLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            ratingLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 5),
            ratingLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: 5),
            
            dateLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: 5),
            
            languageLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            languageLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 5),
            languageLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: 5),
        ])
        
        verticalUIView.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: verticalUIView.topAnchor, constant: 15.0),
            verticalStackView.leadingAnchor.constraint(equalTo: verticalUIView.leadingAnchor, constant: 15.0),
            verticalStackView.trailingAnchor.constraint(equalTo: verticalUIView.trailingAnchor, constant: -15.0),
            verticalStackView.bottomAnchor.constraint(equalTo: verticalUIView.bottomAnchor, constant: 0.0),
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
    
    func updateUIData(movieData: MovieModel) {
        descriptionLabel.text = movieData.overview
        ratingLabel.text = "Rating: \(movieData.rating)"
        dateLabel.text = "Release Date: \(movieData.release_date)"
        languageLabel.text = "Language: \(movieData.original_language)"
        
        let imgName = movieData.poster_path
        let imgUrl = AppConfig.shared.imageUrl(imgName: imgName)
        movieImage.kf.setImage(with: URL(string:imgUrl))
        
    }
}
