//
//  MovieFavoriteTableViewCell.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 29.01.2023.
//

import UIKit
import AlamofireImage

class MovieFavoriteTableViewCell: UITableViewCell {
    
    //MARK: UI
    
    let favMovieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    let favMovieName = CustomLabel()

    enum Identifier: String {
           case path = "cell"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Function
    
    func saveUI(movie: Movies){
        favMovieName.text = movie.title
        let imageUrl = "https://image.tmdb.org/t/p/w500"
        favMovieImage.af.setImage(withURL: URL(string: "\(imageUrl)"+"\(movie.image!)")!)
    }
    
    private func configure() {
        contentView.addSubview(favMovieImage)
        contentView.addSubview(favMovieName)
        favMovieName.textAlignment = .left
        
    }
}

//MARK: Constraints

extension MovieFavoriteTableViewCell{
    private func configureConstraints(){
        favMovieImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            make.left.equalTo(contentView).offset(8)
            make.width.equalTo(contentView.frame.width * 0.2)
        }
        favMovieName.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(favMovieImage.snp.right).offset(24)
            make.width.equalToSuperview()
        }
    }
}
