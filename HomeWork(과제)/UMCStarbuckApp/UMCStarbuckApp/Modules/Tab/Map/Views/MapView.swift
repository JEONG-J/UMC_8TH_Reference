//
//  MapView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/26/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    // MARK: - Property
    @State var viewModel: MapViewModel
    @Namespace var mapScope
    
    // MARK: - Constant
    fileprivate enum MapConstants {
        static let moveDistance: CLLocationDistance = 20
        static let searchButtonTopOffset: CGFloat = 22
        static let searchButtonVerticalPadding: CGFloat = 10
        static let searchButtonHorizonPadding: CGFloat = 14
        static let corenrRadius: CGFloat = 20
        
        static let currentButtonImageSize: CGFloat = 20
        static let currentLocationButtonPadding: CGFloat = 15
        static let currentLocatoinButtonXOffset: CGFloat = 27
        static let searchButtonText: String = "이 지역 검색"
    }
    
    // MARK: - Init
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    // MARK: - Body
    var body: some View {
        Map(position: $viewModel.cameraPosition, scope: mapScope) {
            UserAnnotation()
            
            ForEach(viewModel.filteredStores, id: \.id) { store in
                Annotation(store.properties.storeName,
                           coordinate: .init(latitude: store.properties.latitude, longitude: store.properties.longitude)) {
                    Image(.starbuckMark)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .mapControls {
            MapUserLocationButton(scope: mapScope)
        }
        .mapStyle(.standard)
        .onMapCameraChange { context in
            viewModel.mapCameraChange(context.region)
        }
        .overlay(alignment: .top, content: {
            if viewModel.hasDraggedMap {
                mapSearchButton
            }
        })
        .task {
            if let loc = await LocationManager.shared.waitForCurrentLocation() {
                await viewModel.loadStores()
                await viewModel.enterTheMapSearch(loc.coordinate)
                viewModel.visibleRegion = .init(center: loc.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                viewModel.visibleRegion = nil
            }
        }
    }
    
    private var mapSearchButton: some View {
        Button(action: {
            Task {
             await viewModel.searchFilterStore()
            }
        }, label: {
            Text(MapConstants.searchButtonText)
                .font(.mainTextMedium13)
                .foregroundStyle(Color.gray06)
                .padding(.vertical, MapConstants.searchButtonVerticalPadding)
                .padding(.horizontal, MapConstants.searchButtonHorizonPadding)
                .background {
                    RoundedRectangle(cornerRadius: MapConstants.corenrRadius)
                        .fill(Color.white)
                        .mapButtonShadow()
                }
        })
        .offset(y: MapConstants.searchButtonTopOffset)
    }
}
