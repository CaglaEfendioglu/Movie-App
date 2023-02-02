//
//  ViewController.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 24.01.2023.
//

import UIKit
import SnapKit

class MovieListVC: UIViewController {
    
    //MARK: UI
    
    let moviesTableView = UITableView()
    let searchBar = UISearchBar()
    
    //MARK: Properties
    
    var viewModel: MovieListViewModelProtocol?
    private var movieData = [Result]()
    private var moviesList = [Result]()
    private var isSearch =  false
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        viewModel?.load()
    }
    
    //MARK: Private Func
    
    private func initDelegate(){
        viewModel?.delegate = self
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        searchBar.delegate = self
        
        configure()
    }
    
    private func configure(){
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        view.addSubview(searchBar)
        view.addSubview(moviesTableView)
        searchBar.placeholder = MovieListConstant.movieListUIConstant.placeHolder.rawValue
        searchBar.showsCancelButton = true
        moviesTableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.Identifier.path.rawValue)
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "suit.heart.fill"), style: .done, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
        
        configureConstraints()
    }
    
    @objc func rightButtonTapped(){
        self.show(MovieFavoriteBuilder.make(), sender: nil)
    }
    
    @objc func didTapBackButton(){
        dismiss(animated: true)
    }
}
    
    //MARK: MovieListViewModelDelegate

extension MovieListVC: MovieListViewModelDelegate {
    func handlerOutput(output: MovieListViewModelOutPut) {
        switch output {
        case .movie(let movie):
            movieData = movie
            moviesTableView.reloadData()
        case .error(let error):
            print(error)
        }
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
    
extension MovieListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = Int()
        if isSearch {
            count = moviesList.count
        }else{
            count = movieData.count
        }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.Identifier.path.rawValue) as? MoviesTableViewCell else
        {
            return UITableViewCell()
        }
        if isSearch {
            cell.saveModel(value: moviesList[indexPath.row])
        }else{
            cell.saveModel(value: movieData[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.09
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var id: Int?
        
        if isSearch {
          id = moviesList[indexPath.row].id ?? 0
        }else{
           id = movieData[indexPath.row].id ?? 0
        }
        let vc = MovieDetailBuilder.make(id: id ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: UISearchBarDelegate

extension MovieListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text != "" {
            isSearch = true
            moviesList = movieData.filter({($0.originalTitle!.lowercased().contains(searchText.lowercased()) )})
        }else{
            isSearch = false
        }
        moviesTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
        isSearch = false
        self.searchBar.endEditing(true)
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
}

//MARK: Constraints
    
extension MovieListVC {
    func configureConstraints(){
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.width * 0.15)
            make.left.right.equalTo(view)
        }

        moviesTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
