//
//  TMDBViewController.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class TMDBViewController: UIViewController {

    var tmdbMovieList: [TMDBMovie] = []
    
    @IBOutlet weak var tmdbCollectionView: UICollectionView!
    @IBOutlet weak var tmdbSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tmdbSearchBar.delegate = self

        tmdbCollectionView.delegate = self
        tmdbCollectionView.dataSource = self
        
        tmdbCollectionView.register(UINib(nibName: TMDBCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: TMDBCollectionViewCell.reuseIdentifier)
        
        designCollectionView()
    }
    
    func designCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        layout.scrollDirection = .vertical
        //상하좌우 여백
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        tmdbCollectionView.collectionViewLayout = layout
        
    }

    func requestTMDBDate(keyword: String) {
        let text = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = EndPoint.tmdbSearchURL + "api_key=\(APIKey.TMDB_KEY)&language=ko&query=\(text)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for movie in json["results"].arrayValue {
                    var tmdbMovie = TMDBMovie(date: movie["release_date"].stringValue, imgURL: movie["poster_path"].stringValue, rate: movie["vote_average"].doubleValue, title: movie["title"].stringValue)
                    
                    self.tmdbMovieList.append(tmdbMovie)
                }
                
                self.tmdbCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tmdbMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = tmdbCollectionView.dequeueReusableCell(withReuseIdentifier: TMDBCollectionViewCell.reuseIdentifier, for: indexPath) as? TMDBCollectionViewCell else { return UICollectionViewCell() }
        
        let movie = tmdbMovieList[indexPath.item]
        
        cell.designLayout(movie: movie)
        cell.layer.masksToBounds = false
        cell.clipsToBounds = false
        
        return cell
    }
}

extension TMDBViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestTMDBDate(keyword: searchBar.text!)
        print(tmdbMovieList)
    }
}
