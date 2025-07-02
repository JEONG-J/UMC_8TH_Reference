//
//  Segment.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import Foundation
import SwiftUI

/// 범용 커스텀 세그먼트 뷰
/// `SegmentAttr` 프로토콜을 따르는 열거형을 기반으로 세그먼트 UI를 구성하며,
/// `CustomSegmentStyle`을 통해 스타일을 자유롭게 지정할 수 있습니다.
struct CustomSegment<T: SegmentAttr & CaseIterable, Style: CustomSegmentStyle>: View {
    
    // MARK: - Property
    
    /// 각 세그먼트의 텍스트 폭을 저장하는 딕셔너리
    @State private var segmentWidth: [T: CGFloat] = [:]
    
    /// 현재 선택된 세그먼트 항목 (외부에서 바인딩으로 주입)
    @Binding var selectedSegment: T
    
    /// `matchedGeometryEffect`에 사용되는 네임스페이스
    @Namespace var name
    
    /// 스타일 객체 (색상, 간격 등 스타일 속성 정의)
    let style: Style
    
    /// 애니메이션 지속 시간
    let duration: TimeInterval = 0.4
    
    /// 배경 사각형 높이
    let segmentBackgroundHeight: CGFloat = 50
    
    /// `matchedGeometryEffect`에서 사용할 ID
    let segmentId: String = "Tab"
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: style.segmentHSpacing, content: {
            let segments = Array(T.allCases)
            
            ForEach(segments.indices, id: \.self) { index in
                let segment = segments[index]
                
                // 세그먼트 버튼 터치 시 애니메이션 적용
                Button(action: {
                    withAnimation(.easeInOut(duration: duration)) {
                        selectedSegment = segment
                    }
                }, label: {
                    makeSegmentButton(segment: segment)
                })
            }
        })
        // 세그먼트 전체 배경 표시 여부
        .background {
            if style.showSegmentBackground {
                backgroundRectangle
            }
        }
        // 세그먼트 너비 정보가 업데이트되면 저장
        .onPreferenceChange(SegmentWidthPreferenceKey.self) { newValue in
            for (key, width) in newValue {
                if let typedKey = key as? T {
                    segmentWidth[typedKey] = width
                }
            }
        }
    }
    
    /// 세그먼트 전체 배경 사각형
    private var backgroundRectangle: some View {
        Rectangle()
            .fill(Color.white)
            .segmentShadow()
    }
    
    // MARK: - Method
    
    /// 세그먼트 버튼 하나를 구성하는 메서드
    @ViewBuilder
    private func makeSegmentButton(segment: T) -> some View {
        VStack(alignment: .center, spacing: style.segmentVSpacing, content: {
            segmentIndivisal(segment: segment)
            
            ZStack(alignment: .bottom, content: {
                // 배경 캡슐 (비활성화 상태)
                Capsule()
                    .fill(Color.clear)
                    .frame(width: segmentWidth[segment] ?? .zero, height: style.segmentHeight)
                
                // 선택된 세그먼트에 대한 강조 캡슐
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
    
    /// 세그먼트 제목 + 배경 레이어 구성
    private func segmentIndivisal(segment: T) -> some View {
        ZStack {
            if style.showSegmentBackground {
                segmentBackground
            }
            segmentTitle(segment: segment)
        }
        // 너비 계산을 위한 GeometryReader
        .background(
            GeometryReader { geo in
                Color.clear
                    .preference(
                        key: SegmentWidthPreferenceKey.self,
                        value: [AnyHashable(segment): geo.size.width])
            }
        )
    }
    
    /// 세그먼트 배경 뷰
    private var segmentBackground: some View {
        Rectangle()
            .fill(Color.white)
            .frame(height: segmentBackgroundHeight)
    }
    
    /// 세그먼트 제목 및 선택 상태별 스타일 적용
    @ViewBuilder
    private func segmentTitle(segment: T) -> some View {
        let isCakeMenu = (segment as? OrderSegment) == .cakeMenu
        let isSelected = selectedSegment == segment
        let isFirst = segment == T.allCases.first
        
        let fontColor: Color = isCakeMenu ? .green01 : (isSelected ? .black01 : .gray04)
        let paddings = style.horizontalPadding(segment: segment, isFirst: isFirst)
        
        HStack(spacing: .zero) {
            // 케이크 아이템이면 아이콘 추가
            if isCakeMenu {
                Image(.cake)
            }
            
            Text(segment.segmentTitle)
                .font(segment.segmentFont)
                .foregroundStyle(fontColor)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.leading, paddings.0)
        .padding(.trailing, paddings.1)
    }
}

/// 세그먼트 항목 너비를 추적하기 위한 PreferenceKey
fileprivate struct SegmentWidthPreferenceKey: PreferenceKey {
    static var defaultValue: [AnyHashable: CGFloat] = [:]
    
    static func reduce(value: inout [AnyHashable: CGFloat], nextValue: () -> [AnyHashable: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

/// CustomSegment의 프리뷰를 위한 래퍼 뷰
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
