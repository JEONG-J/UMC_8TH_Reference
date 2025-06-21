//
//  WhatsNewView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

struct WhatsNewView: View {
    
    // MARK: - Property
    let title: String
    let items: [WhatsNewItems]
    
    fileprivate enum WhatsNewConstants {
        static let mainSpacing: CGFloat = 10
        static let lazySpacing: CGFloat = 16
        static let contentsSpacing: CGFloat = 9
        
        static let lineSpacing: CGFloat = 2
        static let lineLimit: Int = 2
        static let textFrameWidth: CGFloat = 250
        static let textFrameHeight: CGFloat = 36
    }
    
    // MARK: - Init
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
            newHeader
            newContents
        })
    }
    
    private var newHeader: some View {
        Text(title)
            .font(.mainTextBold24)
            .foregroundStyle(Color.black03)
    }
    
    private var newContents: some View {
        ScrollView(.horizontal, content: {
            LazyHStack(spacing: WhatsNewConstants.lazySpacing, content: {
                ForEach(items, id: \.id) { item in
                    newCard(item)
                }
            })
        })
        .contentMargins(.bottom, UIConstants.scrollBottomPadding, for: .scrollContent)
    }
    
    private func newCard(_ item: WhatsNewItems) -> some View {
        VStack(alignment: .leading, spacing: WhatsNewConstants.lazySpacing, content: {
            Image(item.image)
                .fixedSize()
            cardString(name: item.name, description: item.description)
        })
    }
    
    private func cardString(name: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: WhatsNewConstants.contentsSpacing, content: {
            Text(name)
                .font(.mainTextSemiBold18)
                .foregroundStyle(Color.black02)
            
            Text(description)
                .frame(maxWidth: WhatsNewConstants.textFrameWidth, minHeight: WhatsNewConstants.textFrameHeight, alignment: .leading)
                .font(.mainTextSemiBold13)
                .foregroundStyle(Color.gray03)
                .lineLimit(WhatsNewConstants.lineLimit)
                .lineSpacing(WhatsNewConstants.lineSpacing)
                .multilineTextAlignment(.leading)
        })
    }
}
