//
//  HealthKitManager.swift
//  EcoStep
//
//  Created by admin on 2024/11/19.
//

import Foundation
import HealthKit

class HealthKitManager {
    let healthStore = HKHealthStore()
    
    // 请求授权
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let typesToShare: Set<HKSampleType> = []
        let typesToRead: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
            HKObjectType.quantityType(forIdentifier: .stepCount)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead, completion: completion)
    }
    
    // 查询活动数据
    func fetchActivityData(for identifier: HKQuantityTypeIdentifier, startDate: Date, endDate: Date, completion: @escaping (Double) -> Void) {
        guard let sampleType = HKSampleType.quantityType(forIdentifier: identifier) else { return }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        
        let query = HKStatisticsQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0)
                return
            }
            
            let unit: HKUnit = identifier == .stepCount ? HKUnit.count() : HKUnit.meter()
            completion(sum.doubleValue(for: unit))
        }
        healthStore.execute(query)
    }
}
