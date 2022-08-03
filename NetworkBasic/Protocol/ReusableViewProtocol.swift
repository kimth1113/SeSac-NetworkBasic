//
//  ReusableViewProtocol.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/08/01.
//

// 0801
import UIKit

protocol ReusableProtocol {
    
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableProtocol { // extension 저장 프로퍼티 불가능
    
    static var reuseIdentifier: String { // 연산 프로퍼티 get만 사용한다면 get 생략 가능
        String(describing: self)
    }
    
    
}

extension UITableViewCell: ReusableProtocol {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: ReusableProtocol {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
