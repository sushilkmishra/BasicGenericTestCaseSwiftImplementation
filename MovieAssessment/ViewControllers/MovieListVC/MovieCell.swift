//
//  MovieCell.swift
//  MovieAssessment
//
//  Created by Sushil K Mishra on 08/10/22.
//

import UIKit

class MovieCell: UITableViewCell {

    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 16.0)
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let ratingLabel : UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.textColor = .black
        ratingLabel.font = UIFont.systemFont(ofSize: 16.0)
        ratingLabel.textAlignment = .left
        ratingLabel.numberOfLines = 0
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingLabel
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
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        view.addSubview(nameLabel)
        view.addSubview(movieImage)
        view.addSubview(ratingLabel)

        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            movieImage.widthAnchor.constraint(equalToConstant: 60),
            movieImage.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -10),

            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            ratingLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
                   ])
        
        
        contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0),
            view.heightAnchor.constraint(equalToConstant: 80)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
