//
//  BeerListViewController.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON

class BeerListViewController: UIViewController {

    var beerList: [Beer] = []
    
    @IBOutlet weak var beerListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beerListTableView.delegate = self
        beerListTableView.dataSource = self
        
        beerListTableView.register(UINib(nibName: BeerListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: BeerListTableViewCell.reuseIdentifier)
        
        requestBeerList()
    }
    
    func requestBeerList() {
        let url = EndPoint.beerURL
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                
                for beer in json {
                    let beerInstance = Beer(imgURL: beer["image_url"].stringValue, title: beer["name"].stringValue, description: beer["description"].stringValue)
                    self.beerList.append(beerInstance)
                    
                }
                self.beerListTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = beerListTableView.dequeueReusableCell(withIdentifier: BeerListTableViewCell.reuseIdentifier, for: indexPath) as? BeerListTableViewCell else { return UITableViewCell() }
        
        let beerImgURL = beerList[indexPath.row].imgURL
        let beerTitle = beerList[indexPath.row].title
        let beerDescription = beerList[indexPath.row].description
        
        cell.bindingData(beerImgURL: beerImgURL, beerTitle: beerTitle, beerDescription: beerDescription)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
