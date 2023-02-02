//
//  MovieDetailVC.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 25.01.2023.
//

import UIKit
import AlamofireImage
import CoreData
import Lottie

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class MovieDetailVC: UIViewController {
    
    //MARK: UI
    
    let movieGenre = CustomLabel()
    let movieOriginalLanguage = CustomLabel()
    let movieReleaseDate = CustomLabel()
    let movieOverview = CustomLabel()
    
    let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let addToFav: UIButton = {
        let button = UIButton()
        button.setTitle(MovieDetailConstant.UIConstant.favButtonTitle.rawValue, for: .normal)
        button.titleLabel!.font = UIFont(name: "Poppins-SemiBold", size: 15)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        return button
    }()
    
    let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "91001-success")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        return animationView
    }()
    
    //MARK: Properties

    var viewModel: MovieDetailViewModelProtocol?
    let context = appDelegate.persistentContainer.viewContext
    var favMovie: MovieDetail? = nil
    
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureConstraints()
        viewModel?.delegate = self
        viewModel?.loadMovieDetail()
    }
    
    //MARK: Private Function
    
    private func configure(){
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        view.addSubview(movieImage)
        view.addSubview(movieOriginalLanguage)
        view.addSubview(movieReleaseDate)
        view.addSubview(movieGenre)
        view.addSubview(movieOverview)
        view.addSubview(addToFav)
        view.addSubview(animationView)
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "backbutton"), style: .done, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        
        addToFav.addTarget(self, action: #selector(didTapFavButton), for: .touchUpInside)
    }
    
    private func saveUI(movieData: MovieDetail){
        navigationItem.title = movieData.title
        var genreData = ""
        guard let genre = movieData.genres else { return }
        for i in genre  {
            genreData +=  "\(i.name!) \n"
        }
        movieGenre.labelText(text: "GENRES: \n\(genreData)")
        movieGenre.text = "GENRES: \n\(genreData)"
        movieOverview.text = "OVERVIEW: \n \(movieData.overview!)"
        movieReleaseDate.text  = "RELEASE DATE: \n \(movieData.releaseDate!)"
        movieOriginalLanguage.text = "ORIGINAL LANGUAGE: \n \(movieData.originalLanguage!)"
        
        if let url = URL(string: MovieDetailConstant.imageUrl.imageURL(url: movieData.backdropPath ?? "")) {
            movieImage.af.setImage(withURL: url)
        }
    }
    
    @objc func didTapFavButton(){
        if let movieDetail = favMovie {
            viewModel?.addCoreData(data: movieDetail)
        }
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            animationView.stop()
        }
    }
    
    @objc func leftButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
}

//MARK: MovieDetailViewModelDelegate

extension MovieDetailVC: MovieDetailViewModelDelegate{
    func handleOutput(output: MovieDetailOutPut) {
        switch output {
        case .movieDetailData(data: let movie):
            saveUI(movieData: movie)
            favMovie = movie
        case .showError(data: let error):
            print(error)
        }
    }
}

//MARK: Constraints

extension MovieDetailVC {
    private func configureConstraints(){
        movieImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(UIScreen.main.bounds.height * 0.3)
            make.left.right.equalTo(view)
        }
        
        movieGenre.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(24)
            make.left.equalTo(view).offset(24)
            make.width.equalTo(UIScreen.main.bounds.width * 0.25)
        }
        movieReleaseDate.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(24)
            make.right.equalTo(view).offset(-24)
            make.width.equalTo(UIScreen.main.bounds.width * 0.5)
        }
        movieOriginalLanguage.snp.makeConstraints { make in
            make.top.equalTo(movieReleaseDate.snp.bottom).offset(24)
            make.right.equalTo(view).offset(-24)
            make.width.equalTo(UIScreen.main.bounds.width * 0.5)
        }
        movieOverview.snp.makeConstraints { make in
            make.top.equalTo(movieOriginalLanguage.snp.bottom).offset(24)
            make.left.right.equalTo(view)
        }
        addToFav.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.width.equalTo(UIScreen.main.bounds.width * 0.5)
            make.centerX.equalTo(view)
        }
        animationView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
            make.height.width.equalTo(UIScreen.main.bounds.width * 0.3)
        }
    }
}
