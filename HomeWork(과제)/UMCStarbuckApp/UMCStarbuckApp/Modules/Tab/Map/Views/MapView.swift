//
//  MapView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/26/25.
//
import SwiftUI
import MapKit

/// Starbucks 매장을 지도로 보여주는 Map 화면입니다.
struct MapView: View {
    
    // MARK: - Property
    
    /// 지도와 관련된 상태 및 로직을 관리하는 뷰모델입니다.
    @State var viewModel: MapViewModel
    
    /// MapKit에서 사용되는 네임스페이스로, 사용자 위치 버튼 등의 scope 설정에 사용됩니다.
    @Namespace var mapScope
    
    // MARK: - Constant
    
    /// 뷰에 사용되는 다양한 UI 상수들을 모아둔 enum입니다.
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
    
    /// DIContainer를 통해 ViewModel을 초기화합니다.
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    // MARK: - Body
    
    var body: some View {
        Map(position: $viewModel.cameraPosition, scope: mapScope) {
            // 사용자 현재 위치 표시
            UserAnnotation()
            
            // 매장 위치에 annotation 표시
            ForEach(viewModel.filteredStores, id: \.id) { store in
                Annotation(store.properties.storeName,
                           coordinate: .init(latitude: store.properties.latitude, longitude: store.properties.longitude)) {
                    Image(.starbuckMark)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        
        // 기본 제공 사용자 위치 버튼 표시
        .mapControls {
            MapUserLocationButton(scope: mapScope)
        }
        
        // 지도 스타일 설정 (일반 지도)
        .mapStyle(.standard)
        
        // 지도 위치가 변경될 때 뷰모델에게 위치 정보 전달
        .onMapCameraChange { context in
            viewModel.mapCameraChange(context.region)
        }
        
        // 지도 이동 시 '이 지역 검색' 버튼 표시
        .overlay(alignment: .top, content: {
            if viewModel.hasDraggedMap {
                mapSearchButton
            }
        })
        
        // 뷰가 나타날 때 실행할 초기 작업
        .task {
            if let loc = await LocationManager.shared.waitForCurrentLocation() {
                await viewModel.loadStores() // 전체 매장 로드
                await viewModel.enterTheMapSearch(loc.coordinate) // 해당 위치 기준 필터링
                viewModel.visibleRegion = .init(center: loc.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                viewModel.visibleRegion = nil
            }
        }
    }
    
    /// 지도가 이동된 경우 나타나는 '이 지역 검색' 버튼
    private var mapSearchButton: some View {
        Button(action: {
            Task {
                await viewModel.searchFilterStore() // 현재 카메라 위치 기준으로 매장 필터링
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
