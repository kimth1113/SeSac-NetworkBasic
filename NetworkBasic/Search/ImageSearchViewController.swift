//
//  ImageSearchViewController.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequestImage()
    }
    
    // fetchImage, requestImage, callRequestImage, getImage, ... > response에 따라 네이밍을 설정해주기도 함
    func callRequestImage() {
        let text = "과자".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=1"
        
        //let parameter = ["source": "ko", "target": "en",  "text": data]
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.NAVER_ID,
            "X-Naver-Client-Secret": APIKey.NAVER_SECRET
        ]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
