//
//  SubSegment.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import SwiftUI

/// 주문 화면에서 음료, 푸드, 상품 등의 하위 카테고리를 선택하는 세그먼트 뷰입니다.
/// - 선택된 세그먼트는 강조 색상으로 표시되며,
/// - 각 항목에는 'new' 뱃지 이미지가 함께 표시됩니다.
struct OrderSubSegment: View {
    
    // MARK: - Property
    
    /// 현재 선택된 하위 세그먼트 타입을 외부와 바인딩
    @Binding var subSegmentType: SubSegmentType
    
    // MARK: - Constants
    
    /// 레이아웃 및 스타일 관련 상수 정의
    fileprivate enum OrderSubSegmentConstants {
        static let hstackSpacing: CGFloat = 2              // 세그먼트 버튼 간 간격
        static let topPadding: CGFloat = 18                // 버튼 상단 여백
        static let bottomPadding: CGFloat = 12             // 버튼 하단 여백
        static let horizontalPadding: CGFloat = 6          // 버튼 좌우 여백
        static let leftSpacer: CGFloat = 23                // 전체 왼쪽 여백
        static let rightSpacer: CGFloat = 243              // 전체 오른쪽 여백 (레이아웃 조정)
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
                .subSegmentShadow() // 사용자 정의 섀도우 modifier
        }
    }
    
    /// 모든 하위 세그먼트를 HStack으로 나열
    private var titleSegment: some View {
        HStack(spacing: OrderSubSegmentConstants.hstackSpacing, content: {
            ForEach(SubSegmentType.allCases, id: \.rawValue) { segment in
                segmentButton(segment)
            }
        })
    }
    
    /// 각 세그먼트 버튼 구성
    private func segmentButton(_ segment: SubSegmentType) -> some View {
        Button(action: {
            // 선택 동작이 아닌 로그만 출력 (필요시 상태 갱신 추가 가능)
            print(segment.rawValue)
        }, label: {
            HStack(spacing: .zero, content: {
                Text(segment.rawValue)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(
                        subSegmentType == segment ? .black01 : .gray04
                    )
                Image(.new) // 'new' 뱃지 아이콘
            })
        })
        .contentShape(Rectangle()) // 터치 영역 확장
        .padding(.top, OrderSubSegmentConstants.topPadding)
        .padding(.bottom, OrderSubSegmentConstants.bottomPadding)
        .padding(.horizontal, OrderSubSegmentConstants.horizontalPadding)
    }
}

#Preview {
    // 미리보기: beverages(음료)가 선택된 상태
    OrderSubSegment(subSegmentType: .constant(.beverages))
}
