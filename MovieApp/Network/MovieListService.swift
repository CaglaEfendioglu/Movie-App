//
//  MovieListService.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 24.01.2023.
//

import Foundation
import Alamofire

protocol MovieListServiceProtocol {
    func fetcMovies(onSuccess: @escaping ([Result]) -> Void, onError: @escaping (String) -> Void)
}

class MovieListService: MovieListServiceProtocol {
    func fetcMovies(onSuccess: @escaping ([Result]) -> Void, onError: @escaping (String) -> Void) {
        AF.request(NetworkConstant.movieListAPI.movieListAPI(), method: .get).responseDecodable(of: Movie.self) { movie in
            guard let data = movie.value else {
                return onError("error")
            }
            if let dataResults = data.results {
                onSuccess(dataResults)
            }
        }
    }
}
