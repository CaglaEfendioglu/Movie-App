//
//  MovieFavoriteVC.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 29.01.2023.
//

import UIKit
import Lottie

class MovieFavoriteVC: UIViewController {
    
    //MARK: UI

   private let generalView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let favMoviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UIScreen.main.bounds.width * 0.17
        tableView.register(MovieFavoriteTableViewCell.self, forCellReuseIdentifier: MovieFavoriteTableViewCell.Identifier.path.rawValue)
        return tableView
    }()
    
    private let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "empty-box-orange-theme")
        animationView.isHidden = true
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    //MARK: Properties

    private var favIsEmpty = true
    private var moviesList = [Movies]()
    var viewModel: MovieFavoriteViewModelProtocol?
    private let context = appDelegate.persistentContainer.viewContext
    
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
        configure()
        configureConstraints()
        isEmpty()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isEmpty()
        fetchData()
        favMoviesTableView.reloadData()
    }
    
    //MARK: Private Function
    
    private func initDelegate() {
        viewModel?.output = self
        favMoviesTableView.delegate = self
        favMoviesTableView.dataSource = self
    }

    private func configure(){
        view.backgroundColor = .white
        view.addSubview(generalView)
        view.addSubview(favMoviesTableView)
        view.addSubview(animationView)
        navigationItem.hidesBackButton = true
        navigationItem.title = "FAVORITES MOVİES"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : (UIFont(name: "Poppins-BlackItalic", size: 17))!]
        let leftButton = UIBarButtonItem(image: UIImage(named: "backbutton"), style: .done, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func fetchData(){
        viewModel?.fetchCoreData()
    }
    
    @objc func leftButtonTapped(){
        navigationController?.popViewController(animated: true)
    }

    
    private func isEmpty(){
        if moviesList.isEmpty {
            favIsEmpty = true
            favMoviesTableView.isHidden = true
            animationView.isHidden = false
        }else{
            favIsEmpty = false
            favMoviesTableView.isHidden = false
            animationView.isHidden = true
        }
    }
}

// MARK: MovieFavoriteOutput

extension MovieFavoriteVC: MovieFavoriteOutput {
    func favoriteMovie(data: [Movies]) {
        self.moviesList = data
        self.favMoviesTableView.reloadData()
    }
}

//MARK: -Tableview
extension MovieFavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieFavoriteTableViewCell.Identifier.path.rawValue) as? MovieFavoriteTableViewCell else
        {
            return UITableViewCell()
        }
        cell.saveUI(movie: moviesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.1
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let alertAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this movie?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                let movie = self.moviesList[indexPath.row]
                self.viewModel?.deleteCoreData(movie: movie)
                self.favMoviesTableView.reloadData()
                self.fetchData()
                self.isEmpty()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [alertAction])
    }
}

//MARK: Constraints
extension MovieFavoriteVC {
    private func configureConstraints(){
        generalView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(0.001 * UIScreen.main.bounds.height)
        }
        favMoviesTableView.snp.makeConstraints { make in
            make.top.equalTo(generalView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        animationView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(view)
            make.height.width.equalTo(UIScreen.main.bounds.width * 0.6)
        }
    }
}
