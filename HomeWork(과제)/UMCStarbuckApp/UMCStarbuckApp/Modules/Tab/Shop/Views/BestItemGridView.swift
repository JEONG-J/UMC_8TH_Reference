//
//  BestItemGridView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI

struct BestItemGridView: View {
    
    // MARK: - Property
    @Binding var currentPage: Int
    let items: [BestItems]
    
    private var pagedItem: [[BestItems]] {
        stride(from: 0, to: items.count, by: 4).map {
            Array(items[$0..<min($0 + 4, items.count)])
        }
    }
    
    // MARK: - Constants
    fileprivate enum BestItemGridConstants {
        static let gridCount: Int = 2
        static let itemSpacing: CGFloat = 61
        static let gridSpacing: CGFloat = 54
        static let gridHeight: CGFloat = 470
    }
    
    // MARK: - Init
    init(currentPage: Binding<Int>, items: [BestItems]) {
        self._currentPage = currentPage
        self.items = items
    }
    
    // MARK: - Body
    @ViewBuilder
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: BestItemGridConstants.itemSpacing), count: BestItemGridConstants.gridCount)
        
        TabView(selection: $currentPage, content: {
            ForEach(pagedItem.indices, id: \.self) { index in
                LazyVGrid(columns: columns, spacing: BestItemGridConstants.gridSpacing, content: {
                    ForEach(pagedItem[index]) { item in
                        RectangleProductCard(item: item)
                    }
                })
                .tag(index)
            }
        })
        .frame(height: BestItemGridConstants.gridHeight)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .task {
            print(self.pagedItem)
        }
    }
}

#Preview {
    BestItemGridView(currentPage: .constant(1), items: [
        .init(image: .bestEighth, name: "11"),
        .init(image: .bestEighth, name: "121"),
        .init(image: .bestEighth, name: "113"),
        .init(image: .bestEighth, name: "114"),
        .init(image: .bestEighth, name: "115"),
        .init(image: .bestEighth, name: "117"),
        .init(image: .bestEighth, name: "118"),
        .init(image: .bestEighth, name: "119"),
    ])
}
