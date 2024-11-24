//
//  ActivityManager.swift
//  EcoStep
//
//  Created by admin on 2024/11/20.
//

import Foundation
import CoreData
import UIKit

//class ActivityManager {
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    
//    func saveActivity(type: String, distance: Double) {
//        let activity = Activity(context: context)
//        activity.type = type
//        activity.distance = distance
//        activity.date = Date()
//        do {
//            try context.save()
//        } catch {
//            print("Failed to save activity: \(error)")
//        }
//    }
//
//    func fetchActivities() -> [Activity] {
//        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
//        do {
//            return try context.fetch(request)
//        } catch {
//            print("Failed to fetch activities: \(error)")
//            return []
//        }
//    }
//}
