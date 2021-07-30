//
//  CoreDataStack.swift
//  AlarmCoreData
//
//  Created by Bryan Gomez on 7/29/21.
//

import Foundation
import CoreData

enum CoreDataStack {
    static let container: NSPersistentContainer = {
        // create container for app
       let container = NSPersistentContainer(name: "AlarmCoreData")
        //load it
        container.loadPersistentStores { storeDescription, error in
            // if it doesnt exist it will crash app
            if let error = error {
                fatalError("Error loading persistent stores \(error)")
            }
        }
        // return container that was made.
        return container
    }()
    // create context, worksapce.
    static var context: NSManagedObjectContext {
        container.viewContext
    }
    // saving the context.
    static func saveContext() {
        if context.hasChanges { // if it has changes
            do {
                try context.save() // save it
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
