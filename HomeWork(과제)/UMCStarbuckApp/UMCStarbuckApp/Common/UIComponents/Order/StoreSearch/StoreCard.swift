//
//  StoreCard.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/25/25.
//

import SwiftUI
import Kingfisher
import CoreLocation

struct StoreCard: View {
    
    // MARK: - Property
    let store: Propertie
    let imageUrlStirng: String?
    
    // MARK: - Constants
    fileprivate enum StoreCardConstant {
        static let mainHstackSpacing: CGFloat = 16
        static let mainVstackSpacing: CGFloat = 15

        static let topVstackSpacing: CGFloat = 4
        static let categorySpacing: CGFloat = 4
        static let maxCount: Int = 2
        static let timeInterval: TimeInterval = 2
        static let imageWidth: CGFloat = 83
        static let imageHeight: CGFloat = 83
        
        static let mapName: String = "location.slash.circle.fill"
    }

    // MARK: - Init
    init (store: Propertie, imageUrlStirng: String?) {
        self.store = store
        self.imageUrlStirng = imageUrlStirng
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: StoreCardConstant.mainHstackSpacing, content: {
            storeAPIImage
            VStack(alignment: .leading, spacing: StoreCardConstant.mainVstackSpacing, content: {
                topContents
                bottomContents
            })
        })
    }
    
    // MARK: - Contents
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
    
    private func loadImage(url: URL) -> some View {
        KFImage(url)
            .placeholder({
                ProgressView()
            }).retry(maxCount: StoreCardConstant.maxCount, interval: .seconds(StoreCardConstant.timeInterval))
            .downsampling(size: .init(width: StoreCardConstant.imageWidth, height: StoreCardConstant.imageHeight))
            .cacheMemoryOnly()
            .resizable()
    }
    
    private var noImage: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .stroke(Color.gray07, style: .init())
            
            Image(systemName: StoreCardConstant.mapName)
        }
    }
    
    // MARK: - TopContents
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
    private var bottomContents: some View {
        HStack(alignment: .firstTextBaseline, content: {
            bottomMark
            Spacer()
            distanceKm
        })
    }
    
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
    StoreCard(store: .init(seq: "962", storeName: "대구수성네거리", address: "대구광역시 수성구 들안로 342 (수성동4가)", telephone: "1522-3232", category: .dt, latitude: 35.86058, longitude: 128.617977), imageUrlStirng: "")
}
