//
//  SearchResult.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import SwiftUI

/// 검색 결과를 표시하는 카드 형태의 뷰입니다.
/// - 장소 이름(name)과 주소(address)를 수직으로 나열하여 간결하게 보여줍니다.
/// - 예: 매장 검색, 위치 검색 결과 목록에서 사용
struct SearchResultCard: View {
    
    // MARK: - Property
    
    /// 표시할 검색 결과 데이터 (이름 + 주소 포함)
    var searchResult: SearchResult
    
    // MARK: - Constants
    
    /// 내부 레이아웃 상수를 정의하는 enum
    fileprivate enum SearchResultConstants {
        /// 텍스트 사이 수직 간격
        static let vSpacing: CGFloat = 8
        static let height: CGFloat = 43
    }
    
    // MARK: - Init
    
    /// 외부에서 검색 결과 데이터를 주입받는 초기화 메서드
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .leading, content: {
            Color.white
                .frame(maxWidth: .infinity, maxHeight: SearchResultConstants.height)
            
            VStack(
                alignment: .leading,
                spacing: SearchResultConstants.vSpacing,
                content: {
                    // 장소 이름
                    Text(searchResult.name)
                        .font(.mainTextMedium16)
                        .foregroundStyle(Color.black)
                    
                    // 장소 주소
                    Text(searchResult.address)
                        .font(.mainTextMedium13)
                        .foregroundStyle(Color.gray04)
                }
            )
        })
    }
}
