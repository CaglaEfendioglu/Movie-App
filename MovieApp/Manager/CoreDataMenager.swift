//
//  CoreDataMenager.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 30.01.2023.
//

import Foundation

protocol CoreDataMenagerProtocol {
    func addMovie(value: MovieDetail)
    func deleteMovie(value: Movies)
    func fetchMovie() -> [Movies]
}

class CoreDataMenager: CoreDataMenagerProtocol {
    let context = appDelegate.persistentContainer.viewContext
    var movieList: [Movies] = []
    
    func fetchMovie() -> [Movies] {
        do{
            movieList = try context.fetch(Movies.fetchRequest())
        }catch{
            print(error)
        }
        return movieList
    }
    
    func addMovie(value: MovieDetail) {
        
        let movieFav = self.fetchMovie()
        var idList: [String] = []
        
        for i in movieFav {
            idList.append(i.id ?? "")
        }
        
        if !(idList.contains(String(value.id ?? 0))) {
            let movie = Movies(context: context)
            movie.title = value.title
            movie.image = value.backdropPath
            movie.id = "\(value.id ?? 0)"
            appDelegate.saveContext()
        }
    }
    
    func deleteMovie(value: Movies) {
        self.context.delete(value)
        appDelegate.saveContext()
    }
}
