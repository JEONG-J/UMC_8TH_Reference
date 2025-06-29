//
//  StoreDataManager.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/26/25.
//

import Foundation
import CoreLocation

actor StoreDataManager {
    private(set) var allStores: [Feature] = []
    
    public func loadAllStores() async {
        guard let url = Bundle.main.url(forResource: "Starbucks", withExtension: "geojson"),
              let data = try? Data(contentsOf: url) else {
            print("GeoJSON 파일을 찾을 수 없습니다.")
            return
        }
        
        do {
            let geoJSON = try JSONDecoder().decode(StarbucksItem.self, from: data)
            self.allStores = geoJSON.features
        } catch {
            print("GeoJSON 디코딩 실패:", error.localizedDescription)
        }
    }
    
    public func nearbyStores(userLocation: CLLocation, distanceKm: Double = 10_000) -> [Feature] {
        return allStores
            .filter { store in
                let loc = CLLocation(latitude: store.properties.latitude,
                                     longitude: store.properties.longitude)
                return userLocation.distance(from: loc) <= distanceKm
            }
            .sorted { lhs, rhs in
                let lhsLoc = CLLocation(latitude: lhs.properties.latitude, longitude: lhs.properties.longitude)
                let rhsLoc = CLLocation(latitude: rhs.properties.latitude, longitude: rhs.properties.longitude)
                return userLocation.distance(from: lhsLoc) < userLocation.distance(from: rhsLoc)
            }
    }
    
}
