//
//  ShopView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

//
//  ShopView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

struct ShopView: View {
    
    // MARK: - Property
    @State var viewModel: ShopViewModel
    @State var headerOffset: (CGFloat, CGFloat) = (0, 0)
    
    // MARK: - Constants
    fileprivate enum ShopConstants {
        static let middleContentsSpacing: CGFloat = 16
        static let contentsVStackSpacing: CGFloat = 16
        
        static let onLineBannerSpacing: CGFloat = 28
        static let allProductGridSpacing: CGFloat = 10
        static let allProductGridCount: Int = 1
        
        static let newProductsItemSpacing: CGFloat = 65
        static let newProductsGridSpacing: CGFloat = 30
        static let newProductsGridCount: Int = 2
        
        static let allProductsText: String = "All Products"
        static let bestItemsText: String = "Best Items"
        static let newProductsText: String = "New Products"
        static let proxyName: String = "SCROLL"
        static let headerText: String = "Starbucks Online Store"
    }
    
    // MARK: - Init
    init() {
        self.viewModel = .init()
    }
    
    // MARK: - Body
    var body: some View {
        StickyHeader(
            headerOffset: $headerOffset,
            stickyModel: .init(shopHeader: ShopConstants.headerText),
            content: {
                onLineBanner
                makeSection(header: ShopConstants.allProductsText, contentsView: { allProducts })
                makeSection(header: ShopConstants.bestItemsText, contentsView: { bestItems })
                makeSection(header: ShopConstants.newProductsText, contentsView: { newProducts })
            },
            segment: {
                EmptyView()
            },
            subSegment: {
                EmptyView()
            }
        )
    }
    
    // MARK: - OnLineBanner
    private var onLineBanner: some View {
        ScrollView(.horizontal, content: {
            LazyHStack(spacing: ShopConstants.onLineBannerSpacing, content: {
                ForEach(viewModel.onLineData, id: \.id) { data in
                    Image(data.image)
                }
            })
            .padding(.horizontal, UIConstants.shopHorizontalPadding)
        })
        .contentMargins(.bottom, UIConstants.scrollBottomPadding, for: .scrollContent)
    }
    
    // MARK: - Product
    @ViewBuilder
    private var allProducts: some View {
        let rows = Array(repeating: GridItem(.flexible()), count: ShopConstants.allProductGridCount)
        
        ScrollView(.horizontal, content: {
            LazyHGrid(rows: rows, spacing: ShopConstants.allProductGridSpacing, content: {
                ForEach(viewModel.allProducts, id: \.id) { data in
                    ProductsCard(productItem: data)
                }
            })
            .padding(.horizontal, UIConstants.shopHorizontalPadding)
        })
        .contentMargins(.bottom, UIConstants.scrollBottomPadding, for: .scrollContent)
    }
    
    // MARK: - BestItem
    private var bestItems: some View {
        VStack(alignment: .center, spacing: ShopConstants.contentsVStackSpacing, content: {
            BestItemGridView(currentPage: $viewModel.bestItemsPageCount, items: viewModel.bestItems)
            PageControl(currentPage: $viewModel.bestItemsPageCount)
        })
        .padding(.horizontal, UIConstants.shopHorizontalPadding)
    }
    
    // MARK: - NewProduct
    @ViewBuilder
    private var newProducts: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: ShopConstants.newProductsItemSpacing), count: ShopConstants.newProductsGridCount)
        
        LazyVGrid(columns: columns, spacing: ShopConstants.newProductsGridSpacing, content: {
            ForEach(viewModel.newItems, id: \.id) { item in
                RectangleProductCard(item: item)
            }
        })
        .padding(.horizontal, UIConstants.shopHorizontalPadding)
    }
    
    // MARK: - Method
    
    private func makeSection(header: String, @ViewBuilder contentsView: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: ShopConstants.contentsVStackSpacing, content: {
            Text(header)
                .font(.mainTextSemiBold22)
                .foregroundStyle(Color.black03)
                .padding(.horizontal, UIConstants.shopHorizontalPadding)
            
            contentsView()
        })
    }
}

#Preview {
    ShopView()
}
