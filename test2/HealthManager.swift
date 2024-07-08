//
//  HealthManager.swift
//  test2
//
//  Created by Michelle Hou on 7/7/24.
//

import Foundation
import HealthKit

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    init() {
        let steps = HKQuantityType(.stepCount)
        
        let healthTypes: Set = [steps]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print("error fetching heath data")
            }
        }
    }
    
    func fetchTodaySteps() {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate){
            _, result, error in guard let quantity = result?.sumQuantity(), error == nil else{
                print("error fetch today's step data")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            print(stepCount)
        }
        healthStore.execute(query)
    }
}
