//
//  RectangleProductCard.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

struct RectangleProductCard<Item: ShopItemAttr>: View {
    
    // MARK: - Property
    let item: Item
    
    let spacing: CGFloat = 12
    let maxHeight: CGFloat = 156
    let lineSpacing: CGFloat = 2.0
    let lineLimit: Int = 2
    
    // MARK: - Init
    init(item: Item) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing, content: {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: maxHeight)
            
            Text(item.name.customLineBreak())
                .font(.mainTextSemiBold14)
                .foregroundStyle(Color.black02)
                .lineLimit(lineLimit)
                .lineSpacing(lineSpacing)
                .multilineTextAlignment(.leading)
        })
    }
}
