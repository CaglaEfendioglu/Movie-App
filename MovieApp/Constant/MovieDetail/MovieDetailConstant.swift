//
//  MovieDetailConstant.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 2.02.2023.
//

import Foundation

class MovieDetailConstant {
    enum UIConstant: String {
        case favButtonTitle = "Add To Favorites"
    }
    
    enum imageUrl: String {
        case imageURL = "https://image.tmdb.org/t/p/w500"
        
        static func imageURL(url: String) -> String {
            return "\(imageURL.rawValue)\(url)"
        }
    }
}
