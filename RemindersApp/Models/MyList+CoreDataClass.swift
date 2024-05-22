//
//  MyList+CoreDataClass.swift
//  RemindersApp
//
//  Created by Santanu Agarwal on 18/05/24.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    
    var remindersArray: [Reminder] {
        reminders.allObjects.compactMap{ ($0 as? Reminder) }
    }
}
