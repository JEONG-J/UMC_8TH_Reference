//
//  MapViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/26/25.
//

import MapKit
import SwiftUI

@MainActor
@Observable
class MapViewModel {
    var hasInitializedMap: Bool = false
    var hasDraggedMap: Bool = false
    
    var previousCameraCenter: CLLocationCoordinate2D?
    var filteredStores: [Feature] = []
    var allStores: [Feature] = []
    
    var visibleRegion: MKCoordinateRegion? = nil
    var cameraPosition: MapCameraPosition
    
    var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
        self.cameraPosition = MapViewModel.moveToCurrentLocation()
    }
    
    // MARK: - Static Method
    static func moveToCurrentLocation() -> MapCameraPosition {
        guard let coordinate = LocationManager.shared.currentLocation?.coordinate else {
            return .automatic
        }

        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 800, longitudinalMeters: 800
        )
        return .region(region)
    }
    
    // MARK: - Map Method
    func loadStores() async {
        await container.actorService.storeDataManager.loadAllStores()
        self.allStores = await container.actorService.storeDataManager.allStores
    }
    
    func searchFilterStore() async {
        if let userLocation = LocationManager.shared.currentLocation {
            let nearby = await container.actorService.storeDataManager.nearbyStores(userLocation: userLocation)
            filteredStores = nearby
        }
    }
    
    func enterTheMapSearch(_ center: CLLocationCoordinate2D?) async {
        guard let center = center else { return }
        let userCL = CLLocation(latitude: center.latitude, longitude: center.longitude)

        filteredStores = allStores.filter {
            let storeLoc = CLLocation(latitude: $0.properties.latitude, longitude: $0.properties.longitude)
            return userCL.distance(from: storeLoc) <= 5000
        }
    }
    
    func mapCameraChange(_ region: MKCoordinateRegion) {
        let currentCenter = region.center
        visibleRegion = region

        guard hasInitializedMap else {
            hasInitializedMap = true
            previousCameraCenter = currentCenter
            return
        }

        if let previous = previousCameraCenter {
            let distance = CLLocation(latitude: previous.latitude, longitude: previous.longitude)
                .distance(from: CLLocation(latitude: currentCenter.latitude, longitude: currentCenter.longitude))

            if distance > 50 {
                hasDraggedMap = true
            }
        }

        previousCameraCenter = currentCenter
    }
}

extension MKCoordinateRegion {
    func contains(_ coordinate: CLLocationCoordinate2D) -> Bool {
        let minLat = center.latitude - span.latitudeDelta / 2
        let maxLat = center.latitude + span.latitudeDelta / 2
        let minLng = center.longitude - span.longitudeDelta / 2
        let maxLng = center.longitude + span.longitudeDelta / 2
        
        return (minLat...maxLat).contains(coordinate.latitude) &&
               (minLng...maxLng).contains(coordinate.longitude)
    }
}
