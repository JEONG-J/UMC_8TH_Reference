//
//  MenuSelectionView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI

struct MenuSelectionCard<T: OtherMenuButton>: View {
    
    // MARK: - Property
    let title: String
    let items: [T]
    let onTap: (T) -> Void  // 버튼 터치 시 동작할 클로저 추가
    
    let spacing: CGFloat = 29
    let contentsSpacing: CGFloat = 0
    let gridItemSpacing: CGFloat = 100
    
    let gridSpacing: CGFloat = 32
    
    let width: CGFloat =  157
    let height: CGFloat = 32
    
    let gridItemCount: Int = 2
    
    // MARK: - Init
    init(title: String, items: [T], onTap: @escaping (T) -> Void) {
        self.title = title
        self.items = items
        self.onTap = onTap
    }
    
    // MARK: - Body
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(minimum: .zero, maximum: width), spacing: gridItemSpacing), count: gridItemCount)
        
        VStack(alignment: .leading, spacing: spacing, content: {
            Text(title)
                .font(.mainTextSemiBold18)
                .foregroundStyle(Color.black)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: gridSpacing, content: {
                ForEach(items, id: \.id) { item in
                    contetns(item: item)
                }
            })
            .padding(.horizontal, contentsSpacing)
        })
        
    }
    
    private func contetns(item: T) -> some View {
        Button(action: {
            onTap(item)
        }, label: {
            HStack(spacing: contentsSpacing, content: {
                Image(item.icon)
                Text(item.title)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(Color.black02)
            })
            .frame(width: width ,height: height, alignment: .leading)
        })
    }
}
