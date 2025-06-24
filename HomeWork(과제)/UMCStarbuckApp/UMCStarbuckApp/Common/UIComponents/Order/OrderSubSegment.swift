//
//  SubSegment.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import SwiftUI

struct OrderSubSegment: View {
    
    // MARK: - Property
    @Binding var subSegmentType: SubSegmentType
    
    fileprivate enum OrderSubSegmentConstants {
        static let hstackSpacing: CGFloat = 2
        static let topPadding: CGFloat = 18
        static let bottomPadding: CGFloat = 12
        static let horizontalPadding: CGFloat = 6
        static let leftSpacer: CGFloat = 23
        static let rightSpacer: CGFloat = 243
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: .zero, content: {
            HStack {
                Spacer().frame(maxWidth: OrderSubSegmentConstants.leftSpacer)
                titleSegment
                Spacer().frame(maxWidth: OrderSubSegmentConstants.rightSpacer)
            }
        })
        .background {
            Rectangle()
                .fill(Color.white)
                .subSegmentShadow()
        }
    }
    
    private var titleSegment: some View {
        HStack(spacing: OrderSubSegmentConstants.hstackSpacing, content: {
            ForEach(SubSegmentType.allCases, id: \.rawValue) { segment in
                segmentButton(segment)
            }
        })
    }
    
    private func segmentButton(_ segment: SubSegmentType) -> some View {
        Button(action: {
            print(segment.rawValue)
        }, label: {
            HStack(spacing: .zero, content: {
                Text(segment.rawValue)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(subSegmentType == segment ? .black01 : .gray04)
                Image(.new)
            })
        })
        .contentShape(Rectangle())
        .padding(.top, OrderSubSegmentConstants.topPadding)
        .padding(.bottom, OrderSubSegmentConstants.bottomPadding)
        .padding(.horizontal, OrderSubSegmentConstants.horizontalPadding)
    }
}

#Preview {
    OrderSubSegment(subSegmentType: .constant(.beverages))
}
