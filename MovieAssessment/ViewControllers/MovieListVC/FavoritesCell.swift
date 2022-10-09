//
//  FavoritesCell.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 13.0)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let movieImage : UIImageView = {
        let movieImage = UIImageView()
        movieImage.contentMode = .scaleAspectFill
        movieImage.backgroundColor = .systemGray2
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.layer.cornerRadius = 30
        movieImage.clipsToBounds = true
        return movieImage
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0),
            view.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        view.addSubview(nameLabel)
        view.addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            movieImage.widthAnchor.constraint(equalToConstant: 60),
            movieImage.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
//            nameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
