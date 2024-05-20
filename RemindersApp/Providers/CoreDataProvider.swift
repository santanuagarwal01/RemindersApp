//
//  CoreDataProvider.swift
//  RemindersApp
//
//  Created by Santanu Agarwal on 15/05/24.
//

import CoreData

struct CoreDataProvider {
    static let shared = CoreDataProvider()

    let persistentContainer: NSPersistentContainer
    
    private init() {
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "RemindersModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Init Core Data error - \(error)")
            }
        }
    }
}
