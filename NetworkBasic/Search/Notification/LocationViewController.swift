//
//  LocationViewController.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController { // ReusableProtocol
    
    //LocationViewController.self 메타 타입 => "LocationViewController"
    // static var reuseIdentifier: String = String(describing: WebViewController.self) // 0801

    
    // Notification 1. 로컬 노티피케이션을 가지고 있는 객체 가지고 오기
    // 알람에 대해서 전체적으로 관장하고 있는 요소
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for family in UIFont.familyNames {
            print("=====\(family)====")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print(name)
            }
        }
        
        
        
        requestAuthorization()
        
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        sendNotification()
    }
    
    // Notification 2. 권한 요청
    func requestAuthorization() {
        
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
    
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            
            // 사용자가 알림을 허용했을 때
            if success {
                self.sendNotification()
            }
            
        }
    }

    // Notification 3. 권한 허용한 사용자에게 알림 요청(언제? 어떤 콘텐츠?)
    // iOS 시스템에서 알림을 담당 > 알림 등록
    
    
    /*
     - 권한 허용 해야만 알림이 온다.
     - 권한 허용 문구 시스템적으로 최초 한 번 안 뜬다.
     - 허용 안 된 경우 애플 설정으로 직접 유도하는 코드를 구성해야한다.
     
     - 기본적으로 알림은 포그라운드에서 수신되지 않는다.
     - 로컬 알림에서 60초 이상 반복 가능 / 갯수 제한 64개
     */
    
    /*
     1. 뱃지 제거? > 언제 제거하는게 맞을까? (SceneDelegate)
     2. 노티 제거? > 노티의 유효기간은? 한달정도 > 언제 지워주는 게 맞을까? 
     3. 포그라운드 수신? > 앱 사용 중에도 노티를 받고 싶음
     
     +a
     - 노티는 앱 실행이 기본인데, 특정 노티를 클릭할 때 특정 화면으로 가고 싶다면?
     - 포그라운드 수신 > 해당 카톡방에 있으면 그 방의 채팅은 노티가 안뜸
     - iOS15 집중모드 등 5~6 우선순위 존재
     */
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "다마고치를 키워보세요"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...100))"
        notificationContent.body = "저는 따끔따끔 다마고치입니다. 배고파요."
        notificationContent.badge = 40
        
        // 언제 보낼 것인가? 방법 1. 시간 간격 2. 캘린더 3. 위치에 따라 설정 가능
        // 시간 간격은 60초 이상 설정해야 반복 가능
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        var dateComponents = DateComponents()
        //dateComponents.minute = 15
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        // 알림 요청
        // identifier? 여러 종류의 알림을 구분하기 위한 알림ID
        // 만약 알림 관리할 필요 X -> 알림 클릭하면 앱을 켜주는 정도, ex) (Date()) 사용
        // 만약 알림 관리할 필요 O -> +1, 고유 이름, 규칙 등
        // 1분 12개 >
        //let request = UNNotificationRequest(identifier: "\(Date())", content: notificationContent, trigger: trigger)
        let request = UNNotificationRequest(identifier: "jack", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }
}
