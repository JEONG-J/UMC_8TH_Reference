//
//  StoreSelectSheetViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import Foundation
import CoreLocation

@Observable
class StoreSelectSheetViewModel {
    // MARK: - Property
    var textSearch: String = ""
    var storeSearchType: StoreSearchType = .nearStore
    var storeList: [Feature] = []
    var googleStoreImageUrl: String?
    
    let locationManager: LocationManager = .shared
    let userDistanceKm: Double = 10_000
    
    // MARK: - Method
    public func loadStore()  {
        guard let userLocation = locationManager.currentLocation else {
            print("현재 위치 가져올 수 없어요!")
            return
        }
        
        guard let features = loadFeatureJSON() else {
            print("GeoJSON 파싱 실패")
            return
        }
        
        let filtered = features
            .filter { feature in
                let storeLocation: CLLocation = .init(latitude: feature.properties.latitude, longitude: feature.properties.longitude)
                return userLocation.distance(from: storeLocation) <= userDistanceKm
            }
            .sorted(by: { lhs, rhs in
                let lhsLoc: CLLocation = .init(latitude: lhs.properties.latitude, longitude: lhs.properties.longitude)
                let rhsLoc: CLLocation = .init(latitude: rhs.properties.latitude, longitude: rhs.properties.longitude)
                return userLocation.distance(from: lhsLoc) < userLocation.distance(from: rhsLoc)
            })
        self.storeList = filtered
    }
    
    private func loadFeatureJSON() -> [Feature]? {
        guard let url = Bundle.main.url(forResource: "Starbucks", withExtension: "geojson"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        do {
            let geoJSON = try JSONDecoder().decode(StarbucksItem.self, from: data)
            return geoJSON.features
        } catch {
            print("GeoJSON 디코딩 실패", error.localizedDescription)
            return nil
        }
    }
}
