//
//  TranslateViewController.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON
import SwiftUI

// UIButton, UITextField > Action
// UITextView, UISearchBar, UIPickerView > X
// UIControl을 상속받지 않아서
// UIResponderChain > 수많은 뷰객체중 어떤 객체를 선택했는지 알려주는 기능

class TranslateViewController: UIViewController {

    @IBOutlet weak var userInputTextView: UITextView!
    
    let textViewPlaceHolderText = "번역하고 싶은 문장을 작성해보세요."
    @IBOutlet weak var translatedLangTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userInputTextView.font = UIFont(name: "ulsanjunggu", size: 17)
        
        userInputTextView.delegate = self
        
//        userInputTextView.resignFirstResponder()
//        userInputTextView.becomeFirstResponder()
        
        userInputTextView.text = textViewPlaceHolderText
        userInputTextView.textColor = .lightGray
        
        requestTranslateData(data: "내용을 입력해주세요.")
    }

    
    // 0802
    func requestTranslateData(data: String) {
        let url = EndPoint.translateURL
        
        let parameter = ["source": "ko", "target": "en",  "text": data]
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.NAVER_ID,
            "X-Naver-Client-Secret": APIKey.NAVER_SECRET
        ]
        
        AF.request(url, method: .post, parameters: parameter, headers: header).validate(statusCode: 200...500).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    
                } else {
                    self.userInputTextView.text = json["errorMessage"].stringValue
                }
                
                let result = json["message"]["result"]["translatedText"].stringValue
                self.translatedLangTextView.text = result
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func tappedTranslateBtn(_ sender: UIButton) {
        requestTranslateData(data: userInputTextView.text)
    }
}

extension TranslateViewController: UITextViewDelegate {
    
    // 텍스트가 바뀔 때마나
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    // 커서가 올라갔을 때
    // 텍스트뷰 글자: 플레이스 홀더랑 글자가 같으면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 텍스트에 대한 편집이 끝났을 때. 커서가 없어지는 순간.
    // 텍스트뷰 글자: 아무 글자도 없으면 플레이스 홀더 글자 보이게
    
    // MARK: 중요
    /// 함수
    /// - Parameter textView: 매개변수
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            userInputTextView.text = textViewPlaceHolderText
            userInputTextView.textColor = .lightGray
        }
        
    }
}
