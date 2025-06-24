//
//  OrderCoffeeCard.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import SwiftUI

struct OrderCoffeeCard: View {
    // MARK: - Property
    let orderCoffeeMenu: OrderCoffeeMenu
    
    // MARK: - Constants
    fileprivate enum OrderCoffeeConstants {
        static let hstackSpacing: CGFloat = 16
        static let vstackSpacing: CGFloat = 4
        static let imageSize: CGFloat = 60
        static let greenMarkSize: CGFloat = 6
        static let titleHstackSpacing: CGFloat = 1
    }
    // MARK: - Init
    init(orderCoffeeMenu: OrderCoffeeMenu) {
        self.orderCoffeeMenu = orderCoffeeMenu
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: OrderCoffeeConstants.hstackSpacing, content: {
            Image(orderCoffeeMenu.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: OrderCoffeeConstants.imageSize, height: OrderCoffeeConstants.imageSize)
            
            rightInfo
        })
    }
    
    private var rightInfo: some View {
        VStack(alignment: .leading, spacing: OrderCoffeeConstants.vstackSpacing, content: {
            mainTitle
            subTitle
        })
        .frame(maxWidth: .infinity, alignment: .leading)

    }
    
    private var mainTitle: some View {
        HStack(alignment: .top, spacing: OrderCoffeeConstants.titleHstackSpacing, content: {
            Text(orderCoffeeMenu.rawValue)
                .font(.mainTextSemiBold16)
                .foregroundStyle(Color.gray06)
            
            if orderCoffeeMenu.greenMark {
                Circle()
                    .fill(Color.green01)
                    .frame(width: OrderCoffeeConstants.greenMarkSize)
            }
        })
    }
    
    private var subTitle: some View {
        Text(orderCoffeeMenu.english)
            .font(.mainTextSemiBold13)
            .foregroundStyle(Color.gray03)
    }
}

#Preview {
    OrderCoffeeCard(orderCoffeeMenu: .iceCappuccino)
}
