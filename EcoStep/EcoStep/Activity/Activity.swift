//
//  Activity.swift
//  EcoStep
//
//  Created by admin on 2024/11/20.
//

import Foundation
import CoreData

@objc(Activity)
public class Activity: NSManagedObject {
    @NSManaged public var date: Date
    @NSManaged public var distance: Double
    @NSManaged public var type: String
}

extension Activity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }
}

extension Activity : Identifiable {}

