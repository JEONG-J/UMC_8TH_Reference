//
//  MenuSelectionView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI

/// '기타 메뉴' 화면 등에서 사용할 수 있는 선택 카드 컴포넌트입니다.
/// 여러 개의 버튼 항목을 타이틀 아래에 그리드 형태로 배치하며,
/// 제네릭을 활용해 다양한 버튼 타입(T: OtherMenuButton)을 지원합니다.
struct MenuSelectionCard<T: OtherMenuButton>: View {
    
    // MARK: - Property
    
    /// 카드의 타이틀 텍스트
    let title: String
    
    /// 표시할 버튼 항목 배열
    let items: [T]
    
    /// 버튼이 탭되었을 때 호출되는 클로저
    let onTap: (T) -> Void
    
    // MARK: - Layout Constants
    
    /// 타이틀과 그리드 사이 간격
    let spacing: CGFloat = 29
    
    /// 버튼 내 콘텐츠(HStack)의 내부 간격
    let contentsSpacing: CGFloat = 0
    
    /// 그리드 항목 사이 간격
    let gridItemSpacing: CGFloat = 100
    
    /// 그리드 행 간 간격
    let gridSpacing: CGFloat = 32
    
    /// 각 버튼의 너비
    let width: CGFloat = 157
    
    /// 각 버튼의 높이
    let height: CGFloat = 32
    
    /// 한 줄에 표시할 버튼 개수
    let gridItemCount: Int = 2
    
    // MARK: - Init
    
    /// 타이틀과 항목 목록, 탭 이벤트 핸들러를 받는 초기화 메서드
    init(title: String, items: [T], onTap: @escaping (T) -> Void) {
        self.title = title
        self.items = items
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        // 지정한 개수만큼 유연한 컬럼을 구성
        let columns = Array(
            repeating: GridItem(.flexible(minimum: .zero, maximum: width), spacing: gridItemSpacing),
            count: gridItemCount
        )
        
        VStack(alignment: .leading, spacing: spacing, content: {
            // 상단 타이틀
            Text(title)
                .font(.mainTextSemiBold18)
                .foregroundStyle(Color.black)
            
            // 버튼들을 그리드 형태로 배치
            LazyVGrid(columns: columns, alignment: .leading, spacing: gridSpacing, content: {
                ForEach(items, id: \.id) { item in
                    contetns(item: item)
                }
            })
            .padding(.horizontal, contentsSpacing)
        })
    }
    
    /// 개별 버튼 항목 뷰
    private func contetns(item: T) -> some View {
        Button(action: {
            onTap(item)
        }, label: {
            HStack(spacing: contentsSpacing, content: {
                Image(item.icon)  // 아이콘 이미지
                Text(item.title)  // 텍스트 라벨
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(Color.black02)
            })
            .frame(width: width, height: height, alignment: .leading)
        })
    }
}
