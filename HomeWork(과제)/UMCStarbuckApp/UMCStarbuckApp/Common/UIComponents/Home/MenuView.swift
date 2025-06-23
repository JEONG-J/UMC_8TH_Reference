//
//  HorizontalSection.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

// 메뉴(커피, 디저트 등)를 가로로 보여주는 공통 뷰
struct MenuView<Item: Identifiable & MenuItemAttr>: View {
    
    // DIContainer에서 전역 상태 또는 라우팅에 접근
    @EnvironmentObject var container: DIContainer
    
    // MARK: - Property
    
    /// 섹션 제목 (예: "추천 메뉴", "디저트")
    let title: String
    
    /// 표시할 아이템 리스트 (예: 커피 요약 아이템, 디저트 아이템 등)
    let items: [Item]
    
    /// 전체 VStack 간격
    let mainSpacing: CGFloat
    
    /// LazyHStack 내부 아이템 간 간격
    let lazySpacing: CGFloat
    
    /// 카드 내 이미지와 텍스트 사이 간격
    let contentsSpacing: CGFloat
    
    /// 아이템 클릭 시 실행할 액션
    let onTap: (Item) -> Void
    
    /// 텍스트 강조 처리를 위한 키워드 리스트
    let rangeString: [String] = ["님을 위한 추천 메뉴", "하루가 달콤해지는 디저트"]
    
    // MARK: - Init
    init(
        title: String,
        items: [Item],
        mainSpacing: CGFloat = 25,
        lazySpacing: CGFloat = 16,
        contentsSpacing: CGFloat = 10,
        onTap: @escaping (Item) -> Void
    ) {
        self.title = title
        self.items = items
        self.mainSpacing = mainSpacing
        self.lazySpacing = lazySpacing
        self.contentsSpacing = contentsSpacing
        self.onTap = onTap
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: mainSpacing, content: {
            menuHeader   // 섹션 제목
            menuContents // 가로 스크롤 가능한 카드 목록
        })
    }
    
    /// 섹션 타이틀 표시 뷰
    private var menuHeader: some View {
        Text(convertStyleText(title))
            .font(.mainTextBold24)
            .foregroundStyle(Color.brown01)
    }
    
    /// LazyHStack을 이용한 가로 스크롤 메뉴 카드 목록
    private var menuContents: some View {
        ScrollView(.horizontal, content: {
            LazyHStack(spacing: lazySpacing, content: {
                ForEach(items, id: \.id) { item in
                    menuCard(item) // 각 아이템 카드 생성
                }
            })
        })
        .contentMargins(.bottom, UIConstants.scrollBottomPadding, for: .scrollContent)
    }
    
    /// 개별 메뉴 카드 뷰 (이미지 + 이름)
    private func menuCard(_ item: Item) -> some View {
        VStack(spacing: contentsSpacing, content: {
            Image(item.thumbnailImage)
                .fixedSize()
            
            Text(item.name)
                .font(.mainTextSemiBold14)
        })
        .onTapGesture {
            onTap(item) // 카드 클릭 시 동작
        }
    }
    
    /// 특정 키워드를 강조 처리하는 텍스트 변환 함수
    private func convertStyleText(_ text: String) -> AttributedString {
        var attributedString = AttributedString(text)

        for keyword in rangeString {
            if let range = attributedString.range(of: keyword) {
                attributedString[range].foregroundColor = Color.black03
                attributedString[range].font = .mainTextBold24
            }
        }
        return attributedString
    }
}
