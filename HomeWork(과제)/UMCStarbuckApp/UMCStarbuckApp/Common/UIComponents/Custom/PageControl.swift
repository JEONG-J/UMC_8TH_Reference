//
//  PageControl.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

/// 페이지 인디케이터를 표시하는 커스텀 뷰입니다.
/// 현재 페이지를 시각적으로 알려주는 점(dot) 형태의 컨트롤입니다.
/// 예: 온보딩 화면, 배너 슬라이더 등에 사용
struct PageControl: View {
    
    // MARK: - Property
    
    /// 현재 선택된 페이지 인덱스 (외부에서 바인딩으로 주입)
    @Binding var currentPage: Int
    
    /// 전체 페이지 수 (기본값: 2페이지)
    let totalPage: Int = 2
    
    /// 페이지 인디케이터 관련 레이아웃 상수 정의
    fileprivate enum PageControl {
        /// 점(dot)의 크기
        static let dotSize: CGFloat = 8
        
        /// 점(dot) 사이 간격
        static let dotSpacing: CGFloat = 8
    }
    
    // MARK: - Init
    
    /// 외부에서 현재 페이지를 바인딩으로 전달받기 위한 초기화 메서드
    init(currentPage: Binding<Int>) {
        self._currentPage = currentPage
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: PageControl.dotSpacing, content: {
            // 전체 페이지 수만큼 점(dot)을 생성
            ForEach(0..<totalPage, id: \.self) { index in
                Circle()
                    // 현재 페이지일 경우 채워진 원, 나머지는 테두리만 있는 원
                    .fill(index == currentPage ? .black03 : .clear)
                    .stroke(index == currentPage ? .clear : .gray02)
                    .frame(width: PageControl.dotSize, height: PageControl.dotSize)
            }
        })
    }
}

#Preview {
    // 프리뷰: 현재 페이지가 0일 때의 모습
    PageControl(currentPage: .constant(0))
}
