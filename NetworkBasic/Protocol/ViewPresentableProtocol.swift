//
//  ViewPresentableProtocol.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/07/28.
//

import Foundation
import UIKit


// 프로토콜은 규약이자 필요한 요소를 명세만 할 뿐, 실질적인 구현부는 작성하지 않는다!
// 실질적인 구현은 프로토콜을 채택, 준수한 타입이 구현한다! (클래스, 구조체)
// 클래스, 구조체, 익스텐션, 열겨형... 등에서 사용 가능
// 클래스는 단일 상속만 가능하지만, 프로토콜은 채택 갯수에 제한 없음!
// @objc optional > 선택적 요청(Optional Requirment)
// 프로토콜 프로퍼티, 프로토콜 메서드

// 프로토콜 프로퍼티: 연산 프로퍼티로 쓰는 저장 프로퍼티로 쓰는 상관하지 않는다!
// 명세하지 않기에, 구현을 할 때 프로퍼티를 저장 프로퍼티로 쓸 수도 있고 연산 프로퍼티로 사용할 수도 있다.
// 무조건 var로 선언해야 한다.
// 만약 get을 명시했다면, get 기능만 최소한으로 구현되어 있으면 된다! 그래서 필요하다면 set도 구현해도 괜찮다.
@objc
protocol ViewPresentableProtocol {
    
    var navigationTitleString: String { get set }
    var backgroundColor: UIColor { get }
    static var identifier: String { get }
    
    // 네이밍만 명세
    func configureView()
    @objc optional func configureLabel()
    @objc optional func configureTextField()
}

/*
 ex. 테이블뷰
 */
@objc
protocol TasonTabelViewProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
    @objc optional func didSelectRowAt()
}
