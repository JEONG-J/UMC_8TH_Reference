//
//  OrderView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import SwiftUI

struct OrderView: View {
    // MARK: - Property
    @State var viewModel: OrderViewModel
    @EnvironmentObject var container: DIContainer
    @State var headerOffset: (CGFloat, CGFloat) = (0, 0)
    
    fileprivate enum OrderConstants {
        static let middleCoffeeLeadingPadding: CGFloat = 23
        static let middleCoffeeTrailingPadding: CGFloat = 31
        static let middleSpacing: CGFloat = 26
        
        static let pinnedTitlePadding: CGFloat = 23
        static let pinnedSpacing: CGFloat = 6
        
        static let stickyPinnedHeight: CGFloat = 190
        static let stickyHeaderHeight: CGFloat = 20
        static let stickyHeaderMargins: CGFloat = 10
        static let stickyRatio: Double = 0.04
        static let sticyHeaderAnimation: TimeInterval = 0.3
        
        static let proxyName: String = "SCROLL"
        static let stickyHeaderText: String = "Order"
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
        .coordinateSpace(name: OrderConstants.proxyName)
    }
    
    // MARK: - TopContents
    @ViewBuilder
    private func headerView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named(OrderConstants.proxyName)).minY
            let size = proxy.size
            let height = max(0, size.height + minY)
            
            Rectangle()
                .fill(Color.white)
                .frame(width: size.width, height: height, alignment: .top)
                .offset(y: -minY)
        }
        .frame(height: OrderConstants.stickyHeaderHeight)
    }
    
    @ViewBuilder
    private func pinnedHeaderView() -> some View {
        let threshold = -(getScreenSize().height * OrderConstants.stickyRatio)
        
        VStack(alignment: .leading, spacing: OrderConstants.pinnedSpacing, content: {
            pinnedHeaderTitle(threshold: threshold)
            CustomSegment<OrderSegment>(selectedSegment: $viewModel.selectedSegment)
            OrderSubSegment(subSegmentType: $viewModel.subSegmentType)
        })
        .frame(height: OrderConstants.stickyPinnedHeight, alignment: .bottom)
        .background(Color.white)
    }
    
    private func pinnedHeaderTitle(threshold: Double) -> some View {
        Text(OrderConstants.stickyHeaderText)
            .font(headerOffset.0 < threshold ? .mainTextSemiBold18 : .mainTextBold24)
            .foregroundStyle(Color.black03)
            .padding(.horizontal, OrderConstants.pinnedTitlePadding)
            .frame(maxWidth: .infinity, alignment: headerOffset.0 < threshold ? .center : .leading)
            .animation(.interactiveSpring(duration: OrderConstants.sticyHeaderAnimation), value: headerOffset.0)
    }
    
    // MARK: - MiddleContents
    private var middleContents: some View {
        LazyVStack(alignment: .leading, spacing: OrderConstants.middleSpacing, pinnedViews: [.sectionHeaders], content: {
            Section(content: {
                middleCoffeeMenu
            }, header: {
                pinnedHeaderView()
                    .modifier(OffsetModifier(offset: $headerOffset.0, returnromStart: false))
                    .modifier(OffsetModifier(offset: $headerOffset.1))
            })
        })
        .contentMargins(.top, OrderConstants.stickyHeaderMargins)
        .padding(.bottom, UIConstants.defaultscrollBottomPadding)
    }
    
    @ViewBuilder
    private var middleCoffeeMenu: some View {
        ForEach(OrderCoffeeMenu.allCases, id: \.id) { coffee in
            OrderCoffeeCard(orderCoffeeMenu: coffee)
        }
        .padding(.leading, OrderConstants.middleCoffeeLeadingPadding)
        .padding(.trailing, OrderConstants.middleCoffeeTrailingPadding)
    }
}

#Preview {
    OrderView()
        .environmentObject(DIContainer())
}
