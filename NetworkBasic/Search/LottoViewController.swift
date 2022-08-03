//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/07/28.
//

import UIKit

// 1. 임포트 0801
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {
    
    static var identifier = "LottoViewController"

    @IBOutlet weak var numberTextField: UITextField!
    //@IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBOutlet weak var drwNo1Label: UILabel!
    
    @IBOutlet weak var drwNo2Label: UILabel!
    @IBOutlet weak var drwNo3Label: UILabel!
    @IBOutlet weak var drwNo4Label: UILabel!
    @IBOutlet weak var drwNo5Label: UILabel!
    @IBOutlet weak var drwNo6Label: UILabel!
    @IBOutlet weak var bonusNoLabel: UILabel!
    
    
    
    var lottoPickerView = UIPickerView()
    // 코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있음
    
    let numberlist: [Int] = Array(1...1025).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        
        // 텍스트필드를 클릭했을 때 PickerView 보여주기
        numberTextField.inputView = lottoPickerView
        numberTextField.tintColor = .clear
        
        // 인증번호 노티 오면 자동 입력
        numberTextField.textContentType = .oneTimeCode
        
        requestLotto(number: 1026)
    }

    // 0810
    func requestLotto(number: Int) {
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
        
        // AF 기본값: 200~299: success
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let drwtNo1 = json["drwtNo1"].stringValue
                let drwtNo2 = json["drwtNo2"].stringValue
                let drwtNo3 = json["drwtNo3"].stringValue
                let drwtNo4 = json["drwtNo4"].stringValue
                let drwtNo5 = json["drwtNo5"].stringValue
                let drwtNo6 = json["drwtNo6"].stringValue
                let bonus = json["bnusNo"].stringValue
                
                let date = json["drwNoDate"].stringValue
                
                
                self.drwNo1Label.text = drwtNo1
                self.drwNo2Label.text = drwtNo2
                self.drwNo3Label.text = drwtNo3
                self.drwNo4Label.text = drwtNo4
                self.drwNo5Label.text = drwtNo5
                self.drwNo6Label.text = drwtNo6
                self.bonusNoLabel.text = bonus
                self.numberTextField.text = date
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}


extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberlist.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // numberTextField.text = "\(numberlist[row])회차"
        
        requestLotto(number: numberlist[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberlist[row])회차"
    }
}
