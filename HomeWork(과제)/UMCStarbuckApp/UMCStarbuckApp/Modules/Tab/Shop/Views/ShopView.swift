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
        
        static let stickyHeaderMargins: CGFloat = 10
        static let stickyHeaderHeight: CGFloat = 30
        static let stickyPinnedHeight: CGFloat = 70
        static let sticyHeaderAnimation: TimeInterval = 0.4
        static let stickyRadio: Double = 0.04
        
        static let allProductsText: String = "All Products"
        static let bestItemsText: String = "Best Items"
        static let newProductsText: String = "New Products"
        static let proxyName: String = "SCROLL"
        static let stickyHeaderText: String = "Starbucks Online Store"
    }
    
    // MARK: - Init
    init() {
        self.viewModel = .init()
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, content: {
            VStack(spacing: .zero, content: {
                headerView()
                middleContents
            })
        })
        .ignoresSafeArea()
        .coordinateSpace(name: ShopConstants.proxyName)
    }
    
    private var middleContents: some View {
        LazyVStack(alignment: .leading, spacing: ShopConstants.middleContentsSpacing, pinnedViews: [.sectionHeaders], content: {
            Section(content: {
                onLineBanner
                makeSection(header: ShopConstants.allProductsText, contentsView: { allProducts })
                makeSection(header: ShopConstants.bestItemsText, contentsView: { bestItems })
                makeSection(header: ShopConstants.newProductsText, contentsView: { newProducts })
            }, header: {
                pinnedHeaderView()
                    .modifier(OffsetModifier(offset: $headerOffset.0, returnromStart: false))
                    .modifier(OffsetModifier(offset: $headerOffset.1))
            })
        })
        .safeAreaPadding(.horizontal, UIConstants.shopHorizontalPadding)
        .contentMargins(.top, ShopConstants.stickyHeaderMargins)
        .padding(.bottom, UIConstants.defaultscrollBottomPadding)
    }
    
    // MARK: - OnLineBanner
    private var onLineBanner: some View {
        ScrollView(.horizontal, content: {
            LazyHStack(spacing: ShopConstants.onLineBannerSpacing, content: {
                ForEach(viewModel.onLineData, id: \.id) { data in
                    Image(data.image)
                }
            })
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
        })
        .contentMargins(.bottom, UIConstants.scrollBottomPadding, for: .scrollContent)
    }
    
    // MARK: - BestItem
    private var bestItems: some View {
        VStack(alignment: .center, spacing: ShopConstants.contentsVStackSpacing, content: {
            BestItemGridView(currentPage: $viewModel.bestItemsPageCount, items: viewModel.bestItems)
            PageControl(currentPage: $viewModel.bestItemsPageCount)
        })
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
    }
    
    private func makeSection(header: String, @ViewBuilder contentsView: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: ShopConstants.contentsVStackSpacing, content: {
            Text(header)
                .font(.mainTextSemiBold22)
                .foregroundStyle(Color.black03)
            
            contentsView()
        })
    }
    
    // MARK: - Sticky Heder
    @ViewBuilder
    private func headerView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named(ShopConstants.proxyName)).minY
            let size = proxy.size
            let height = max(0, size.height + minY)
            
            Rectangle()
                .fill(Color.white)
                .frame(width: size.width, height: height, alignment: .top)
                .offset(y: -minY)
        }
        .frame(height: ShopConstants.stickyHeaderHeight)
    }
    
    @ViewBuilder
    private func pinnedHeaderView() -> some View {
        let threshold = -(getScreenSize().height * ShopConstants.stickyRadio)
        
        HStack {
            if headerOffset.0 < threshold {
                Spacer()
            }
            
            Text(ShopConstants.stickyHeaderText)
                .font(headerOffset.0 < threshold ? .mainTextSemiBold18 : .mainTextBold24)
                .foregroundStyle(Color.black03)
                .animation(.easeInOut(duration: ShopConstants.sticyHeaderAnimation), value: headerOffset.0)
            
            Spacer()
        }
        .frame(height: ShopConstants.stickyPinnedHeight, alignment: .bottom)
        .safeAreaPadding(.vertical, headerOffset.0 < threshold ? ShopConstants.stickyHeaderMargins : .zero)
        .background(Color.white)
        .stickyShadow(isActive: headerOffset.0 < threshold)
    }
}

#Preview {
    ShopView()
}
