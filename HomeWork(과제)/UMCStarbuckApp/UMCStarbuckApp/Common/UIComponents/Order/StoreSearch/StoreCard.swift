//
//  StoreCard.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/25/25.
//

import SwiftUI
import Kingfisher
import CoreLocation

/// 하나의 매장 정보를 카드 형태로 보여주는 컴포넌트입니다.
/// - 좌측에는 매장 이미지 또는 기본 아이콘
/// - 우측에는 매장명, 주소, 카테고리 아이콘, 거리 정보 등을 포함
struct StoreCard: View {
    
    // MARK: - Property
    
    /// 매장 기본 정보
    let store: Propertie
    
    /// 외부에서 주어지는 이미지 URL 문자열 (옵션)
    let imageUrlStirng: String?
    
    // MARK: - Constants
    
    /// 레이아웃 및 이미지 관련 상수를 내부 열거형으로 관리
    fileprivate enum StoreCardConstant {
        static let mainHstackSpacing: CGFloat = 16
        static let mainVstackSpacing: CGFloat = 15

        static let topVstackSpacing: CGFloat = 4
        static let categorySpacing: CGFloat = 4
        static let maxCount: Int = 2
        static let timeInterval: TimeInterval = 2
        static let imageWidth: CGFloat = 83
        static let imageHeight: CGFloat = 83
        
        static let cornerRadius: CGFloat = 6
        
        /// 기본 이미지로 사용할 SF Symbol 이름
        static let mapName: String = "location.slash.circle.fill"
    }

    // MARK: - Init
    
    /// StoreCard 초기화 메서드
    init(store: Propertie, imageUrlStirng: String?) {
        self.store = store
        self.imageUrlStirng = imageUrlStirng
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: StoreCardConstant.mainHstackSpacing, content: {
            storeAPIImage                 // 좌측 이미지 영역
            VStack(alignment: .leading, spacing: StoreCardConstant.mainVstackSpacing, content: {
                topContents              // 매장명 + 주소
                bottomContents           // 카테고리 아이콘 + 거리
            })
        })
    }
    
    // MARK: - Image Section
    
    /// 외부 이미지가 있다면 로드, 없으면 기본 아이콘 표시
    @ViewBuilder
    private var storeAPIImage: some View {
        Group {
            if let imageUrlStirng,
               let url = URL(string: imageUrlStirng) {
                loadImage(url: url)
            } else {
                noImage
            }
        }
        .frame(width: StoreCardConstant.imageWidth, height: StoreCardConstant.imageHeight)
    }
    
    /// Kingfisher를 사용하여 이미지 비동기 로딩
    private func loadImage(url: URL) -> some View {
        KFImage(url)
            .placeholder {
                ProgressView()
            }
            .retry(maxCount: StoreCardConstant.maxCount, interval: .seconds(StoreCardConstant.timeInterval))
            .cacheMemoryOnly()
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: StoreCardConstant.cornerRadius))
    }
    
    /// 이미지가 없을 경우 대체 이미지 표시 (기본 아이콘)
    private var noImage: some View {
        ZStack {
            RoundedRectangle(cornerRadius: StoreCardConstant.cornerRadius)
                .fill(Color.white)
                .stroke(Color.gray07, style: .init())
            
            Image(systemName: StoreCardConstant.mapName)
        }
    }
    
    // MARK: - TopContents
    
    /// 매장명 + 주소를 포함하는 상단 콘텐츠
    private var topContents: some View {
        VStack(alignment: .leading, spacing: StoreCardConstant.topVstackSpacing, content: {
            Text(store.storeName)
                .font(.mainTextSemiBold13)
                .foregroundStyle(Color.black03)
            
            Text(store.address)
                .font(.mainTextMedium10)
                .foregroundStyle(Color.gray02)
        })
    }
    
    // MARK: - BottomContents
    
    /// 하단 카테고리 아이콘 + 거리 정보
    private var bottomContents: some View {
        HStack(alignment: .firstTextBaseline, content: {
            bottomMark     // 카테고리 아이콘들
            Spacer()
            distanceKm     // 거리 텍스트
        })
    }
    
    /// 매장 카테고리에 따른 아이콘 이미지들 표시 (DT, 리저브 등)
    @ViewBuilder
    private var bottomMark: some View {
        if let category = store.category {
            HStack(spacing: StoreCardConstant.categorySpacing, content: {
                ForEach(category.imageResources, id: \.self) { image in
                    Image(image)
                }
            })
        }
    }
    
    /// 현재 위치와 매장 위치 간의 거리 계산 후 표시
    private var distanceKm: some View {
        let storeLocation: CLLocation = .init(latitude: store.latitude, longitude: store.longitude)
        let distanceText: String
        
        if let current = LocationManager.shared.currentLocation {
            let distance = current.distanceKilometers(other: storeLocation)
            distanceText = String(format: "%.1fkm", distance)
        } else {
            distanceText = "거리 측정 불가"
        }
        
        return Text(distanceText)
            .font(.mainTextMedium12)
            .foregroundStyle(Color.black01)
    }
}

#Preview {
    StoreCard(
        store: .init(
            seq: "962",
            storeName: "대구수성네거리",
            address: "대구광역시 수성구 들안로 342 (수성동4가)",
            telephone: "1522-3232",
            category: .dt,
            latitude: 35.86058,
            longitude: 128.617977
        ),
        imageUrlStirng: ""
    )
}
