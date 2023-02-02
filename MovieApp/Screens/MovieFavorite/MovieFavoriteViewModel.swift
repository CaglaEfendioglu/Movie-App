//
//  MovieFavoriteViewModel.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 30.01.2023.
//

import Foundation

protocol MovieFavoriteViewModelProtocol {
    var output: MovieFavoriteOutput? {get set}
    func deleteCoreData(movie: Movies)
    func fetchCoreData()
}

protocol MovieFavoriteOutput {
    func favoriteMovie(data: [Movies])
}

class MovieFavoriteViewModel: MovieFavoriteViewModelProtocol {
    var output: MovieFavoriteOutput?
    var coreDataManager: CoreDataMenagerProtocol?
    
    init(coreDataManager: CoreDataMenagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension MovieFavoriteViewModel {
    func deleteCoreData(movie: Movies) {
        coreDataManager?.deleteMovie(value: movie)
    }
    
    func fetchCoreData() {
        let favMovie = coreDataManager?.fetchMovie()
        output?.favoriteMovie(data: favMovie!)
    }
}
