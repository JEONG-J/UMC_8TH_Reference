//
//  TopStatusBar.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI

/// 상단 고정 상태 표시줄 뷰입니다.
/// - 좌측에 타이틀(`Other`)을, 우측에는 로그아웃 아이콘을 표시합니다.
/// - 보통 '기타' 탭과 같은 독립 화면에서 상단 UI로 사용됩니다.
struct TopStatusBar: View {
    
    // MARK: - Constants
    
    /// TopStatusBar에 사용되는 레이아웃 및 텍스트 상수를 정의한 내부 열거형
    fileprivate enum TopStatusBarConstants {
        /// 중앙에 표시될 타이틀 텍스트
        static let title: String = "Other"
        
        /// 좌우 여백
        static let horizontalPadding: CGFloat = 24
        
        /// 하단 여백 (상단 바가 붙어 있지 않도록 여유 공간 확보)
        static let bottomPadding: CGFloat = 16
        
        /// 상태 바 전체 높이
        static let height: CGFloat = 120
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            Color.white             // 배경색
            contents                // 내부 콘텐츠 뷰 (타이틀 + 아이콘)
        })
        .frame(height: TopStatusBarConstants.height) // 고정 높이 설정
    }
    
    /// 상태 바 내부의 좌우 콘텐츠 구성
    private var contents: some View {
        HStack {
            // 좌측 타이틀 텍스트
            Text(TopStatusBarConstants.title)
                .font(.mainTextBold24)
                .foregroundStyle(Color.black)
            
            Spacer()
            
            // 우측 로그아웃 아이콘
            Image(.logOut)
        }
        // 안전 영역을 고려한 패딩 설정
        .safeAreaPadding(.horizontal, TopStatusBarConstants.horizontalPadding)
        .safeAreaPadding(.bottom, TopStatusBarConstants.bottomPadding)
    }
}
