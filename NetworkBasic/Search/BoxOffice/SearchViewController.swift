//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON

/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔 / 오른팔
 2. 테이블뷰 아웃렛 연결
 3. 1 + 2 in DidLoad
 */

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource { // ViewProtocol
    

    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // BoxOffice 담을 배열
    var list: [BoxOfficModel] = []
    
    // 타입 어노테이션 vs 타입 추론 => 누가 더 속도가 빠를까?
    // What's new in Swift
    var nickname: String = ""
    var username = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        searchBar.backgroundColor = .clear
        searchTableView.backgroundColor = .clear
        
        // 연결고리 작업: 테이블뷰가 해야할 역할
        searchTableView.delegate = self
        searchTableView.dataSource = self
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB: xml interface builder <= NIB
        searchTableView.register(UINib(nibName: SearchTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        
        searchBar.delegate = self
        
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd" // TMI -> "yyyyMMdd" "YYYYMMdd" 차이: (찾아보세요)
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        //let dateResult = Date(timeIntervalSinceNow: -86400)
        
        let dateResult = format.string(from: yesterday!)
        
        // 네트워크 통신: 서버 점검 등에 대한 예외 처리
        // 네트워크가 느린 환경 테스트: 실기기 테스트 시 Condition 조절 가능! (권장)
        // 시뮬레이터에서도 가능! (추가 설치)
        
        requestBoxOffice(text: dateResult)
    }
    
    
    // Protocol function
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func configureLabel() {
        
    }
    
    // 0802
    func requestBoxOffice(text: String) {
        
        list.removeAll()
        
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let boxOffice = BoxOfficModel(movieTitle: movie["movieNm"].stringValue, releaseDate: movie["openDt"].stringValue, totalCount: movie["audiAcc"].stringValue)
                    self.list.append(boxOffice)
                }
                
                // 화면에 보여지도록 한번 더 업데이트
                self.searchTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    

    // UIViewController에 있기 때문에 override 아님/C
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // 0801
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell else { // 0801
            return UITableViewCell()
        }
        
        cell.backgroundColor = .clear
        cell.titleLabel.text = "\(list[indexPath.row].movieTitle): \(list[indexPath.row].releaseDate): \(list[indexPath.row].totalCount)"
        cell.titleLabel.font = .boldSystemFont(ofSize: 20)
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    // 검색
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        requestBoxOffice(text: searchBar.text!)
    }
}
