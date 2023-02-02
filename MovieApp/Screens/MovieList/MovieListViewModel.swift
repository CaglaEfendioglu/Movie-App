//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 24.01.2023.
//

import Foundation

protocol MovieListViewModelProtocol {
    var delegate : MovieListViewModelDelegate? {get set}
    func load()
}

enum MovieListViewModelOutPut {
    case movie([Result])
    case error(String)
}

protocol MovieListViewModelDelegate {
    func handlerOutput(output: MovieListViewModelOutPut)
}

class MovieListViewModel: MovieListViewModelProtocol {
    var delegate: MovieListViewModelDelegate?
    let service: MovieListServiceProtocol?
    
    init(service: MovieListServiceProtocol){
        self.service = service
    }
    
    func load() {
        service?.fetcMovies(onSuccess: { [delegate] movie in
            delegate?.handlerOutput(output: .movie(movie))
        }, onError: { [delegate] error in
            delegate?.handlerOutput(output: .error(error))
        })
    }
}
