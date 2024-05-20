//
//  MyList+CoreDataProperties.swift
//  RemindersApp
//
//  Created by Santanu Agarwal on 18/05/24.
//

import Foundation
import CoreData
import UIKit

extension MyList {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }
    @NSManaged public var name: String
    @NSManaged public var color: UIColor
}

extension MyList: Identifiable {
}
// MARK: Generated accessors for notes
extension MyList {
}
