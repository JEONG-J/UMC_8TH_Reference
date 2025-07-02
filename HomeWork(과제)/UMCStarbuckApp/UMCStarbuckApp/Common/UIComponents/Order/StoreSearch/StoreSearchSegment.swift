//
//  StoreSearchSegment.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/25/25.
//

import SwiftUI

/// 매장 검색 유형을 선택할 수 있는 커스텀 세그먼트 뷰입니다.
/// - 예: [ 가까운 매장 | 자주 가는 매장 ] 형태
/// - 선택된 항목은 강조 스타일로 표시되며,
/// - 항목 사이에는 세로 회전된 Divider로 구분됩니다.
struct StoreSearchSegment: View {
    
    // MARK: - Property
    
    /// 현재 선택된 매장 검색 타입 (Binding으로 외부와 상태 공유)
    @Binding var storeSearchType: StoreSearchType
    
    // MARK: - Constants
    
    /// 세그먼트 레이아웃 및 스타일 관련 상수 정의
    fileprivate enum StoreSearchConstants {
        static let hstackSpacing: CGFloat = 10              // 항목 간 간격
        static let dividerWidth: CGFloat = 12               // Divider의 너비 (회전 전 기준)
        static let dividerHeight: CGFloat = 1               // Divider의 높이 (회전 전 기준)
        static let rotationDegress: Double = 90             // Divider 회전 각도 (세로선처럼 보이게)
    }
    
    // MARK: - Init
    
    /// 외부에서 선택된 타입을 주입받는 초기화 메서드
    init(storeSearchType: Binding<StoreSearchType>) {
        self._storeSearchType = storeSearchType
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: StoreSearchConstants.hstackSpacing, content: {
            // StoreSearchType 열거형을 인덱스와 함께 순회
            ForEach(Array(StoreSearchType.allCases.enumerated()), id: \.offset) { index, type in
                // 각 항목 버튼
                title(type)
                
                // 마지막 항목 뒤에는 Divider를 넣지 않음
                if index != StoreSearchType.allCases.count - 1 {
                    Divider()
                        .frame(
                            width: StoreSearchConstants.dividerWidth,
                            height: StoreSearchConstants.dividerHeight
                        )
                        .background(Color.gray02)
                        .rotationEffect(.degrees(StoreSearchConstants.rotationDegress))
                }
            }
        })
    }
    
    /// 세그먼트 항목 버튼을 생성
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
    // 프리뷰: "자주 가는 매장"이 선택된 상태로 세그먼트 표시
    StoreSearchSegment(storeSearchType: .constant(.favoriteStore))
}
