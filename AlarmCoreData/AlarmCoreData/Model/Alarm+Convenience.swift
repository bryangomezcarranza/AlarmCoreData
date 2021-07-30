//
//  Alarm+Convienienve.swift
//  AlarmCoreData
//
//  Created by Bryan Gomez on 7/29/21.
//

import Foundation
import CoreData

extension Alarm {
    @discardableResult
    convenience init(title: String, isEnabled: Bool = false, fireDate: Date, uuidString: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.isEnabled = isEnabled
        self.fireDate = fireDate
        self.uuidString = uuidString
    }
}
