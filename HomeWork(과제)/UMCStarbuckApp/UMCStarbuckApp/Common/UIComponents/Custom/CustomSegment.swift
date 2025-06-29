//
//  Segment.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import Foundation
import SwiftUI

struct CustomSegment<T: SegmentAttr & CaseIterable, Style: CustomSegmentStyle>: View {
    
    // MARK: - Property
    @State private var segmentWidth: [T: CGFloat] = [:]
    @Binding var selectedSegment: T
    @Namespace var name
    
    let style: Style
    let duration: TimeInterval = 0.4
    let segmentBackgroundHeight: CGFloat = 50
    let segmentId: String = "Tab"
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: style.segmentHSpacing, content: {
            let segments = Array(T.allCases)
            ForEach(segments.indices, id: \.self) { index in
                let segment = segments[index]
                
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
            if style.showSegmentBackground {
                backgroundRectangle
            }
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
    @ViewBuilder
    private func makeSegmentButton(segment: T) -> some View {
        
        VStack(alignment: .center, spacing: style.segmentVSpacing, content: {
            segmentIndivisal(segment: segment)
            
            ZStack(alignment: .bottom, content: {
                Capsule()
                    .fill(Color.clear)
                    .frame(width: segmentWidth[segment] ?? .zero, height: style.segmentHeight)
                
                if selectedSegment == segment {
                    Capsule()
                        .fill(style.segmentColor)
                        .frame(width: segmentWidth[segment] ?? .zero, height: style.segmentHeight)
                        .matchedGeometryEffect(id: segmentId, in: name)
                }
            })
            .offset(y: style.capsuleOffset)
        })
    }
    
    private func segmentIndivisal(segment: T) -> some View {
        ZStack {
            if style.showSegmentBackground {
                segmentBackground
            }
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
        let paddings = style.horizontalPadding(segment: segment, isFirst: isFirst)
        
        HStack(spacing: .zero) {
            if isCakeMenu {
                Image(.cake)
            }
            
            // TODO: - 폰트 설정 필요, 캡슐 두꼐 필요, Spacing 조절할 것
            Text(segment.segmentTitle)
                .font(segment.segmentFont)
                .foregroundStyle(fontColor)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.leading, paddings.0)
        .padding(.trailing, paddings.1)
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
    @State private var selecteSegmentFind: FindStoreSegment = .findStore
    
    var body: some View {
        CustomSegment<OrderSegment, GreenSegmentStyle>(selectedSegment: $selectedSegment, style: GreenSegmentStyle())
        
        CustomSegment<FindStoreSegment, BrownSegmentStyle>(selectedSegment: $selecteSegmentFind, style: BrownSegmentStyle())
    }
}

#Preview {
    CustomSegmentPreviewWrapper()
}
