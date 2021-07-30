//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by Bryan Gomez on 7/29/21.
//

import Foundation
import CoreData

class AlarmController: AlarmSchedulerDelegate {
    static let shared = AlarmController()
    
    var alarms: [Alarm] = {
        // combines fetchRequest with fetchAlarm function. Returns the fetching for an Alarm, and if not found it defaults to an [].
        let request = NSFetchRequest<Alarm>(entityName: "Alarm")
        request.predicate = NSPredicate(value: true)
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }()
    
    private init() {}
    
    func createAlarm(withTitle title: String, and fireDate: Date) {
        let newAlarm = Alarm(title: title, fireDate: fireDate)
        self.alarms.append(newAlarm)
        
        
        
        saveToPersistentStore()
        scheduleUserNotifications(for: newAlarm)
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnable: Bool) {
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnable
        saveToPersistentStore()
        
        if !alarm.isEnabled {
            scheduleUserNotifications(for: alarm)
        }
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        alarm.isEnabled.toggle()
        saveToPersistentStore()
        
        if alarm.isEnabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        self.alarms.remove(at: index)
        
        CoreDataStack.context.delete(alarm)
        saveToPersistentStore()
        cancelUserNotifications(for: alarm)
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print(error)
        }
        
    }
}
