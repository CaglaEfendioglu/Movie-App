//
//  MovieFavoriteBuilder.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 30.01.2023.
//

import Foundation

class MovieFavoriteBuilder {
    static func make() -> MovieFavoriteVC {
        let vc = MovieFavoriteVC()
        let viewModel = MovieFavoriteViewModel(coreDataManager: CoreDataMenager())
        vc.viewModel = viewModel
        return vc
    }
}
