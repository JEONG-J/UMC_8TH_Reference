//
//  RectangleProductCard.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import SwiftUI

/// 사각형 형태의 상품 카드를 표시하는 뷰입니다.
/// 이미지와 텍스트를 수직으로 배치하여 상품 정보를 표현합니다.
struct RectangleProductCard<Item: ShopItemAttr>: View {
    
    // MARK: - Property
    
    /// 제네릭으로 받는 상품 모델. `ShopItemAttr` 프로토콜을 준수해야 합니다.
    let item: Item

    // UI 배치 관련 상수들
    let spacing: CGFloat = 12                 // 이미지와 텍스트 간의 간격
    let maxHeight: CGFloat = 156              // 이미지 최대 높이
    let lineSpacing: CGFloat = 2.0            // 텍스트 줄 간 간격
    let lineLimit: Int = 2                    // 텍스트 줄 수 제한
    
    // MARK: - Init
    
    /// 카드 초기화 시 상품 항목을 주입
    init(item: Item) {
        self.item = item
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing, content: {
            
            /// 상품 이미지
            Image(item.image)
                .fixedSize() // 이미지 본래 크기 고정
                .frame(maxWidth: .infinity, maxHeight: maxHeight) // 카드 내부에서 최대 크기 제한
            
            /// 상품 이름 텍스트
            Text(item.name.customLineBreak()) // 커스텀 줄바꿈 적용 (예: "\n" 처리)
                .font(.mainTextSemiBold14)    // 앱에서 정의된 세미볼드 14pt 폰트
                .foregroundStyle(Color.black02) // 색상 설정
                .lineLimit(lineLimit)         // 최대 줄 수 설정
                .lineSpacing(lineSpacing)     // 줄 간 간격 설정
                .multilineTextAlignment(.leading) // 왼쪽 정렬
                .frame(height: 40, alignment: .top) // 고정 높이 설정
        })
    }
}
