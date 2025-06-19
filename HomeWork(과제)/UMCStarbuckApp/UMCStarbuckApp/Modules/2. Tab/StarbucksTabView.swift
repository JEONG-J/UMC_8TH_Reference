//
//  TabView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import SwiftUI

/// 스타벅스 스타일의 커스텀 탭 뷰
struct StarbucksTabView: View {
    
    // MARK: - Property
    
    /// 현재 선택된 탭 상태
    @State var tabcase: TabCase = .home
    
    /// 의존성 주입을 위한 DI 컨테이너
    @EnvironmentObject var container: DIContainer
    
    // MARK: - Constants
    
    /// 뷰 내부에서 사용하는 상수 모음
    fileprivate enum StarbucksTabConstants {
        static let spacing: CGFloat = 10   // 탭 아이콘과 텍스트 사이 간격
    }
    
    // MARK: - Body
    
    var body: some View {
        // 네비게이션 경로를 DIContainer의 navigationRouter에서 관리
        NavigationStack(path: $container.navigationRouter.destination, root: {
            
            // SwiftUI의 TabView, 선택된 탭은 tabcase로 바인딩
            TabView(selection: $tabcase, content: {
                // TabCase enum의 모든 케이스를 기반으로 탭 구성
                ForEach(TabCase.allCases, id: \.rawValue) { tab in
                    Tab(
                        value: tab, // 선택 값으로 인식될 탭 식별자
                        
                        content: {
                            // 각 탭의 실제 콘텐츠 뷰
                            tabView(tab: tab)
                                .tag(tab) // 탭 식별자 지정
                        },
                        
                        label: {
                            // 탭 아이콘 및 텍스트 레이블
                            tabLabel(tab)
                        })
                }
            })
            .tint(Color.green02) // 선택된 탭의 포인트 색상 설정
            
            // 네비게이션 목적지에 따라 라우팅되는 화면 정의
            .navigationDestination(for: NavigationDestination.self, destination: { destination in
                NavigationRoutingView(destination: destination)
                    .environmentObject(container) // DIContainer 전달
            })
        })
    }
    
    /// 탭 레이블 (아이콘 + 텍스트)
    private func tabLabel(_ tab: TabCase) -> some View {
        VStack(spacing: StarbucksTabConstants.spacing, content: {
            tab.icon // TabCase에서 정의된 SF Symbol 이미지
                .renderingMode(.template) // 색상 적용 가능하게 설정
            
            Text(tab.rawValue) // Tab 이름
                .font(.mainTextRegular12)
                .foregroundStyle(Color.black01)
        })
    }
    
    /// 각 탭에 해당하는 콘텐츠 뷰
    @ViewBuilder
    private func tabView(tab: TabCase) -> some View {
        Group {
            switch tab {
            case .home:
                Text("home")   // 홈 탭 콘텐츠
            case .pay:
                Text("pay")    // 결제 탭 콘텐츠
            case .order:
                Text("order")  // 주문 탭 콘텐츠
            case .shop:
                Text("shop")   // 매장 탭 콘텐츠
            case .other:
                Text("other")  // 기타 탭 콘텐츠
            }
        }
    }
}

#Preview {
    StarbucksTabView(tabcase: .home)
        .environmentObject(DIContainer())
}
