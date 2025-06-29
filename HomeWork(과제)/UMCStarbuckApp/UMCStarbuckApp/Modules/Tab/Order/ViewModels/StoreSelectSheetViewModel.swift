//
//  StoreSelectSheetViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import Foundation
import CoreLocation
import SwiftUI

@Observable
class StoreSelectSheetViewModel {
    // MARK: - Property
    var textSearch: String = ""
    var storeSearchType: StoreSearchType = .nearStore
    var allStores: [Feature] = []
    var storeList: [Feature] = []
    var googleStoreImageUrl: String?
    
    let locationManager: LocationManager = .shared
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - ShowProperty
    var isLoading: Bool = false
    
    // MARK: - Method
    @MainActor
    public func getAllStores() async {
        isLoading = true
        await container.actorService.storeDataManager.loadAllStores()
        allStores = await container.actorService.storeDataManager.allStores
        isLoading = false
    }
    
    @MainActor
    public func nearByStores() async {
        guard let userLocaton = locationManager.currentLocation else {
            print("현재 위치 정보 없음")
            return
        }
        isLoading = true
        let result = await container.actorService.storeDataManager.nearbyStores(userLocation: userLocaton)
        storeList = result
        isLoading = false
    }
    
    
}
