//
//  ReceiptRowView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import SwiftUI

/// 영수증 목록에서 사용되는 하나의 영수증 카드(행) 뷰입니다.
/// - 좌측: 매장 이름, 날짜, 결제 금액
/// - 우측: 아이콘 (예: 상세보기, 첨부파일 등)
/// - 터치 가능한 전체 영역을 구성하기 위해 `.contentShape(Rectangle())` 적용
struct ReceiptRowCard: View {
    
    // MARK: - Property
    
    /// 표시할 영수증 모델 데이터
    let receipt: ReceiptModel
    
    // MARK: - Constants
    
    /// 레이아웃 상수를 정의하는 내부 enum
    fileprivate enum ReceiptConstants {
        /// VStack 내 항목 간 간격
        static let vstackSpacing: CGFloat = 9
    }
    
    // MARK: - Init
    
    /// 외부에서 영수증 데이터를 주입받는 초기화
    init(receipt: ReceiptModel) {
        self.receipt = receipt
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            leftContents              // 매장명, 날짜, 금액 등 좌측 정보
            Spacer()                  // 우측 아이콘과 간격 확보
            Image(.receiptShow)       // 영수증 아이콘 (SwiftGen 등으로 등록된 이미지)
        }
        .contentShape(Rectangle())    // 전체 HStack을 터치 영역으로 설정
    }
    
    // MARK: - Contents
    
    /// 좌측 정보 (매장명, 날짜, 가격)를 구성하는 뷰
    private var leftContents: some View {
        VStack(alignment: .leading, spacing: ReceiptConstants.vstackSpacing, content: {
            // 매장 이름
            Text(receipt.stroeName)
                .font(.mainTextSemiBold18)
                .foregroundStyle(Color.black)
            
            // 영수증 날짜 (Date -> String 포맷 변환 필요)
            Text(receipt.date.formattedDateString())
                .font(.mainTextMedium16)
                .foregroundStyle(Color.gray03)
            
            // 결제 금액
            Text("\(receipt.price)원")
                .font(.mainTextSemiBold18)
                .foregroundStyle(Color.brown02)
        })
    }
}
