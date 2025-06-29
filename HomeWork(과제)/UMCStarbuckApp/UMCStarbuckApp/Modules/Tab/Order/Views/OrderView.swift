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
        static let sheetCornerRadius: CGFloat = 30
        static let headerText: String = "Order"
    }
    
    // MARK: - Init
    init() {
        self.viewModel = .init()
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom, content: {
            topContents
            OrderBottomStatus(showMapSheet: $viewModel.showMapSheet, storeAddressName: $viewModel.storeAddressName)
        })
        .sheet(isPresented: $viewModel.showMapSheet, content: {
            StoreSelectSheetView(container: container)
                .presentationCornerRadius(OrderConstants.sheetCornerRadius)
        })
    }
    
    private var topContents: some View {
        StickyHeader(
            headerOffset: $headerOffset,
            stickyModel: .init(orderHeader: OrderConstants.headerText),
            content: {
               middleCoffeeMenu
            },
            segment: {
                CustomSegment<OrderSegment, GreenSegmentStyle>(selectedSegment: $viewModel.selectedSegment, style: GreenSegmentStyle())
            },
            subSegment: {
                OrderSubSegment(subSegmentType: $viewModel.subSegmentType)
            }
        )
    }
    
    // MARK: - TopContents
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
