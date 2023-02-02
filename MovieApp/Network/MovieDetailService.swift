//
//  MovieDetailService.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 29.01.2023.
//

import Foundation
import Alamofire

protocol MovieDetailServiceProtocol {
    func fetchMovieDetail(id: Int, onSuccess: @escaping (MovieDetail) -> Void, onError: @escaping (String) -> Void)
}

class MovieDetailService: MovieDetailServiceProtocol {
    func fetchMovieDetail(id: Int, onSuccess: @escaping (MovieDetail) -> Void, onError: @escaping (String) -> Void) {
        AF.request(NetworkConstant.movieDetailAPI.movieDetailAPI(id: id), method: .get).responseDecodable(of: MovieDetail.self) {  movie in
            guard let data = movie.value else{
                return onError("error")
            }
            onSuccess(data)
        }
    }
}
