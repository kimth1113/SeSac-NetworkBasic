//
//  AppDelegate.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/07/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 2. 노티 제거
        // 알림 앱 미리 알림 스케줄 할일 목록 > 하루 전 알림 30분 전 알림
        // 받은 노티만 제거
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        // 받을 예정인 노티도 모두 제거
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound])
        
        //iOS 14 list, banner <-> alert
    }
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // 앱이 종료되는 시점 (배터리 부족, 저전력모드, 갑자기 꺼짐: 호출 안될 수 있음)
    func applicationWillTerminate(_ application: UIApplication) {
        print("앱 꺼짐")
    }
}

