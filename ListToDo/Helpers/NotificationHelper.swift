//
//  NotyficationHelper.swift
//  ListToDo
//
//  Created by piotr koscielny on 10/6/25.
//

import SwiftUI
import UserNotifications

@Observable
final class NotificationHelper {
    var showPermissionAlert = false
    
    func requestPermission() async -> Bool {
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()
        
        switch settings.authorizationStatus {
        case .notDetermined:
            let granted = try? await center.requestAuthorization(options: [.alert, .badge, .sound])
            if granted == true {
                return true
            } else {
                showPermissionAlert = true
                return false
            }
        case .denied:
            showPermissionAlert = true
            return false
        case .authorized, .provisional, .ephemeral:
            return true
        default:
            showPermissionAlert = true
            return false
        }
    }
    
    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    func extiApp() {
        exit(0)
    }
}
