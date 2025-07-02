//
//  ProductsCard.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

/// 개별 상품을 표시하는 카드 형태의 뷰입니다.
/// 제품 이미지와 이름을 원형 이미지와 함께 수직으로 정렬하여 보여줍니다.
struct ProductsCard: View {
    
    // MARK: - Property
    
    /// 표시할 상품 정보 (이름, 이미지 등 포함된 모델)
    let productItem: ProductItem
    
    // MARK: - Constants
    fileprivate enum ProductCardConstant {
        static let spacing: CGFloat = 10                // 이미지와 텍스트 간 간격
        static let imageHeight: CGFloat = 80            // 이미지 높이 제한 (원형 이미지 크기)
    }
    
    // MARK: - Init
    
    /// 카드 생성 시 상품 모델을 주입
    init(productItem: ProductItem) {
        self.productItem = productItem
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: ProductCardConstant.spacing, content: {
            image      // 상품 이미지
            productText // 상품 이름 텍스트
        })
    }
    
    /// 상품 이미지를 원형으로 표시
    private var image: some View {
        Image(productItem.image)
            .resizable() // 이미지 크기 조절 가능
            .aspectRatio(contentMode: .fit) // 비율 유지
            .frame(maxWidth: .infinity, maxHeight: ProductCardConstant.imageHeight) // 최대 높이 제한
            .clipShape(Circle()) // 원형으로 자르기
    }
    
    /// 상품 이름 텍스트 표시
    private var productText: some View {
        Text(productItem.name)
            .font(.mainTextSemiBold13) // 앱에서 정의된 세미볼드 폰트
            .foregroundStyle(Color.black02) // 다소 흐린 검정색
    }
}
