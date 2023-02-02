//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 25.01.2023.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    var delegate: MovieDetailViewModelDelegate? {get set}
    func loadMovieDetail()
    func addCoreData(data: MovieDetail)
}

enum MovieDetailOutPut {
    case movieDetailData(data: MovieDetail)
    case showError(data: String)
}

protocol MovieDetailViewModelDelegate {
    func handleOutput(output: MovieDetailOutPut)
}
class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var delegate: MovieDetailViewModelDelegate?
    var service: MovieDetailServiceProtocol?
    var id: Int?
    var coreDataMenager: CoreDataMenagerProtocol?
    
    init(service: MovieDetailServiceProtocol, id: Int, coreDataMenager: CoreDataMenagerProtocol) {
        self.service = service
        self.id = id
        self.coreDataMenager = coreDataMenager
    }
}

extension MovieDetailViewModel {
    func loadMovieDetail() {
        service?.fetchMovieDetail(id: id ?? 0, onSuccess: { [delegate] movie in
            delegate?.handleOutput(output: .movieDetailData(data: movie))
        }, onError: { [delegate] error in
            delegate?.handleOutput(output: .showError(data: error))
        })
    }
    
    func addCoreData(data: MovieDetail) {
        coreDataMenager?.addMovie(value: data)
    }
}
