//
//  waitForCurrentLocation.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/29/25.
//

import Foundation
import CoreLocation

extension LocationManager {
    func waitForCurrentLocation(timeout: TimeInterval = 10) async -> CLLocation? {
        let start = Date()
        while currentLocation == nil {
            try? await Task.sleep(nanoseconds: 300_000_000) // 0.3초 기다림
            if Date().timeIntervalSince(start) > timeout {
                return nil
            }
        }
        return currentLocation
    }
}
