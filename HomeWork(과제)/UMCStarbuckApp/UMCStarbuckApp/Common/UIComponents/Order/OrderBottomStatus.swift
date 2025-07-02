//
//  OrderBottomStatus.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import SwiftUI

/// 주문 화면 하단에 표시되는 매장 선택 상태 바입니다.
/// - 선택된 매장 주소가 있으면 해당 텍스트를 표시하고,
/// - 없으면 기본 안내 문구를 보여줍니다.
/// - 탭 시 `showMapSheet`를 토글하여 매장 선택 시트를 열 수 있습니다.
struct OrderBottomStatus: View {
    
    // MARK: - Property
    
    /// 지도 시트를 열지 여부를 제어하는 바인딩 변수
    @Binding var showMapSheet: Bool
    
    /// 선택된 매장 주소 (없을 경우 기본 문구 표시)
    @Binding var storeAddressName: String?
    
    // MARK: - Constants
    
    /// 레이아웃 및 텍스트 상수를 정의한 내부 enum
    fileprivate enum OrderBottomStatusConstants {
        static let statatusTitle: String = "주문할 매장을 선택해주세요"  // 기본 안내 문구
        static let spacing: CGFloat = 7                                 // VStack 내부 간격
        static let horizonPadding: CGFloat = 20                         // 좌우 패딩
        static let topPadding: CGFloat = 10                             // 상단 패딩
        static let bottomPadding: CGFloat = 21                          // 하단 패딩
    }
    
    // MARK: - Init
    
    /// 외부에서 시트 표시 여부와 주소 데이터를 주입받는 초기화 메서드
    init(
        showMapSheet: Binding<Bool>,
        storeAddressName: Binding<String?>
    ) {
        self._showMapSheet = showMapSheet
        self._storeAddressName = storeAddressName
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: OrderBottomStatusConstants.spacing, content: {
            statusTitle  // 현재 상태 타이틀 (주소 또는 기본 문구)
            Divider()
                .background(Color.gray06)
        })
        .padding(.horizontal, OrderBottomStatusConstants.horizonPadding)
        .padding(.top, OrderBottomStatusConstants.topPadding)
        .padding(.bottom, OrderBottomStatusConstants.bottomPadding)
        .background {
            Rectangle()
                .fill(Color.black02)
                .frame(maxWidth: .infinity)
        }
        .onTapGesture {
            // 탭 시 지도 시트 열기
            showMapSheet.toggle()
        }
    }
    
    /// 상단 텍스트와 아이콘 구성 뷰
    private var statusTitle: some View {
        HStack {
            // 선택된 주소가 있으면 표시, 없으면 기본 문구 사용
            Text(storeAddressName ?? OrderBottomStatusConstants.statatusTitle)
                .font(.mainTextSemiBold16)
                .foregroundStyle(Color.white)
            
            Spacer()
            
            // 오른쪽 화살표 아이콘
            Image(.downIcon)
        }
    }
}

#Preview {
    // 프리뷰: 주소가 설정된 상태로 시트가 열려 있음
    OrderBottomStatus(
        showMapSheet: .constant(true),
        storeAddressName: .constant("주문할 매장을 선택해 주세요!")
    )
}
