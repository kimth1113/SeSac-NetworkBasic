//
//  ViewController.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/07/28.
//

import UIKit

class ViewController: UIViewController, ViewPresentableProtocol {

    static let identifier: String = "ViewController"
    
    // 초기화 필요
    var navigationTitleString: String {
        get {
            return "대장님의 다마고치"
        }
        set {
            title = newValue
        }
    }
    
    let backgroundColor: UIColor = .blue // 초기화 필요, get 기능만 쓰겠다면 let 선언

    override func viewDidLoad() {
        super.viewDidLoad()

        //0810
        UserDefaultsHelper.standard.nickname = "고래밥"
        title = UserDefaultsHelper.standard.nickname
        
        UserDefaultsHelper.standard.age = 80
        print(UserDefaultsHelper.standard.age)
    }
    

    
    func configureView() {
        navigationTitleString = "고래밥님의 다마고치" // Set
        // backgroundColor = .red // Get 전용으로만 구현했는데 Set이 가능
        
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
    
    func configureLabel() {
        
    }
    
}
