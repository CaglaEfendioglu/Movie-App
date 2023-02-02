//
//  MovieListBuilder.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 24.01.2023.
//

import Foundation

class MovieListBuilder {
    static func make() -> MovieListVC {
        let vc = MovieListVC()
        let viewModel = MovieListViewModel(service: MovieListService())
        vc.viewModel = viewModel
        return vc
    }
}
