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
        static let spacing: CGFloat = 10
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destination, root: {
            TabView(selection: $tabcase, content: {
                ForEach(TabCase.allCases, id: \.rawValue) { tab in
                    Tab(
                        value: tab,
                        content: {
                            tabView(tab: tab)
                                .tag(tab)
                        },
                        label: {
                            tabLabel(tab)
                        })
                }
            })
            .tint(Color.green02)
            .navigationDestination(for: NavigationDestination.self, destination: { destination in
                NavigationRoutingView(destination: destination)
                    .environmentObject(container)
            })
        })
    }
    
    /// 탭 레이블 (아이콘 + 텍스트)
    private func tabLabel(_ tab: TabCase) -> some View {
        VStack(spacing: StarbucksTabConstants.spacing, content: {
            tab.icon
                .renderingMode(.template)
            
            Text(tab.rawValue)
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
                HomeView(container: container)
            case .pay:
                Text("pay")
            case .order:
                OrderView()
            case .shop:
                Text("shop")
            case .other:
                Text("other")
            }
        }
        .environmentObject(DIContainer())
    }
}

#Preview {
    StarbucksTabView(tabcase: .home)
        .environmentObject(DIContainer())
}
