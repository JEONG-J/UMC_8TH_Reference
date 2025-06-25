//
//  ProductsCard.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

struct ProductsCard: View {
    
    // MARK: - Property
    let productItem: ProductItem
    
    fileprivate enum ProductCardConstant {
        static let spacing: CGFloat = 10
        static let imageHeight: CGFloat = 80
    }
    
    // MARK: - Init
    init(productItem: ProductItem) {
        self.productItem = productItem
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: ProductCardConstant.spacing, content: {
            image
            productText
        })
    }
    
    private var image: some View {
        Image(productItem.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: ProductCardConstant.imageHeight)
            .clipShape(Circle())
    }
    
    private var productText: some View {
        Text(productItem.name)
            .font(.mainTextSemiBold13)
            .foregroundStyle(Color.black02)
    }
}
