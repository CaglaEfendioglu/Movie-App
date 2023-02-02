//
//  NetworkConstant.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 2.02.2023.
//

import Foundation

class NetworkConstant {
    
    enum movieListAPI: String {
        case pathUrl = "https://api.themoviedb.org/3/movie"
        case genreUrl = "/popular"
        case apiKey = "?api_key=bbcf40fdb8533cb3b92be64af6bc2e87"
        case languageUrl = "&language=en-US&page=1"
        
        
        static func movieListAPI() -> String {
            return "\(pathUrl.rawValue)\(genreUrl.rawValue)\(apiKey.rawValue)\(languageUrl.rawValue)"
        }
    }
    
    enum movieDetailAPI: String {
        case pathUrl = "https://api.themoviedb.org/3/movie/"
        case apiKey = "?api_key=bbcf40fdb8533cb3b92be64af6bc2e87"
        case languageUrl = "&language=en-US"
        
        static func movieDetailAPI(id: Int) -> String {
            return "\(pathUrl.rawValue)\(id)\(apiKey.rawValue)\(languageUrl.rawValue)"
        }
    }
}
