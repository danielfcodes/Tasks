//
//  NotificationScheduler.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/22/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation
import UserNotifications

protocol NotificationSchedulerDelegate {
    func scheduleNotification(forDate date: Date, withName name: String)
}

class NotificationScheduler: NotificationSchedulerDelegate {
    
    func scheduleNotification(forDate date: Date, withName name: String) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = name
        content.sound = UNNotificationSound.default
        let identifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
