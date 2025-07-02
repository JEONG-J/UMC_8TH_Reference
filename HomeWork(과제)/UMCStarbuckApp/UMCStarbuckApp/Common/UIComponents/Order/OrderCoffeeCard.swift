//
//  OrderCoffeeCard.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import SwiftUI

/// 주문 화면에서 커피 메뉴를 카드 형태로 보여주는 뷰입니다.
/// 좌측에는 커피 이미지, 우측에는 한글/영문 이름과 그린 마크를 표시합니다.
struct OrderCoffeeCard: View {
    
    // MARK: - Property
    
    /// 커피 메뉴 항목 정보 (이름, 영문명, 이미지, 마크 여부 포함)
    let orderCoffeeMenu: OrderCoffeeMenu
    
    // MARK: - Constants
    
    /// 레이아웃 및 스타일 관련 상수 정의
    fileprivate enum OrderCoffeeConstants {
        static let hstackSpacing: CGFloat = 16              // 이미지와 텍스트 간 간격
        static let vstackSpacing: CGFloat = 4               // 텍스트 수직 간격
        static let imageSize: CGFloat = 60                  // 이미지 크기
        static let greenMarkSize: CGFloat = 6               // 초록 점 크기
        static let titleHstackSpacing: CGFloat = 1          // 타이틀 내 요소 간 간격
    }

    // MARK: - Init
    
    /// 외부에서 커피 메뉴를 주입받는 초기화 메서드
    init(orderCoffeeMenu: OrderCoffeeMenu) {
        self.orderCoffeeMenu = orderCoffeeMenu
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: OrderCoffeeConstants.hstackSpacing, content: {
            // 좌측 커피 이미지
            Image(orderCoffeeMenu.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: OrderCoffeeConstants.imageSize, height: OrderCoffeeConstants.imageSize)
            
            // 우측 텍스트 정보
            rightInfo
        })
    }
    
    /// 커피 이름(한글 + 초록 점)과 영문명을 포함한 우측 콘텐츠
    private var rightInfo: some View {
        VStack(alignment: .leading, spacing: OrderCoffeeConstants.vstackSpacing, content: {
            mainTitle     // 한글명 + 초록 점
            subTitle      // 영문명
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /// 커피 한글 이름과 초록 마크(Circle) 표시
    private var mainTitle: some View {
        HStack(alignment: .top, spacing: OrderCoffeeConstants.titleHstackSpacing, content: {
            Text(orderCoffeeMenu.rawValue)
                .font(.mainTextSemiBold16)
                .foregroundStyle(Color.gray06)
            
            // 특정 조건일 때만 초록 마크 표시
            if orderCoffeeMenu.greenMark {
                Circle()
                    .fill(Color.green01)
                    .frame(width: OrderCoffeeConstants.greenMarkSize)
            }
        })
    }
    
    /// 커피 영문 이름 표시
    private var subTitle: some View {
        Text(orderCoffeeMenu.english)
            .font(.mainTextSemiBold13)
            .foregroundStyle(Color.gray03)
    }
}

#Preview {
    // 미리보기: .iceCappuccino 항목으로 카드 표시
    OrderCoffeeCard(orderCoffeeMenu: .iceCappuccino)
}
