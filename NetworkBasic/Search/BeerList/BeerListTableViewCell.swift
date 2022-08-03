//
//  BeerListTableViewCell.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/08/02.
//

import UIKit

import Kingfisher

class BeerListTableViewCell: UITableViewCell {

  
    @IBOutlet weak var beerImgView: UIImageView!
    @IBOutlet weak var beerTitleLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    func bindingData(beerImgURL: String, beerTitle: String, beerDescription: String) {
        
        let url = URL(string: beerImgURL)
        beerImgView.kf.setImage(with: url)
        beerImgView.contentMode = .scaleAspectFit
        
        beerTitleLabel.text = beerTitle
        beerTitleLabel.font = .boldSystemFont(ofSize: 16)
        beerDescriptionLabel.text = beerDescription
        beerDescriptionLabel.numberOfLines = 0
        
        print(beerImgURL, beerTitle, beerDescription)
    }
    
    
}
