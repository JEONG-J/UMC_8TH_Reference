//
//  OrderView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import SwiftUI

/// 주문 화면(OrderView)을 나타내는 SwiftUI 뷰입니다.
/// 상단에는 Sticky Header와 커피 메뉴를, 하단에는 매장 선택 상태를 표시합니다.
/// 매장 선택 시 매장 선택 시트를 띄웁니다.
struct OrderView: View {
    
    // MARK: - ViewModel 및 환경 객체
    @State var viewModel: OrderViewModel               // 주문 관련 상태를 관리하는 뷰모델
    @EnvironmentObject var container: DIContainer      // 의존성 주입 컨테이너
    @State var headerOffset: (CGFloat, CGFloat) = (0, 0) // StickyHeader의 위치 추적용 오프셋
    
    // MARK: - 상수 정의
    fileprivate enum OrderConstants {
        static let middleCoffeeLeadingPadding: CGFloat = 23       // 좌측 패딩
        static let middleCoffeeTrailingPadding: CGFloat = 31      // 우측 패딩
        static let sheetCornerRadius: CGFloat = 30                 // 매장 선택 시트의 모서리 둥글기
        static let headerText: String = "Order"                    // 헤더에 표시할 텍스트
    }
    
    // MARK: - 초기화
    init() {
        self.viewModel = .init()
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom, content: {
            topContents     // StickyHeader 포함 상단 콘텐츠
            OrderBottomStatus(
                showMapSheet: $viewModel.showMapSheet,
                storeAddressName: $viewModel.storeAddressName
            ) // 매장 선택 상태 하단바
        })
        // 매장 선택 시트
        .sheet(isPresented: $viewModel.showMapSheet, content: {
            StoreSelectSheetView(container: container)
                .presentationCornerRadius(OrderConstants.sheetCornerRadius)
        })
    }
    
    // MARK: - StickyHeader 구성
    private var topContents: some View {
        StickyHeader(
            headerOffset: $headerOffset,
            stickyModel: .init(orderHeader: OrderConstants.headerText), // 헤더에 표시될 텍스트 모델
            content: {
                middleCoffeeMenu // 스크롤 가능한 중간 커피 메뉴 목록
            },
            segment: {
                CustomSegment<OrderSegment, GreenSegmentStyle>(
                    selectedSegment: $viewModel.selectedSegment,
                    style: GreenSegmentStyle()
                ) // 주문 상단 세그먼트
            },
            subSegment: {
                OrderSubSegment(subSegmentType: $viewModel.subSegmentType) // 세부 세그먼트
            }
        )
    }
    
    // MARK: - 중간 커피 메뉴 뷰
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
