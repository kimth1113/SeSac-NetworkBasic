//
//  RandomBeerViewController.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/08/02.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class RandomBeerViewController: UIViewController {

    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerImg: UIImageView!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestRandomBeer()
    }

    func requestRandomBeer() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let beerName = json[0]["name"].stringValue
                let imgURL = json[0]["image_url"].stringValue
                let beerDescription = json[0]["description"].stringValue
                
                let beerImgURL = URL(string: imgURL)
                
                self.beerNameLabel.text = beerName
                self.beerImg.kf.setImage(with: beerImgURL)
                self.beerDescriptionLabel.text = beerDescription
                
                
//                let url = URL(string: imageURL)
//                cell.posterImageView.kf.setImage(with: url)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func tappedRandomBeerButton(_ sender: UIButton) {
        requestRandomBeer()
    }
}
