//
//  WhatsNewView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

/// "What's New" 섹션을 보여주는 뷰
struct WhatsNewView: View {
    
    // MARK: - Property
    
    /// 섹션 타이틀 (예: "What’s New")
    let title: String
    
    /// 표시할 항목 리스트
    let items: [WhatsNewItems]
    
    /// 내부에서 사용하는 상수 정의
    fileprivate enum WhatsNewConstants {
        static let mainSpacing: CGFloat = 10             // 타이틀과 콘텐츠 사이 간격
        static let lazySpacing: CGFloat = 16             // 카드 사이 간격
        static let contentsSpacing: CGFloat = 9          // 카드 내부 텍스트 간 간격
        
        static let lineSpacing: CGFloat = 2              // 설명 텍스트 줄 간격
        static let lineLimit: Int = 2                    // 설명 텍스트 최대 줄 수
        static let textFrameWidth: CGFloat = 250         // 설명 텍스트 최대 너비
        static let textFrameHeight: CGFloat = 36         // 설명 텍스트 최소 높이
    }
    
    // MARK: - Init
    
    /// 기본 이니셜라이저
    init(
        title: String,
        items: [WhatsNewItems]
    ) {
        self.title = title
        self.items = items
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: WhatsNewConstants.mainSpacing, content: {
            newHeader       // 섹션 제목
            newContents     // 항목 리스트 (가로 스크롤)
        })
    }
    
    /// 섹션 헤더 텍스트 (제목)
    private var newHeader: some View {
        Text(title)
            .font(.mainTextBold24)
            .foregroundStyle(Color.black03)
    }
    
    /// 가로 스크롤 가능한 항목 리스트
    private var newContents: some View {
        ScrollView(.horizontal, content: {
            LazyHStack(spacing: WhatsNewConstants.lazySpacing, content: {
                ForEach(items, id: \.id) { item in
                    newCard(item) // 각 항목을 카드 형태로 렌더링
                }
            })
        })
        .contentMargins(.bottom, UIConstants.scrollBottomPadding, for: .scrollContent) // 하단 여백
    }
    
    /// 각 항목 카드 뷰
    private func newCard(_ item: WhatsNewItems) -> some View {
        VStack(alignment: .leading, spacing: WhatsNewConstants.lazySpacing, content: {
            Image(item.image)
                .fixedSize()
            cardString(name: item.name, description: item.description)
        })
    }
    
    /// 카드 내 텍스트 구성 (이름 + 설명)
    private func cardString(name: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: WhatsNewConstants.contentsSpacing, content: {
            Text(name)
                .font(.mainTextSemiBold18)
                .foregroundStyle(Color.black02)
            
            Text(description)
                .frame(
                    maxWidth: WhatsNewConstants.textFrameWidth,
                    minHeight: WhatsNewConstants.textFrameHeight,
                    alignment: .leading
                )
                .font(.mainTextSemiBold13)
                .foregroundStyle(Color.gray03)
                .lineLimit(WhatsNewConstants.lineLimit)
                .lineSpacing(WhatsNewConstants.lineSpacing)
                .multilineTextAlignment(.leading)
        })
    }
}
