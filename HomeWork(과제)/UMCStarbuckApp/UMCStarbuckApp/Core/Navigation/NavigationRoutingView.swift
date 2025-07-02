//
//  NavigationRoutingView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import SwiftUI

/// 앱 내에서 특정 화면으로의 이동을 처리하는 라우팅 뷰입니다.
/// `NavigationDestination` enum 값을 기준으로 적절한 화면을 렌더링합니다.
struct NavigationRoutingView: View {
    
    /// DI 컨테이너: 의존성 주입을 위한 환경 객체
    @EnvironmentObject var container: DIContainer
    
    /// 현재 이동할 화면을 나타내는 상태값
    @State var destination: NavigationDestination
    
    // MARK: - Body
    var body: some View {
        Group {
            switch destination {
            case .signUp:
                // 회원가입 화면으로 이동
                SignUpView()
            case .coffeeDetail(let id):
                // 커피 상세 화면으로 이동 (id 전달)
                DetailCoffeeView(coffeeId: id)
            case .receiptView:
                // 영수증 리스트 화면으로 이동
                ReceiptView()
            case .findStoreView:
                // 매장 찾기 화면으로 이동 (DIContainer 전달)
                FindStoreView(container: container)
            }
        }
        // 각 하위 뷰에도 DIContainer를 공유해줌
        .environmentObject(container)
    }
}
