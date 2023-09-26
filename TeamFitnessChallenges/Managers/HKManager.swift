//
//  HKManager.swift
//  TeamFitnessChallenges
//
//  Created by Jose Blanco on 9/25/23.
//

import Foundation
import HealthKit

class HKManager {
    var healthStore: HKHealthStore?
    
    init() {
        checkHealthStoreAvailability()
    }
    
    func checkHealthStoreExists() -> Bool {
        if let store = healthStore {
            return true
        } else {
            return false
        }
    }
    
    private func checkHealthStoreAvailability() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    
    
    
    
}
