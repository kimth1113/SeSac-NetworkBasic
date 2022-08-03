//
//  TMDBTableViewCell.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/08/03.
//

import UIKit

class TMDBCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rateMovieLabel: UILabel!
    @IBOutlet weak var clipButton: UIButton!
    
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var arrowAboutButton: UIButton!

    @IBOutlet weak var movieInfoView: UIView!
    
    func designLayout(movie: TMDBMovie) {
        releaseDateLabel.text = movie.date
        releaseDateLabel.font = .systemFont(ofSize: 12)
        
        genreLabel.text = movie.genre
        genreLabel.backgroundColor = .clear
        
        
        let url = URL(string: EndPoint.tmdbImgURL + movie.imgURL)
        posterImage.kf.setImage(with: url)
        posterImage.contentMode = .scaleAspectFill
        posterImage.layer.cornerRadius = 12
        posterImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
//            .layer.cornerRadius = 20
//            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        rateLabel.text = "평점"
        rateMovieLabel.text = String(movie.rate)
        
        titleLabel.text = movie.title
        
        peopleLabel.text = movie.people
        
        aboutLabel.text = "자세히 보기"
        
        movieInfoView.layer.cornerRadius = 12
        movieInfoView.layer.masksToBounds = false
        
        movieInfoView.layer.shadowColor = UIColor.black.cgColor
        movieInfoView.layer.shadowOpacity = 0.2
        movieInfoView.layer.shadowRadius = 10
        movieInfoView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        movieInfoView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.frame.width-16, height: movieInfoView.frame.height)).cgPath
    }
    
    
    func bindingData() {
        
    }
    
}
