//
//  GameDetailBuilder.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 29.01.2023.
//

import Foundation

class MovieDetailBuilder {
    static func make(id: Int) -> MovieDetailVC {
        let vc = MovieDetailVC()
        let viewModel = MovieDetailViewModel(service: MovieDetailService(), id: id, coreDataMenager: CoreDataMenager())
        vc.viewModel = viewModel
        return vc
    }
}
