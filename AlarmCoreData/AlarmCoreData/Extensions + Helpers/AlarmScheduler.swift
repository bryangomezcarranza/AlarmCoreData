//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by Bryan Gomez on 7/29/21.
//

import Foundation
import UserNotifications

protocol AlarmSchedulerDelegate {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmSchedulerDelegate {
    func scheduleUserNotifications(for alarm: Alarm) {
        guard let timeOfDay = alarm.fireDate, let identifier = alarm.uuidString else { return }
        
        cancelUserNotifications(for: alarm)
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Its time to take your \(alarm.title ?? "alarm")"
        content.sound = .default
        
        let fireDateComponent = Calendar.current.dateComponents([.hour, .minute], from: timeOfDay)
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponent, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in // different
            if let error = error {
                print("Unable to add notification request. Error \(error.localizedDescription)")
            }
        }
        
    }
    func cancelUserNotifications(for alarm: Alarm) {
        guard let identifier = alarm.uuidString else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
