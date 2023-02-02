//
//  MoviesCollectionViewCell.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 25.01.2023.
//

import UIKit
import AlamofireImage

class MoviesTableViewCell: UITableViewCell {
    
    //MARK: UI

    let movieName = CustomLabel()
    let movieImage = UIImageView()
    
    enum Identifier: String {
        case path = "Cell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Function
    
    private func configure(){
        contentView.addSubview(movieName)
        contentView.addSubview(movieImage)
        movieName.textAlignment = .left
        movieName.font = UIFont(name: "Poppins-Medium", size: 15)
        
        configureConstraints()
    }
    
    func saveModel(value: Result){
        movieName.text = value.title
        let imageUrl = "https://image.tmdb.org/t/p/w500"
        if let url = URL(string: "\(imageUrl)"+"\(value.posterPath ?? "")") {
            movieImage.af.setImage(withURL: url)
        }
    }
}

//MARK: Constraints

extension MoviesTableViewCell {
    func configureConstraints(){
        movieName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalTo(contentView)
            make.width.equalTo(contentView.bounds.width * 0.9)
            make.height.equalTo(contentView.bounds.height * 0.6)
        }
        
        movieImage.snp.makeConstraints { make in
            make.left.equalTo(movieName.snp.right)
            make.centerY.equalTo(contentView)
            make.width.equalTo(contentView.bounds.width * 0.3)
            make.height.equalTo(contentView.bounds.height * 1.2)
        }
    }
}
