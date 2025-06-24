//
//  Segment.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import Foundation
import SwiftUI

struct CustomSegment<T: SegmentAttr & CaseIterable>: View {
    
    // MARK: - Property
    @State private var segmentWidth: [T: CGFloat] = [:]
    @Binding var selectedSegment: T
    @Namespace var name
    
    let capsuleOffset: CGFloat = 3
    let segmentHeight: CGFloat = 3
    let duration: TimeInterval = 0.4
    
    let firstHorizonPadding: CGFloat = 30
    let secondHrizonPadding: CGFloat = 23
    let verticalPadding: CGFloat = 13
    
    let cakeLeadingPadding: CGFloat = 59
    let cakeTrailingPadding: CGFloat = 27
    
    let segmentBackgroundHeight: CGFloat = 50
    
    let segmentId: String = "Tab"
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: .zero, content: {
            ForEach(Array(T.allCases), id: \.hashValue) { segment in
                Button(action: {
                    withAnimation(.easeInOut(duration: duration)) {
                        selectedSegment = segment
                    }
                }, label: {
                    makeSegmentButton(segment: segment)
                })
            }
        })
        .background {
            backgroundRectangle
        }
        .onPreferenceChange(SegmentWidthPreferenceKey.self) { newValue in
            for (key, width) in newValue {
                if let typedKey = key as? T {
                    segmentWidth[typedKey] = width
                }
            }
        }
    }
    
    private var backgroundRectangle: some View {
        Rectangle()
            .fill(Color.white)
            .segmentShadow()
    }
    
    // MARK: - Method
    private func makeSegmentButton(segment: T) -> some View {
        VStack(alignment: .center, spacing: .zero, content: {
            segmentIndivisal(segment: segment)
            
            ZStack(alignment: .bottom, content: {
                Capsule()
                    .fill(Color.clear)
                    .frame(width: segmentWidth[segment] ?? .zero, height: segmentHeight)
                
                if selectedSegment == segment {
                    Capsule()
                        .fill(Color.green01)
                        .frame(width: segmentWidth[segment] ?? .zero, height: segmentHeight)
                        .matchedGeometryEffect(id: segmentId, in: name)
                }
            })
            .offset(y: capsuleOffset)
        })
    }
    
    private func segmentIndivisal(segment: T) -> some View {
        ZStack {
            segmentBackground
            segmentTitle(segment: segment)
        }
        .background(
            GeometryReader { geo in
                Color.clear
                    .preference(
                        key: SegmentWidthPreferenceKey.self,
                        value: [AnyHashable(segment): geo.size.width])
            }
        )
    }
    
    private var segmentBackground: some View {
        Rectangle()
            .fill(Color.white)
            .frame(height: segmentBackgroundHeight)
    }
    
    @ViewBuilder
    private func segmentTitle(segment: T) -> some View {
        let isCakeMenu = (segment as? OrderSegment) == .cakeMenu
        let isSelected = selectedSegment == segment
        let isFirst = segment == T.allCases.first
        
        let fontColor: Color = isCakeMenu ? .green01 : (isSelected ? .black01 : .gray04)
        let paddings = (segment as? OrderSegment)?.horizontalPadding(isFirst: isFirst) ?? (.zero, .zero)
        
        HStack(spacing: .zero) {
            if isCakeMenu {
                Image(.cake)
            }
            
            Text(segment.segmentTitle)
                .font(.mainTextBold16)
                .foregroundStyle(fontColor)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.leading, paddings.0)
        .padding(.trailing, paddings.1)
    }
}

extension OrderSegment {
    
    func horizontalPadding(isFirst: Bool) -> (leading: CGFloat, trailing: CGFloat) {
        switch self {
        case .cakeMenu:
            return (50, 27)
        default:
            return isFirst ? (30, 30) : (23, 23)
        }
    }
}

fileprivate struct SegmentWidthPreferenceKey: PreferenceKey {
    static var defaultValue: [AnyHashable: CGFloat] = [:]
    
    static func reduce(value: inout [AnyHashable: CGFloat], nextValue: () -> [AnyHashable: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct CustomSegmentPreviewWrapper: View {
    @State private var selectedSegment: OrderSegment = .allMenu
    
    var body: some View {
        CustomSegment<OrderSegment>(selectedSegment: $selectedSegment)
    }
}

#Preview {
    CustomSegmentPreviewWrapper()
}
