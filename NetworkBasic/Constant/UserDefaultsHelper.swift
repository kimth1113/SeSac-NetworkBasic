//
//  UserDefaultsHelper.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/08/01.
//

import Foundation

// 0801
class UserDefaultsHelper {
    
    // 외부에서 생성하지 않도록
    private init() { }
    
    // singleton pattern 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음
    // 다른 클래스에서 인스턴스를 생성하면 싱글톤 패턴 규칙이 깨짐
    static let standard = UserDefaultsHelper()
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickname, age
    }
    
    var nickname: String {
        get {
            userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            userDefaults.integer(forKey: Key.age.rawValue) // 옵셔널 오류가 안나는 이유 => 기본값이 0이라서..
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}
