//
//  HorizontalSection.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

struct MenuView<Item: Identifiable & MenuItemAttr>: View {
    
    // MARK: - Property
    let title: String
    let items: [Item]
    let mainSpacing: CGFloat
    let lazySpacing: CGFloat
    let contentsSpacing: CGFloat
    
    let rangeString: [String] = ["님을 위한 추천 메뉴", "하루가 달콤해지는 디저트"]
    
    // MARK: - Init
    init(
        title: String,
        items: [Item],
        mainSpacing: CGFloat = 25,
        lazySpacing: CGFloat = 16,
        contentsSpacing: CGFloat = 10
    ) {
        self.title = title
        self.items = items
        self.mainSpacing = mainSpacing
        self.lazySpacing = lazySpacing
        self.contentsSpacing = contentsSpacing
    }
    
    
    // MARK: - Constants
    var body: some View {
        VStack(alignment: .leading, spacing: mainSpacing, content: {
            menuHeader
            menuContents
        })
    }
    
    private var menuHeader: some View {
        Text(convertStyleText(title))
            .font(.mainTextBold24)
            .foregroundStyle(Color.brown01)
    }
    
    private var menuContents: some View {
        ScrollView(.horizontal, content: {
            LazyHStack(spacing: lazySpacing, content: {
                ForEach(items, id: \.id) { item in
                    menuCard(item)
                }
            })
        })
        .contentMargins(.bottom, UIConstants.scrollBottomPadding, for: .scrollContent)
    }
    
    private func menuCard(_ item: Item) -> some View {
        VStack(spacing: contentsSpacing, content: {
            Image(item.thumbnailImage)
                .fixedSize()
            
            Text(item.name)
                .font(.mainTextSemiBold14)
        })
    }
    
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
