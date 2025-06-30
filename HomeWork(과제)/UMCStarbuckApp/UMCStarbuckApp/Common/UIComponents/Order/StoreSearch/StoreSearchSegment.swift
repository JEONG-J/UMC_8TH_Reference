//
//  StoreSearchSegment.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/25/25.
//

import SwiftUI

struct StoreSearchSegment: View {
    // MARK: - Property
    @Binding var storeSearchType: StoreSearchType
    
    // MARK: - Constants
    fileprivate enum StoreSearchConstants {
        static let hstackSpacing: CGFloat = 10
        static let dividerWidth: CGFloat = 12
        static let dividerHeight: CGFloat = 1
        static let rotationDegress: Double = 90
    }
    
    // MARK: - Init
    init(storeSearchType: Binding<StoreSearchType>) {
        self._storeSearchType = storeSearchType
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: StoreSearchConstants.hstackSpacing, content: {
            ForEach(Array(StoreSearchType.allCases.enumerated()), id: \.offset) { index, type in
                title(type)
                
                if index != StoreSearchType.allCases.count - 1 {
                    Divider()
                        .frame(width: StoreSearchConstants.dividerWidth, height: StoreSearchConstants.dividerHeight)
                        .background(Color.gray02)
                        .rotationEffect(.degrees(StoreSearchConstants.rotationDegress))
                }
            }
        })
    }
    
    private func title(_ type: StoreSearchType) -> some View {
        Button(action: {
            storeSearchType = type
        }, label: {
            Text(type.rawValue)
                .font(storeSearchType == type ? .mainTextSemiBold13 : .mainTextRegular13)
                .foregroundStyle(storeSearchType == type ? .black03 : .gray03)
        })
    }
}

#Preview {
    StoreSearchSegment(storeSearchType: .constant(.favoriteStore))
}
